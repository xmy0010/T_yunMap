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


    CGRect rect = CGRectMake(0, 0, self.xmy_width / 4, ToolBar_Height);
    TitleButton *routeButton = [[TitleButton alloc] initWithFrame: rect];
    [routeButton setTitle:@"路线" forState:UIControlStateNormal];
    [routeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [routeButton setImage:[UIImage imageNamed:@"default_generalsearch_va_introduce_icon_route"] forState:UIControlStateNormal];
    routeButton.titleRatio = 0.5;
    [routeButton addTarget:self action:@selector(routeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
 
    
    [self addSubview:routeButton];
    
}

#pragma mark - Acton

- (void)routeButtonPressed:(UIButton *)sender {

    
}


@end
