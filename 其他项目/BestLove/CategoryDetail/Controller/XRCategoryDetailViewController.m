//
//  XRCategoryDetailViewController.m
//  GreatVideo
//
//  Created by 鑫 李 on 15/10/13.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import "XRCategoryDetailViewController.h"
#import "XRAppDataCenter.h"
#import "XRTopView.h"
#import "XRDailyTableViewCell.h"
#import "XRCategoryDatailModel.h"
#import "XRDetailViewController.h"
#import "YYKit.h"

static NSString *CellIdentifier = @"DailyCell";

@interface XRCategoryDetailViewController () <UITableViewDataSource, UITableViewDelegate, MJRefreshBaseViewDelegate, XRTopViewDelegate>
{
    UITableView *_tableView;
    XRCategoryDatailModel *_categoryDetailModel;
    
    // 声明一个刷新的控件
    MJRefreshHeaderView *_headerRef;
    MJRefreshFooterView *_footerRef;
    
    NSString *_sortType;
    
    XRDetailViewController *_detailViewController;
}

@end

@implementation XRCategoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.navigationController.navigationBar setTranslucent:NO];
    [self.tabBarController.tabBar setHidden:YES];
    [self setNavStyle];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _sortType = @"date";
    
    // 设置返回按钮
    [self setLeftBarItem];
    
    // 设置顶部选项栏
    [self setTopBar];
    
    // 加载数据
    [self showHudWithString:@"正在加载数据..." frame:CGRectMake(0, 64, screen_width, screen_height - 64 - 44)];
    [self loadDataModelWithUrlString:URL_Category_sort WithCategoryName:_categoryName WithSortType:@"date" isClear:YES WithHandler:^{
        [self hideHud];
        [self setTableView];
        
        // 创建刷新控件
        [self createRefreshUI];
    }];
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
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showTabBar" object:nil];
        
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


#pragma mark - 添加tableView
- (void)setTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 44, screen_width, screen_height - 64 - 44) style:UITableViewStylePlain];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _categoryDetailModel.videoList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XRDailyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell setVideoModel:_categoryDetailModel.videoList[indexPath.row]];
    
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
        // 设置右边按钮
        [self setRightBarItem];
        
        XRDetailViewController *detailViewController = [[XRDetailViewController alloc] initWIthRootViewFrame:CGRectMake(0, 64, screen_width, screen_height - 64) andModel:_categoryDetailModel.videoList[indexPath.row]];
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

#pragma mark - MJRefreshBaseViewDelegate回调方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    // 注意：
    // 不管是上拉刷新 还是 下拉加载更多 都需要进行网络请求
    if (refreshView == _footerRef) {
        //        NSLog(@"上拉加载更多");
        [self loadDataModelWithUrlString:_categoryDetailModel.nextPageUrl WithCategoryName:nil WithSortType:nil  isClear:NO WithHandler:^{
            [_tableView reloadData];
            [_footerRef endRefreshing];
        }];
    } else {
        //        NSLog(@"下拉刷新数据");
        /*
         注意：控制数据不能在这里进行操作
         如果是下拉刷新数据的话 应该清空数组中的原有数据
         [_dataArray removeAllObjects];
         */
        [self loadDataModelWithUrlString:URL_Category_sort WithCategoryName:_categoryName WithSortType:@"date" isClear:YES WithHandler:^{
            [_tableView reloadData];
            [_headerRef endRefreshing];
        }];
    }
}

#pragma mark - 设置顶部选项栏
- (void)setTopBar
{
    XRTopView *topView = [[NSBundle mainBundle] loadNibNamed:@"TopView" owner:nil options:nil].firstObject;
    [topView setFrame:CGRectMake(0, 0, screen_width, 44)];
    [topView setBackgroundColor:[UIColor colorWithRed:246 / 255.0 green:246 / 255.0 blue:246 / 255.0 alpha:0.5]];
    
    [topView setDelegate:self];
    
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 64, screen_width, 44)];
    [navBar addSubview:topView];
    
    [self.view addSubview:navBar];
}

#pragma mark - XRTopViewDelegate回调方法
- (void)sortButtonClicked:(NSString *)sortType
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ClearCategoryDetailModel" object:nil];
    if ([sortType isEqualToString:@"排序(分享)"]) {
//        NSLog(@"%@", sortType);
        [self loadDataModelWithUrlString:URL_Category_sort WithCategoryName:_categoryName WithSortType:@"shareCount" isClear:YES WithHandler:^{
            [_tableView setContentOffset:CGPointMake(0, 0)];
            [_tableView reloadData];
        }];
    } else {
//        NSLog(@"%@", sortType);
        [self loadDataModelWithUrlString:URL_Category_sort WithCategoryName:_categoryName WithSortType:@"date" isClear:YES WithHandler:^{
            [_tableView setContentOffset:CGPointMake(0, 0)];
            [_tableView reloadData];
        }];
    }
}

#pragma mark - 加载数据
- (void)loadDataModelWithUrlString:(NSString *)urlString WithCategoryName:(NSString *)categoryName WithSortType:(NSString *)sortType isClear:(BOOL)clear WithHandler:(void(^)())handler
{
    [[XRAppDataCenter defaultCenter] getCategoryDetailDataWithUrlString:urlString WithCategoryName:categoryName WithSortType:sortType isClear:clear Success:^(XRCategoryDatailModel *categoryDetail) {
        _categoryDetailModel = categoryDetail;
        handler();
    } Failure:^(NSError *error) {
        [self loadDataModelWithUrlString:urlString WithCategoryName:categoryName WithSortType:sortType isClear:clear WithHandler:handler];
    }];
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

- (void)dealloc
{
    [_headerRef free];
    [_footerRef free];
}

@end
