//
//  XRCatergoryViewController.m
//  GreatVideo
//
//  Created by Xinri on 15/10/13.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import "XRCatergoryViewController.h"
#import "XRAppDataCenter.h"
#import "XRCategoryModel.h"
#import "XRCategoryDetailViewController.h"
#import "XRRanklistViewController.h"
#import "XRMineViewController.h"

@interface XRCatergoryViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    
    NSArray *_dataArray;
    
    BOOL _flag;
    
    BOOL _leftButtonOpen;
    
    XRMineViewController *_mineViewController;
}

@end

@implementation XRCatergoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setNavStyle];
    
    // 设置导航栏按钮
    [self setLeftAndRightBarItem];
    
    // 加载数据
    [self loadDataModelWithHandler:^{
        // 添加集合视图
        [self setCollectionView];
        
        // 添加个人中心
        [self addMineView];
    }];
    
    // 接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeMineView) name:@"CloseMineView" object:nil];
}

#pragma mark - 添加个人中心
- (void)addMineView
{
    XRMineViewController *mineViewController = [[XRMineViewController alloc] initWIthRootViewFrame:CGRectMake(0, 64, screen_width, screen_height - 64)];
    [self addChildViewController:mineViewController];
    [self.view addSubview:mineViewController.view];
    _mineViewController = mineViewController;
    [_mineViewController.view setHidden:YES];
}

#pragma mark - 关闭个人中心
- (void)closeMineView
{
    if (_mineViewController) {
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

#pragma mark - 视图即将显示的方法
- (void)viewWillAppear:(BOOL)animated
{
    if (_flag) {
        [_collectionView setFrame:CGRectMake(0, 0, screen_width, screen_height - 44)];
        _flag = NO;
    } else {
        [_collectionView setFrame:CGRectMake(0, 0, screen_width, screen_height)];
    }
}

#pragma mark - 加载数据
- (void)loadDataModelWithHandler:(void(^)())handler
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    
    [[XRAppDataCenter defaultCenter] getCategoryDataWithUrlString:URL_Category Success:^(NSArray *catrgotryArray) {
        _dataArray = catrgotryArray;
        handler();
    } Failure:^(NSError *error) {
        [self loadDataModelWithHandler:handler];
    }];
}

#pragma mark - 添加集合视图
- (void)setCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, screen_width, screen_height - 44 - 64) collectionViewLayout:layout];
//    [collectionView setBackgroundColor:[UIColor cyanColor]];
    [collectionView setBackgroundColor:[UIColor clearColor]];
    [collectionView setDataSource:self];
    [collectionView setDelegate:self];
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionCell"];
    
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
}

#pragma marl - UICollectionViewDataSource回调方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CollectionCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width / 2 - 10, screen_width / 2 - 10)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[_dataArray[indexPath.row] bgPicture]]];
    [cell.contentView addSubview:imageView];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width / 2 - 10, screen_width / 2 - 10)];
    [bgView setBackgroundColor:[UIColor blackColor]];
    [bgView setAlpha:0.5];
    [cell.contentView addSubview:bgView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screen_width / 2 - 10, screen_width / 2 - 10)];
    [titleLabel setText:[NSString stringWithFormat:@"#%@", [_dataArray[indexPath.row] name]]];
    [titleLabel setFont:[UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:17]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [cell.contentView addSubview:titleLabel];
                        
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(screen_width / 2 - 10, screen_width / 2 - 10);
}


//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark - UICollectionViewCell被选中时调用的方法
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XRCategoryDetailViewController *categoryViewController = [[XRCategoryDetailViewController alloc] init];
    [categoryViewController setCategoryName:[_dataArray[indexPath.row] name]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabBar" object:nil];
    
    [self.navigationController pushViewController:categoryViewController animated:YES];
    _flag = YES;
}

#pragma mark - 设置导航栏按钮
- (void)setLeftAndRightBarItem
{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(10, 0, 70, 44)];
    [leftButton setImage:[UIImage imageNamed:@"mvplayer_playlist_icon"] forState:UIControlStateNormal];
    [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -45, 0, 0)];
    
    [leftButton addTarget:self action:@selector(leftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(screen_width - 54, 0, 44, 44)];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"nowplaying"] forState:UIControlStateNormal];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"nowplayingSelected"] forState:UIControlStateHighlighted];
    
    [rightButton addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:leftButton]];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:rightButton]];
}

- (void)leftButtonClicked:(UIButton *)sender
{
    if (!_leftButtonOpen) {
        if (!_mineViewController) {
            [self addMineView];
        }
        [_mineViewController.view setHidden:NO];
        [_mineViewController.view setTransform:CGAffineTransformTranslate(_mineViewController.view.transform, 0, -screen_height + 64)];
        [UIView animateWithDuration:0.35 animations:^{
            [_mineViewController.view setTransform:CGAffineTransformIdentity];
        } completion:^(BOOL finished) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabBar" object:nil];
        }];
        _leftButtonOpen = YES;
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showTabBar" object:nil];
        [_mineViewController.view setTransform:CGAffineTransformIdentity];
        [UIView animateWithDuration:0.35 animations:^{
            [_mineViewController.view setTransform:CGAffineTransformTranslate(_mineViewController.view.transform, 0, -screen_height + 64)];
        } completion:^(BOOL finished) {
            [_mineViewController.view setHidden:YES];
            _mineViewController = nil;
        }];
        _leftButtonOpen = NO;
    }
}

- (void)rightButtonClicked:(UIButton *)sender
{
    XRRanklistViewController *ranklistViewController = [[XRRanklistViewController alloc] init];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabBar" object:nil];
    
    [self.navigationController pushViewController:ranklistViewController animated:YES];
}

@end
