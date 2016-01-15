//
//  ToolBarView.h
//  T_yunMap
//
//  Created by T_yun on 16/1/12.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToolBarView : UIView

@property (nonatomic, copy) void(^RouteButtonBlock)(UIButton *);
@property (nonatomic, copy) void(^ServiceButtonBlock)(UIButton *);

@end
