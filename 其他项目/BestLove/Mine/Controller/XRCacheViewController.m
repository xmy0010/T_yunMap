//
//  XRCacheViewController.m
//  BestLove
//
//  Created by Xinri on 15/10/16.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import "XRCacheViewController.h"
#import "XRDailyTableViewCell.h"
#import "XRCacheMovieDao.h"
#import "XRDetailViewController.h"

static NSString *CellIdentifier = @"DailyCell";

@interface XRCacheViewController () <UITableViewDataSource, UITableViewDelegate>
{
    XRCacheMovieDao *_Dao;
    
    NSMutableArray *_dataArray;
    
    XRDetailViewController *_detailViewController;
    
    UITableView *_tableView;
}

@end

@implementation XRCacheViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _Dao = [[XRCacheMovieDao alloc] init];
    
    // 从数据库加载数据
    _dataArray = [[_Dao getAllMovies] mutableCopy];
    
    // 设置滚动视图
    [self setTableView];
    
    // 设置导航栏右侧按钮
    [self setRightCancellBarItem];
}

#pragma mark - 设置导航栏右侧按钮
- (void)setRightCancellBarItem
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 44, 44)];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"recognize_history_delete"] forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(rightCancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:rightButton]];
}

- (void)rightCancelButtonClicked:(UIButton *)sender
{
    [_tableView setEditing:!_tableView.editing animated:YES];
}

#pragma mark - 设置滚动视图
- (void)setTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height) style:UITableViewStylePlain];
    [tableView setDataSource:self];
    [tableView setDelegate:self];
    
    [tableView registerNib:[UINib nibWithNibName:@"XRDailyTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellIdentifier];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screen_width, 60)];
    [label setText:@"- the end -"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont fontWithName:@"Lobster 1.4" size:18]];
    [tableView setTableFooterView:label];
}

#pragma mark - UITableViewDataSource回调方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XRDailyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell setVideoModel:_dataArray[indexPath.row]];
    
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
        
        XRDetailViewController *detailViewController = [[XRDetailViewController alloc] initWIthRootViewFrame:CGRectMake(0, 64, screen_width, screen_height - 64) andModel:_dataArray[indexPath.row]];
        [self addChildViewController:detailViewController];
        [self.view addSubview:detailViewController.view];
        _detailViewController = detailViewController;
        
        //    [_mineViewController.view setHidden:NO];
        //    [detailViewController.view setTransform:CGAffineTransformTranslate(_mineViewController.view.transform, screen_width / 2, screen_height / 2)];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [detailViewController.view setTransform:CGAffineTransformTranslate(detailViewController.view.transform, 0, cell.frame.size.height)];
        [UIView animateWithDuration:0.35 animations:^{
            //        [detailViewController.view setTransform:CGAffineTransformIdentity];
            [detailViewController.view setTransform:CGAffineTransformIdentity];
        }];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *savedName = [[_dataArray[indexPath.row] playUrl] componentsSeparatedByString:@"/"].lastObject;
    NSString *savedPath = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), savedName];
    NSFileManager * fileManager = [[NSFileManager alloc]init];
    [fileManager removeItemAtPath:savedPath error:nil];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_Dao removeMovie:_dataArray[indexPath.row]];
        [_dataArray removeObject:_dataArray[indexPath.row]];
        [_tableView reloadData];
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
    [_detailViewController.view removeFromSuperview];
    [_detailViewController removeFromParentViewController];
    _detailViewController = nil;
    
    [self setRightCancellBarItem];
}

@end
