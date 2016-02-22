//
//  XRMainViewController.m
//  GreatVideo
//
//  Created by Xinri on 15/10/13.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import "XRMainViewController.h"
#import "XRDailyViewController.h"
#import "XRCatergoryViewController.h"

@interface XRMainViewController ()
{
    UIButton *_selectButton;
    
    UITabBar *_tabBar;
}

@end

@implementation XRMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 隐藏原来的tabBar
    [self.tabBar setHidden:YES];
    
    // 添加底部选项栏
    [self addTabBar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideTabBar) name:@"hideTabBar" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showTabBar) name:@"showTabBar" object:nil];
}

#pragma mark - 接受到通知隐藏tabBar
- (void)hideTabBar
{
    [_tabBar setHidden:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)showTabBar
{
    [_tabBar setHidden:NO];
}

#pragma mark - 添加底部选项栏
- (void)addTabBar
{
    UITabBar *tabBar = [[UITabBar alloc] initWithFrame:CGRectMake(0, screen_height - 44, screen_width, 44)];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, screen_width / 2, 44)];
    [leftButton setTitle:@"每 日 精 选" forState:UIControlStateNormal];
    [leftButton.titleLabel setFont:[UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:15]];
    [leftButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [leftButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];

    [leftButton setTag:200];
    
    UIButton *lineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [lineButton setFrame:CGRectMake(screen_width / 2, 5, 1, 39)];
    [lineButton setBackgroundImage:[UIImage imageNamed:@"bg_top"] forState:UIControlStateNormal];
    [tabBar addSubview:lineButton];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(screen_width / 2, 0, screen_width / 2, 44)];
    [rightButton setTitle:@"往 期 分 类" forState:UIControlStateNormal];
    [rightButton.titleLabel setFont:[UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:15]];
    [rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [rightButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [rightButton setTag:201];
    
    [tabBar addSubview:leftButton];
    [tabBar addSubview:rightButton];
    
    XRDailyViewController *dailyViewController = [[XRDailyViewController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:dailyViewController];
    XRCatergoryViewController *categoryViewController = [[XRCatergoryViewController alloc] init];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:categoryViewController];
    
    self.viewControllers = @[nav1, nav2];
    
    [self.view addSubview:tabBar];
    _tabBar = tabBar;
    
    [leftButton setSelected:YES];
    _selectButton = leftButton;
}

- (void)buttonClicked:(UIButton *)sender
{
    [_selectButton setSelected:NO];
    [sender setSelected:YES];
    _selectButton = sender;
    [self setSelectedIndex:sender.tag - 200];
}

@end
