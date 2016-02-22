//
//  XRMineViewController.m
//  GreatVideo
//
//  Created by Xinri on 15/10/14.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import "XRMineViewController.h"
#import "XRMineView.h"
#import "XRCollectViewController.h"
#import "XRCacheViewController.h"
#import "XRSettingViewController.h"
#import "Common.h"

@interface XRMineViewController ()
{
    CGRect _frame;
}

@end

@implementation XRMineViewController

- (instancetype)initWIthRootViewFrame:(CGRect)frame
{
    if (self = [super init]) {
        _frame = frame;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    self.view = [[NSBundle mainBundle] loadNibNamed:@"XRMineView" owner:nil options:nil].firstObject;
    
    NSString *cacheString = [self cacheStringWithSDCache:[[SDImageCache sharedImageCache] getSize]];
    
    __weak XRMineView *mineView = (XRMineView *)self.view;
    [mineView setCacheString:cacheString];

    [mineView setBackButtonClicked:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CloseMineView" object:nil];
    }];
    [mineView setMyCollectButtonClicked:^{
        XRCollectViewController *collectViewController = [[XRCollectViewController alloc] init];
        [self.navigationController pushViewController:collectViewController animated:YES];
    }];
    [mineView setMyCacheButtonClicked:^{
        XRCacheViewController *cacheViewController = [[XRCacheViewController alloc] init];
        [self.navigationController pushViewController:cacheViewController animated:YES];
    }];
    [mineView setSettingButtonClicked:^{
        XRSettingViewController *settingViewController = [[XRSettingViewController alloc] init];
        [self.navigationController pushViewController:settingViewController animated:YES];
    }];
    [mineView setClearAllCacheButtonClicked:^{
        // 清除缓存 sdWebImage UIImageView+webCache
        [[SDImageCache sharedImageCache] clearDisk];
        [mineView setCacheString:@"0 B"];
    }];
    
    [self.view setFrame:_frame];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view setAlpha:0.9];
}

- (NSString *)cacheStringWithSDCache:(NSUInteger)cacheSize
{
    if (cacheSize == 0) {
        return @"0 B";
    }
    if (cacheSize > 0 && cacheSize < 1024) {
        return [NSString stringWithFormat:@"%d B", (int)cacheSize];
    } else if (cacheSize < 1024 * 1024) {
        return [NSString stringWithFormat:@"%.2f KB", cacheSize / 1024.0];
    } else if (cacheSize < 1024 * 1024 * 1024) {
        return [NSString stringWithFormat:@"%.2f MB", cacheSize / (1024.0 * 1024.0)];
    } else {
        return [NSString stringWithFormat:@"%.2f GB", cacheSize / (1024.0 * 1024.0 * 1024.0)];
    }
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

@end
