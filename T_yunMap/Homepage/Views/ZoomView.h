//
//  ZoomView.h
//  T_yunMap
//
//  Created by T_yun on 16/1/11.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZoomView : UIView


@property (nonatomic, strong) UIButton *zoomInButton;
@property (nonatomic, strong) UIButton *zoomOutButton;

@property (nonatomic, copy) void(^ZoomInButtonBlock)(UIButton *);
@property (nonatomic, copy) void(^ZoomOutButtonBlock)(UIButton *);

@end
