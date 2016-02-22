//
//  XRRanklistViewController.m
//  GreatVideo
//
//  Created by Xinri on 15/10/14.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import "XRRanklistViewController.h"
#import "XRRanklistTopView.h"
#import "XRAppDataCenter.h"
#import "XRDailyTableViewCell.h"
#import "XRCategoryDatailModel.h"
#import "XRDetailViewController.h"
#import "YYKit.h"

static NSString *CellIdentifier = @"DailyCell";

@interface XRRanklistViewController () <XRRanklistTopViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
    XRCategoryDatailModel *_rankList;
    
    UITableView *_tableView;
    
    XRDetailViewController *_detailViewController;
}

@end

@implementation XRRanklistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self setPerNav];
    
    // 设置返回按钮
    [self setLeftBarItem];
    
    // 设置顶部选项栏
    [self setTopBar];
    
    // 加载数据
    [self showHudWithString:@"正在加载数据..." frame:CGRectMake(0, 64, screen_width, screen_height - 64 - 44)];
    [self loadDataModelWithUrlString:URL_Ranklist WithSortType:@"weekly" WithHandler:^{
        [self hideHud];
        [self setTableView];
    }];
}

- (void)setPerNav
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    [label setCenter:self.navigationController.navigationBar.center];
    [label setText:@"排 行 榜"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:17]];
    [self.navigationItem setTitleView:label];
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
    if (_detailViewController) {
    [self setPerNav];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showTabBar" object:nil];
    
    [_detailViewController.view removeFromSuperview];
    [_detailViewController removeFromParentViewController];
    _detailViewController = nil;
    }
}

#pragma mark - 添加tableView
- (void)setTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 44, screen_width, screen_height - 64 - 44) style:UITableViewStylePlain];
    //    [tableView setBackgroundColor:[UIColor redColor]];
    [tableView setDataSource:self];
    [tableView setDelegate:self];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screen_width, 60)];
    [label setText:@"- the end -"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont fontWithName:@"Lobster 1.4" size:18]];
    [tableView setTableFooterView:label];
    //    [tableView setShowsHorizontalScrollIndicator:NO];
    //    [tableView setShowsVerticalScrollIndicator:NO];
    
//    [tableView registerNib:[UINib nibWithNibName:@"XRDailyTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellIdentifier];
    
    [self.view addSubview:tableView];
    _tableView = tableView;
}

#pragma mark - UITableViewDataSource回调方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _rankList.videoList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    XRDailyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    XRDailyTableViewCell *cell = [[NSBundle mainBundle] loadNibNamed:@"XRDailyTableViewCell" owner:nil options:nil].firstObject;
    [cell setVideoModel:_rankList.videoList[indexPath.row]];
    [cell setRankPosition:indexPath.row + 1];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

#pragma mark - UITableViewDelegate回调方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_detailViewController) {
        [self setNavStyle];
        [self setRightBarItem];
        
        XRDetailViewController *detailViewController = [[XRDetailViewController alloc] initWIthRootViewFrame:CGRectMake(0, 64, screen_width, screen_height - 64) andModel:_rankList.videoList[indexPath.row]];
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
- (void)loadDataModelWithUrlString:(NSString *)urlString WithSortType:(NSString *)sortType WithHandler:(void(^)())handler
{
    [[XRAppDataCenter defaultCenter] getRanklistDataWithUrlString:urlString WithSortType:sortType Success:^(XRCategoryDatailModel *ranklist) {
//        NSLog(@"%@", ranklist);
        _rankList = ranklist;
        handler();
    } Failure:^(NSError *error) {
        [self loadDataModelWithUrlString:urlString WithSortType:sortType WithHandler:handler];
    }];
}


#pragma mark - XRRanklistTopViewDelegate回调方法
- (void)ranklistButtonClicked:(NSString *)sortType
{
    if ([sortType isEqualToString:@"周排行"]) {
        [self loadDataModelWithUrlString:URL_Ranklist WithSortType:@"weekly" WithHandler:^{
            [_tableView setContentOffset:CGPointMake(0, 0)];
            [_tableView reloadData];
        }];
    } else if ([sortType isEqualToString:@"月排行"]) {
        [self loadDataModelWithUrlString:URL_Ranklist WithSortType:@"monthly" WithHandler:^{
            [_tableView setContentOffset:CGPointMake(0, 0)];
            [_tableView reloadData];
        }];
    } else if ([sortType isEqualToString:@"总排行"]) {
        [self loadDataModelWithUrlString:URL_Ranklist WithSortType:@"historical" WithHandler:^{
            [_tableView setContentOffset:CGPointMake(0, 0)];
            [_tableView reloadData];
        }];
    }
}

#pragma mark - 设置顶部选项栏
- (void)setTopBar
{
    XRRanklistTopView *topView = [[NSBundle mainBundle] loadNibNamed:@"RanklistTopView" owner:nil options:nil].firstObject;
    [topView setFrame:CGRectMake(0, 0, screen_width, 44)];
    [topView setBackgroundColor:[UIColor colorWithRed:246 / 255.0 green:246 / 255.0 blue:246 / 255.0 alpha:0.5]];
    
    [topView setDelegate:self];
    
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 64, screen_width, 44)];
    [navBar addSubview:topView];
    
    [self.view addSubview:navBar];
}

#pragma mark - 设置左侧返回按钮
- (void)setLeftBarItem
{
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"mvplayer_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)]];
}

- (void)back
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showTabBar" object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
