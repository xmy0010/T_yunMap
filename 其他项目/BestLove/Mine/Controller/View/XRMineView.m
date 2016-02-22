//
//  XRMineView.m
//  BestLove
//
//  Created by Xinri on 15/10/16.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import "XRMineView.h"

@implementation XRMineView

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
#warning 清空缓存未完成
}

- (IBAction)backButtonClicked:(id)sender {
    _backButtonClicked();
}


@end
