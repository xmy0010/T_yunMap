//
//  ZoomView.m
//  T_yunMap
//
//  Created by T_yun on 16/1/11.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "ZoomView.h"
#import "UIView+XMYExtension.h"

@interface ZoomView ()


@end

@implementation ZoomView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    
    //镜头推近
    UIButton *zoomInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    zoomInButton.frame = CGRectMake(0, 0, self.xmy_width, self.xmy_height / 2);
    [zoomInButton setBackgroundImage:[UIImage imageNamed:@"default_main_zoombtn_zoomin_disable"] forState:UIControlStateDisabled];
    [zoomInButton setBackgroundImage:[UIImage imageNamed:@"default_main_zoombtn_zoomin_normal"] forState:UIControlStateNormal];
    [zoomInButton setBackgroundImage:[UIImage imageNamed:@"default_main_zoombtn_zoomin_highlighted"] forState:UIControlStateHighlighted];
    
    self.zoomInButton = zoomInButton;
    [zoomInButton addTarget:self action:@selector(zoomInButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:zoomInButton];
    
    //镜头拉远
    UIButton *zoomOutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    zoomOutButton.frame = CGRectMake(0, self.xmy_height / 2, self.xmy_width, self.xmy_height / 2);
    [zoomOutButton setBackgroundImage:[UIImage imageNamed:@"default_main_zoombtn_zoomout_disable"] forState:UIControlStateDisabled];
    [zoomOutButton setBackgroundImage:[UIImage imageNamed:@"default_main_zoombtn_zoomout_normal"] forState:UIControlStateNormal];
    [zoomOutButton setBackgroundImage:[UIImage imageNamed:@"default_main_zoombtn_zoomout_highlighted"] forState:UIControlStateHighlighted];
    
    self.zoomOutButton = zoomOutButton;
    [zoomOutButton addTarget:self action:@selector(zoomOutButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:zoomOutButton];
    
}

#pragma mark - Action

- (void)zoomInButtonPressed:(UIButton *)sender {

    if (_ZoomInButtonBlock) {
        
        _ZoomInButtonBlock(sender);
    }
}

- (void)zoomOutButtonPressed:(UIButton *)sender {

    if (_ZoomOutButtonBlock) {
        
        _ZoomOutButtonBlock(sender);
    }
    
}

@end
