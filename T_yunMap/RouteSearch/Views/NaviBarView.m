//
//  NaviBarView.m
//  T_yunMap
//
//  Created by T_yun on 16/1/12.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "NaviBarView.h"
#import "TitleButton.h"

@interface NaviBarView () {

}


@end

@implementation NaviBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    

    TitleButton *backButton = [[TitleButton alloc] init];
    backButton.frame = CGRectMake(0, 0, ToolBar_Height * 2, ToolBar_Height);
    [backButton setImage:[UIImage imageNamed:@"default_path_demo_left_normal"] forState:UIControlStateNormal];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    backButton.titleRatio = 0.5;
    
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backButton];
    
    
   
    CGFloat width = ToolBar_Height * 102 / 64;
    CGFloat marginX = self.xmy_width - Space_Normal_Eight - width;
    CGFloat marginY = 0;
   
    UIButton *stateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    stateButton.frame = CGRectMake(marginX, marginY, width, ToolBar_Height);
    stateButton.backgroundColor = [UIColor redColor];
    self.stateButton = stateButton;
    
    [self addSubview:stateButton];
    [stateButton addTarget:self action:@selector(stateButtonPressed:) forControlEvents:UIControlEventTouchDown];
}

#pragma mark - Action

- (void)backButtonPressed:(UIButton *)sender {
    
    if (_BackButtonBlock) {
        _BackButtonBlock();
    }

}

- (void)stateButtonPressed:(UIButton *)sender {

    if (_StateButtonBlock) {
        _StateButtonBlock();
    }
    
}


@end
