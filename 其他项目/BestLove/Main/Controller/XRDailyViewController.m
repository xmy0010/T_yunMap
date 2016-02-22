//
//  XRDailyViewController.m
//  GreatVideo
//
//  Created by Xinri on 15/10/13.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import "XRDailyViewController.h"
#import "XRAppDataCenter.h"
#import "XRDailyListModel.h"
#import "XRDailyModel.h"
#import "XRVideoModel.h"
#import "XRDailyTableViewCell.h"
#import "XRMineViewController.h"
#import "XRDetailViewController.h"
#import "XRRanklistViewController.h"
#import "YYKit.h"

static NSString *CellIdentifier = @"DailyCell";

@interface XRDailyViewController () <UITableViewDataSource, UITableViewDelegate, MJRefreshBaseViewDelegate>
{
     XRDailyListModel *_dailyListModel;
    
    UITableView *_tableView;
    
    UIButton *_leftButton;
    
    NSDictionary *_monthDict;
    
    // 声明一个刷新的控件
    MJRefreshHeaderView *_headerRef;
    MJRefreshFooterView *_footerRef;
    
    BOOL _leftButtonOpen;
    
    XRMineViewController *_mineViewController;
    XRDetailViewController *_detailViewController;
    XRRanklistViewController *_ranklistViewController;
}

@end

@implementation XRDailyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _monthDict = @{
                   @"1": @"Jan",
                   @"2": @"Feb",
                   @"3": @"Mar",
                   @"4": @"Apr",
                   @"5": @"May",
                   @"6": @"Jun",
                   @"7": @"Jul",
                   @"8": @"Aug",
                   @"9": @"Sep",
                   @"10": @"Oct",
                   @"11": @"Nov",
                   @"12": @"Dec",
                   };
    
    // 设置导航栏
    [self setNavStyle];
    
    // 设置左边按钮
    [self setLeftBarItem];
    
    [self setRanklistItem];
    
    [self showHudWithString:@"正在加载数据..." frame:CGRectMake(0, 64, screen_width, screen_height - 64 - 44)];
    [self loadDataModelWithUrlString:URL_Daily isClear:YES WithHandler:^{
        [self hideHud];
        [self setTableView];
        // 创建刷新控件
        [self createRefreshUI];
    }];
    
    [self scrollViewDidScroll:_tableView];
    
    // 接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeMineView) name:@"CloseMineView" object:nil];
}

#pragma mark - 关闭个人中心
- (void)closeMineView
{
    if (!_detailViewController) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showTabBar" object:nil];
    }
    
    [_mineViewController.view setTransform:CGAffineTransformIdentity];
    [UIView animateWithDuration:0.35 animations:^{
        [_mineViewController.view setTransform:CGAffineTransformTranslate(_mineViewController.view.transform, 0, -screen_height + 64)];
    } completion:^(BOOL finished) {
        [_mineViewController removeFromParentViewController];
        [_mineViewController.view removeFromSuperview];
        _mineViewController = nil;
    }];
    _leftButtonOpen = NO;
}

#pragma mark - 视图即将显示的方法
- (void)viewWillAppear:(BOOL)animated
{
    [_tableView setFrame:CGRectMake(0, 0, screen_width, screen_height)];
}

#pragma mark - 设置排行榜按钮
- (void)setRanklistItem
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(screen_width - 54, 0, 44, 44)];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"nowplaying"] forState:UIControlStateNormal];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"nowplayingSelected"] forState:UIControlStateHighlighted];
    
    [rightButton addTarget:self action:@selector(ranklistButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:rightButton]];
}

- (void)ranklistButtonClicked:(UIButton *)sender
{
    XRRanklistViewController *ranklistViewController = [[XRRanklistViewController alloc] init];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabBar" object:nil];
    
    [self.navigationController pushViewController:ranklistViewController animated:YES];
    _ranklistViewController = ranklistViewController;
}

#pragma mark - 设置右边按钮
- (void)setRightBarItem
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 44, 44)];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"miniplayer_btn_playlist_delete_normal"] forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:rightButton]];
}

