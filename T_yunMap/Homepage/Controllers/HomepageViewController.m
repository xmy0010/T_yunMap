//
//  HomepageViewController.m
//  T_yunMap
//
//  Created by T_yun on 16/1/5.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "HomepageViewController.h"
#import "UIView+XMYExtension.h"
#import <MAMapKit/MAMapKit.h>

static const CGFloat ButtonWidth_Height = 40.;

@interface HomepageViewController () <MAMapViewDelegate> {

    MAMapView *_mapView;
}

@end

@implementation HomepageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self customMap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customMap {

    [MAMapServices sharedServices].apiKey = Gaode_key;
    
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.xmy_width, self.view.xmy_height)];
    _mapView.delegate = self;
    
    [self.view addSubview:_mapView];
    
    
    
    [self customRightButtons];
}

- (void)customRightButtons {

    
    UIButton *mapTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_mapView addSubview:mapTypeButton];
    mapTypeButton.frame = CGRectMake(_mapView.xmy_width - 50, 100, ButtonWidth_Height, ButtonWidth_Height);
    mapTypeButton.backgroundColor = [UIColor redColor];
    [mapTypeButton addTarget:self action:@selector(mapTypeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
   
    UIButton *trafficButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_mapView addSubview:trafficButton];
    mapTypeButton.frame = CGRectMake(_mapView.xmy_width - 50, CGRectGetMaxX(mapTypeButton.frame) + 10 , ButtonWidth_Height, ButtonWidth_Height);
    trafficButton.backgroundColor = [UIColor redColor];
    [trafficButton addTarget:self action:@selector(trafficButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
}


#pragma mark - Action
- (void)mapTypeButtonPressed:(UIButton *)sender {

    
}

- (void)trafficButtonPressed:(UIButton *)sender {
    
    if (_mapView.isShowTraffic == YES) {
        _mapView.showTraffic = NO;
    } else {
        _mapView.showTraffic = YES;
    }
    
}

@end
