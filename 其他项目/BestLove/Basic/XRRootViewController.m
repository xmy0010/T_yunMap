//
//  XRRootViewController.m
//  JustWalk
//
//  Created by Xinri on 15/10/12.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import "XRRootViewController.h"
#import "AppDelegate.h"

@interface XRRootViewController ()

@end

@implementation XRRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    if (!appDelegate.isNotice) {
        // 检测网络状态
        [self checkNetWork];
        appDelegate.notice = YES;
    }
}

#pragma mark - 设置导航栏样式
- (void)setNavStyle
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(screen_width / 2 - 50, 0, 100, 44)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont fontWithName:@"Lobster1.4" size:20]];
    [label setText:@"BestLove"];
    
    [self.navigationItem setTitleView:label];
}

#pragma mark - 检测网络状态
- (void)checkNetWork
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                [self showAlertWithString:@"网络状态未知!"];
                break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络
                [self showAlertWithString:@"当前没有网络,请检查您的网络状态!"];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 3G/4G
                [self showAlertWithString:@"您使用的是3G/4G,可能会产生较大的流量费用,确定继续吗?"];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
//                                [self showAlertWithString:@"您使用的是WIFI,请您放心使用"];
                break;
        }
    }];
}

#pragma mark - 弹窗
- (void)showAlertWithString:(NSString *)str
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [alertView show];
}

#pragma mark - 实现HUD指示器
- (void)showHudWithString:(NSString *)title frame:(CGRect)frame
{
    _hudView = [[UIView alloc] initWithFrame:frame];
    [_hudView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_hudView];
    
    // 实例化HUD空间
    _hud = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleExtraLight];
    // 文本的提示
    [_hud.textLabel setText:title];
    // 设置HUD显示在哪个视图上
    [_hud showInView:_hudView animated:YES];
    
    // 在加载状态中状态栏也应该显示一个网络加载的小菊花
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)hideHud
{
    // 关掉系统状态栏菊花
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    [UIView animateWithDuration:0.5 animations:^{
        [_hudView setAlpha:0];
    } completion:^(BOOL finished) {
        // 隐藏_hud
        [_hud dismissAnimated:YES];
        // 删掉蒙板
        [_hudView removeFromSuperview];
        _hud = nil;
        _hudView = nil;
    }];
}

@end