- (void)rightButtonClicked:(UIButton *)sender
{
    [self setRanklistItem];
    if (_detailViewController) {
        if (!_mineViewController) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showTabBar" object:nil];
        }
        
        [_detailViewController.view removeFromSuperview];
        [_detailViewController removeFromParentViewController];
        _detailViewController = nil;
    }
}

#pragma mark - 创建刷新控件
- (void)createRefreshUI
{
    _footerRef = [MJRefreshFooterView footer];
    [_footerRef setDelegate:self];
    [_footerRef setScrollView:_tableView];
    
    _headerRef = [MJRefreshHeaderView header];
    [_headerRef setDelegate:self];
    [_headerRef setScrollView:_tableView];
}

#pragma mark - MJRefreshBaseViewDelegate回调方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    // 注意：
    // 不管是上拉刷新 还是 下拉加载更多 都需要进行网络请求
    if (refreshView == _footerRef) {
        //        NSLog(@"上拉加载更多");
        [self loadDataModelWithUrlString:_dailyListModel.nextPageUrl isClear:NO WithHandler:^{
            [_footerRef endRefreshing];
            [_tableView reloadData];
        }];
    } else {
        //        NSLog(@"下拉刷新数据");
        /*
         注意：控制数据不能在这里进行操作
         如果是下拉刷新数据的话 应该清空数组中的原有数据
         [_dataArray removeAllObjects];
         */
        [self loadDataModelWithUrlString:URL_Daily isClear:YES WithHandler:^{
            [_headerRef endRefreshing];
            [_tableView reloadData];
        }];
    }
}

#pragma mark - 设置导航栏左边按钮
- (void)setLeftBarItem
{
    // BestLove
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(10, 0, 100, 44)];
    [leftButton setTitle:@"today" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton.titleLabel setFont:[UIFont fontWithName:@"Lobster 1.4" size:13]];
    [leftButton setImage:[UIImage imageNamed:@"mvplayer_playlist_icon"] forState:UIControlStateNormal];
    [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -45, 0, 0)];
    [leftButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [leftButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
    
    [leftButton addTarget:self action:@selector(leftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:leftButton]];
    _leftButton = leftButton;
}

#pragma mark - 导航栏左边按钮的回调方法
- (void)leftButtonClicked:(UIButton *)sender
{
    if (!_leftButtonOpen) {
        XRMineViewController *mineViewController = [[XRMineViewController alloc] initWIthRootViewFrame:CGRectMake(0, 64, screen_width, screen_height - 64)];
        [self addChildViewController:mineViewController];
        [self.view addSubview:mineViewController.view];
        _mineViewController = mineViewController;
        [mineViewController.view setTransform:CGAffineTransformTranslate(mineViewController.view.transform, 0, -screen_height + 64)];
        [UIView animateWithDuration:0.35 animations:^{
            [mineViewController.view setTransform:CGAffineTransformIdentity];
        } completion:^(BOOL finished) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabBar" object:nil];
        }];
        _leftButtonOpen = YES;
    } else {
        if (!_detailViewController) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showTabBar" object:nil];
        }
        
        [_mineViewController.view setTransform:CGAffineTransformIdentity];
        [UIView animateWithDuration:0.35 animations:^{
            [_mineViewController.view setTransform:CGAffineTransformTranslate(_mineViewController.view.transform, 0, -screen_height + 64)];
        } completion:^(BOOL finished) {
            [_mineViewController removeFromParentViewController];
            [_mineViewController.view removeFromSuperview];
            _mineViewController = nil;
        }];
        _leftButtonOpen = NO;
    }
}

#pragma mark - 添加tableView
- (void)setTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, screen_width, screen_height - 64 - 44) style:UITableViewStyleGrouped];
//    [tableView setBackgroundColor:[UIColor redColor]];
    [tableView setDataSource:self];
    [tableView setDelegate:self];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    [tableView setShowsHorizontalScrollIndicator:NO];
