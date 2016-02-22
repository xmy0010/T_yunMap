//
//  XRPlayerSettingView.h
//  BestLove
//
//  Created by Xinri on 15/10/14.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XRVideoModel;

@interface XRPlayerSettingView : UIView

@property (strong, nonatomic) void(^backButtonClickedBlock)();
@property (strong, nonatomic) void(^playButtonClickedBlock)(BOOL);
@property (strong, nonatomic) void(^sliderButtonClickedBlock)(float);
@property (strong, nonatomic) void(^playDoneBlock)();
@property (strong, nonatomic) void(^collectButtonClicked)();
@property (strong, nonatomic) void(^shareButtonClicked)();
@property (strong, nonatomic) void(^changeTypeButtonClicked)();
@property (strong, nonatomic) void(^printScreenmButtonClicked)();

- (instancetype)initWithModel:(XRVideoModel *)model;

@end
