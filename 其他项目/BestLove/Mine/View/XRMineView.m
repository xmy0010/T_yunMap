//
//  XRMineView.m
//  BestLove
//
//  Created by Xinri on 15/10/16.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import "XRMineView.h"

@interface XRMineView()

@property (weak, nonatomic) IBOutlet UIButton *cacheButton;

@end

@implementation XRMineView

- (void)setCacheString:(NSString *)cacheString
{
    [_cacheButton setTitle:[NSString stringWithFormat:@"清空所有缓存(不包括视频) %@", cacheString] forState:UIControlStateNormal];
}

- (IBAction)myCollectButtonClicked:(id)sender {
    _myCollectButtonClicked();
}

- (IBAction)myCacheButtonClicked:(id)sender {
    _myCacheButtonClicked();
}

- (IBAction)settingButtonClicked:(id)sender {
    _settingButtonClicked();
}

- (IBAction)removeAllCacheButtonClicked:(id)sender {
    _clearAllCacheButtonClicked();
}

- (IBAction)backButtonClicked:(id)sender {
    _backButtonClicked();
}


@end
