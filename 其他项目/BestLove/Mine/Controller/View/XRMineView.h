//
//  XRMineView.h
//  BestLove
//
//  Created by Xinri on 15/10/16.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XRMineView : UIView

@property (strong, nonatomic) void(^backButtonClicked)();
@property (strong, nonatomic) void(^myCollectButtonClicked)();
@property (strong, nonatomic) void(^myCacheButtonClicked)();
@property (strong, nonatomic) void(^settingButtonClicked)();

@end
