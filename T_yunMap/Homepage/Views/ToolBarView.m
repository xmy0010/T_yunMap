//
//  ToolBarView.m
//  T_yunMap
//
//  Created by T_yun on 16/1/12.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "ToolBarView.h"
#import "TitleButton.h"

@implementation ToolBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"default_main_toolbar_bg_normal"]];
        [self setupSubviews];
        
    }
    return self;
}

- (void)setupSubviews {


    UIButton *routeButton = [self createButtonWithMarginX:self.xmy_width / 4 title:@"路线" imageName:@"default_generalsearch_va_introduce_icon_route"];
    [routeButton addTarget:self action:@selector(routeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
   
    
    UIButton *serviceButton = [self createButtonWithMarginX:self.xmy_width / 4 * 3 title:@"服务" imageName:@"danmuSetting"];
    [serviceButton addTarget:self action:@selector(serviceButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    

    
}

- (UIButton *)createButtonWithMarginX:(CGFloat)marginX title:(NSString *)title imageName:(NSString*)name {

    CGRect rect = CGRectMake(marginX, 0, self.xmy_width / 4, ToolBar_Height);
    TitleButton *button = [[TitleButton alloc] initWithFrame: rect];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed: name] forState:UIControlStateNormal];
  
    [self addSubview:button];
    
    return button;
}

#pragma mark - Acton

- (void)routeButtonPressed:(UIButton *)sender {

    if (_RouteButtonBlock) {
        _RouteButtonBlock(sender);
    }
    
}

- (void)serviceButtonPressed:(UIButton *)sender {

    if (_ServiceButtonBlock) {
        _ServiceButtonBlock(sender);
    }
}

@end
