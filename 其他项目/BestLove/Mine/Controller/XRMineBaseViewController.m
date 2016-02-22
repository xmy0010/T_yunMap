//
//  XRMineBaseViewController.m
//  BestLove
//
//  Created by Xinri on 15/10/16.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import "XRMineBaseViewController.h"

@interface XRMineBaseViewController ()

@end

@implementation XRMineBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // 设置导航栏
    [self setNavStyle];
    
    // 设置返回按钮
    [self setLeftBarItem];
}

#pragma mark - 设置左侧返回按钮
- (void)setLeftBarItem
{
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"mvplayer_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)]];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
