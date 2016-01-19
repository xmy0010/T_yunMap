//
//  WeatherResultViewController.m
//  T_yunMap
//
//  Created by T_yun on 16/1/19.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "WeatherResultViewController.h"
#import "WeatherBackgroundView.h"

@interface WeatherResultViewController ()

@end

@implementation WeatherResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self customWeatherView];
    
    [self customNavigationItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customWeatherView {

    WeatherBackgroundView *weatherView = [[WeatherBackgroundView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:weatherView];
    weatherView.live = self.live;
}

- (void)customNavigationItem{

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(rightItemPressed:)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark Action 

- (void)rightItemPressed:(UIBarButtonItem *)sender {

    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
