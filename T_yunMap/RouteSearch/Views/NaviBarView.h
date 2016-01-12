//
//  NaviBarView.h
//  T_yunMap
//
//  Created by T_yun on 16/1/12.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NaviBarView : UIView

@property (nonatomic, strong) UIButton *stateButton;

@property (nonatomic, copy) void(^BackButtonBlock)();
@property (nonatomic, copy) void(^StateButtonBlock)();

@end