//    [tableView setShowsVerticalScrollIndicator:NO];
    
    [tableView registerNib:[UINib nibWithNibName:@"XRDailyTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellIdentifier];
    
    [self.view addSubview:tableView];
    _tableView = tableView;
}

#pragma mark - UITableViewDataSource回调方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dailyListModel.dailyList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_dailyListModel.dailyList[section] videoList] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XRDailyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell setVideoModel:[_dailyListModel.dailyList[indexPath.section] videoList][indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    if (section == 0) {
//        return nil;
//    }
    XRDailyModel *dailyModel = _dailyListModel.dailyList[section];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:dailyModel.date.longValue / 1000];
//    NSLog(@"1296035591  = %@",confromTimesp);
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    NSDateComponents *cmp = [calendar components:unit fromDate:confromTimesp];
//    NSInteger nowYear = [cmp year];
    NSInteger nowMonth = [cmp month];
    NSInteger nowDay = [cmp day];
//    NSString *today = [NSString stringWithFormat:@"%ld%ld%ld", nowYear, nowMonth, nowDay];
//    NSLog(@"%@", today);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screen_width, 40)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:[NSString stringWithFormat:@"- %@. %ld -", _monthDict[[NSString stringWithFormat:@"%ld", (long)nowMonth]], (long)nowDay]];
    [label setFont:[UIFont fontWithName:@"Lobster 1.4" size:13]];
    
//    NSLog(@"%@", label.text);
    if (section == 0) {
        [_leftButton setTitle:@"today" forState:UIControlStateNormal];
    } else {
        [_leftButton setTitle:label.text forState:UIControlStateNormal];
    }
    
    return label;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat viewHeight = scrollView.height + scrollView.contentInset.top;
    for (XRDailyTableViewCell *cell in [_tableView visibleCells]) {
        CGFloat y = cell.centerY - scrollView.contentOffset.y;
        CGFloat p = y - viewHeight / 2;
        CGFloat scale = cos(p / viewHeight * 0.8) * 0.8 ;
        if (kiOS8Later) {
            [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
                cell.contentView.transform = CGAffineTransformMakeScale(scale, scale);
            } completion:NULL];
        } else {
            cell.contentView.transform = CGAffineTransformMakeScale(scale, scale);
        }
    }
}

#pragma mark - UITableViewDelegate回调方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_detailViewController) {
        // 设置右边按钮
        [self setRightBarItem];
        
        XRDetailViewController *detailViewController = [[XRDetailViewController alloc] initWIthRootViewFrame:CGRectMake(0, 64, screen_width, screen_height - 64) andModel:[_dailyListModel.dailyList[indexPath.section] videoList][indexPath.row]];
        [self addChildViewController:detailViewController];
        [self.view addSubview:detailViewController.view];
        _detailViewController = detailViewController;
        
        //    [_mineViewController.view setHidden:NO];
        //    [detailViewController.view setTransform:CGAffineTransformTranslate(_mineViewController.view.transform, screen_width / 2, screen_height / 2)];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabBar" object:nil];
        [detailViewController.view setTransform:CGAffineTransformTranslate(detailViewController.view.transform, 0, cell.frame.size.height)];
        [UIView animateWithDuration:0.35 animations:^{
            //        [detailViewController.view setTransform:CGAffineTransformIdentity];
            [detailViewController.view setTransform:CGAffineTransformIdentity];
        }];
    }
}

#pragma mark - 加载数据
- (void)loadDataModelWithUrlString:(NSString *)urlString isClear:(BOOL)clear WithHandler:(void(^)())handler
{
    [[XRAppDataCenter defaultCenter] getDailyDataWithUrlString:urlString isClear:clear Success:^(XRDailyListModel *dailyList) {
        _dailyListModel = dailyList;
        handler();
    } Failure:^(NSError *error) {
        [self loadDataModelWithUrlString:urlString isClear:clear WithHandler:handler];
    }];
}

- (void)dealloc
{
    [_headerRef free];
    [_footerRef free];
}

@end
