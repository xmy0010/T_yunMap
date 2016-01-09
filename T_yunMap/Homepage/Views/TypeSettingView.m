//
//  TypeSettingView.m
//  T_yunMap
//
//  Created by T_yun on 16/1/6.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "TypeSettingView.h"

#define Lable_Width 100
#define Lable_Height 40

typedef NS_ENUM(NSInteger, HideType) {

    HideTypeFromOutside,  //点击self
    HideTypeFromInside    //点击imageView
};

@interface TypeSettingView ()

@property (weak, nonatomic) UIView *suView;
@property (weak, nonatomic) MAMapView *mapView;
@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) UIButton *normalMapButton;
@property (strong, nonatomic) UIButton *nightButton;
@property (strong, nonatomic) UIButton *sateliteMapButton;

@property (nonatomic, strong) UILabel *trafficLable;
@property (nonatomic, strong) UISwitch *trafficSwitch;

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
        self.nightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.imageView addSubview:_normalMapButton];
        [self.imageView addSubview:_sateliteMapButton];
        [self.imageView addSubview:_nightButton];
        
        [self.normalMapButton addTarget:self action:@selector(normalButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.sateliteMapButton addTarget:self action:@selector(sateliteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.nightButton addTarget:self action:@selector(nightButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        self.trafficLable = [[UILabel alloc] init];
        self.trafficLable.text = @"交通状况";
        [self.imageView addSubview:_trafficLable];
        
        self.trafficSwitch = [[UISwitch alloc] init];
        [self.imageView addSubview:_trafficSwitch];
        self.trafficSwitch.on = NO;
        [self.trafficSwitch addTarget:self action:@selector(trafficSwitchAction:) forControlEvents:UIControlEventValueChanged];
        
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
    self.nightButton.frame = CGRectMake(CGRectGetMaxX(_normalMapButton.frame) + Space_Normal_Eight, Space_Normal_Eight * 2, buttonWidth, buttonHeight);
    
    self.trafficLable.frame = CGRectMake(CGRectGetMinX(_sateliteMapButton.frame), CGRectGetMaxY(_sateliteMapButton.frame) + 10, Lable_Width, Lable_Height);
    self.trafficSwitch.frame = CGRectMake(CGRectGetMaxX(_nightButton.frame) - Lable_Width, CGRectGetMinY(_trafficLable.frame), Lable_Width, Lable_Height);

}

- (void)setButtonsBackgroud {
    
    [self.normalMapButton setBackgroundImage:[UIImage imageNamed:@"default_main_map_2d_normal"] forState:UIControlStateNormal];
    [self.normalMapButton setBackgroundImage:[[UIImage imageNamed:@"default_main_map_3d_highlighted"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateSelected];
    

    [self.sateliteMapButton setBackgroundImage:[UIImage imageNamed:@"default_main_layer_satelite_normal"] forState:UIControlStateNormal];
    [self.sateliteMapButton setBackgroundImage:[[UIImage imageNamed:@"default_main_layer_satelite_highlighted"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateSelected];
    
    [self.nightButton setBackgroundImage:[UIImage imageNamed: @"default_navi_mode_night_normal"] forState:UIControlStateNormal];
    [self.nightButton setBackgroundImage:[[UIImage imageNamed:@"default_navi_mode_night_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
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

- (void)nightButtonPressed:(UIButton *)sender {
   
    _mapView.mapType = MAMapTypeStandardNight;
    [self hide];
    
}

- (void)trafficSwitchAction:(UISwitch *)sender {

    if (sender.on == YES && _mapView.isShowTraffic == NO) {
        
        _mapView.showTraffic = YES;
    } else {
        
        _mapView.showTraffic = NO;
    }
}

@end
