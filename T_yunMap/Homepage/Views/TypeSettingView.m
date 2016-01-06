//
//  TypeSettingView.m
//  T_yunMap
//
//  Created by T_yun on 16/1/6.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "TypeSettingView.h"

typedef NS_ENUM(NSInteger, HideType) {

    HideTypeFromOutside,  //点击self
    HideTypeFromInside    //点击imageView
};

@interface TypeSettingView ()

@property (weak, nonatomic) UIView *suView;
@property (weak, nonatomic) MAMapView *mapView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIButton *normalMapButton;
@property (strong, nonatomic) UIButton *trafficButton;
@property (strong, nonatomic) UIButton *sateliteMapButton;
@property (nonatomic, assign) CGRect subFrame;


@end

@implementation TypeSettingView

#pragma mark - UI

- (instancetype)initWithInsideViewFrame:(CGRect)frame inView:(UIView *)suView mapView:(MAMapView *)mapView{
   
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.suView = suView;
        self.mapView = mapView;
        self.subFrame = frame;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchDown];
        
        self.imageView = [[UIImageView alloc] initWithFrame:frame];
        [self addSubview:_imageView];
        UIImage *image = [UIImage imageNamed:@"default_main_longpresspopbutton_image_normal"];
        image = [image stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        self.imageView.image = image;
        self.imageView.userInteractionEnabled = YES;
        self.imageView.clipsToBounds = YES;
        [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)]];
        
        self.normalMapButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.sateliteMapButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.trafficButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.imageView addSubview:_normalMapButton];
        [self.imageView addSubview:_sateliteMapButton];
        [self.imageView addSubview:_trafficButton];
        
        [self.normalMapButton addTarget:self action:@selector(normalButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.sateliteMapButton addTarget:self action:@selector(sateliteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.trafficButton addTarget:self action:@selector(trafficButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self setButtonsFrame];
        [self setButtonsBackgroud];
    }
    
    return self;
}

- (void)setButtonsFrame {

    CGFloat buttonWidth = (_subFrame.size.width - Space_Normal_Eight * 7) / 3.;
    CGFloat buttonHeight = buttonWidth * 6 / 10;
    
    self.sateliteMapButton.frame = CGRectMake(Space_Normal_Eight * 2, Space_Normal_Eight * 2, buttonWidth, buttonHeight);
    self.normalMapButton.frame = CGRectMake(CGRectGetMaxX(_sateliteMapButton.frame) + Space_Normal_Eight, Space_Normal_Eight * 2, buttonWidth, buttonHeight);
    self.trafficButton.frame = CGRectMake(CGRectGetMaxX(_normalMapButton.frame) + Space_Normal_Eight, Space_Normal_Eight * 2, buttonWidth, buttonHeight);

}

- (void)setButtonsBackgroud {
    
    [self.normalMapButton setBackgroundImage:[UIImage imageNamed:@"default_main_map_2d_normal"] forState:UIControlStateNormal];
    [self.normalMapButton setBackgroundImage:[[UIImage imageNamed:@"default_main_map_2d_highlighted"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateSelected];
    

    [self.sateliteMapButton setBackgroundImage:[UIImage imageNamed:@"default_main_layer_satelite_normal"] forState:UIControlStateNormal];
    [self.sateliteMapButton setBackgroundImage:[[UIImage imageNamed:@"default_main_layer_satelite_highlighted"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateSelected];
    
    [self.trafficButton setBackgroundImage:[UIImage imageNamed: @"default_main_map_3d_normal"] forState:UIControlStateNormal];
    [self.trafficButton setBackgroundImage:[[UIImage imageNamed:@"default_main_map_3d_highlighted"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
}


#pragma mark - Action
- (void)show {

    [self.suView addSubview:self];
    
    self.imageView.alpha = 0;
    
    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:4 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.imageView.alpha = 1;
    } completion:^(BOOL finish){
        self.userInteractionEnabled = YES;
    }];
}

- (void)hide {
    
    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:4 options:UIViewAnimationOptionCurveLinear animations:^{
        self.imageView.alpha = 0;
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = YES;
    }];
    
    [self removeFromSuperview];
}

- (void)hideWithType:(HideType)type {

    
}

- (void)sateliteButtonPressed:(UIButton *)sender {
    
    _mapView.mapType = MAMapTypeSatellite;
    [self hide];
}

- (void)normalButtonPressed:(UIButton *)sender {
    
    _mapView.mapType = MAMapTypeStandard;
    [self hide];
}

- (void)trafficButtonPressed:(UIButton *)sender {
   
    if (_mapView.isShowTraffic) {
        
        _mapView.showTraffic = NO;
         [self hide];
    } else {
        
        _mapView.showTraffic = YES;
         [self hide];
    }
    
    
    
}



@end
