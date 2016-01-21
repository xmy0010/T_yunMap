//
//  WeatherResultViewController.m
//  T_yunMap
//
//  Created by T_yun on 16/1/19.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "WeatherResultViewController.h"
#import "ChoseWeatherBG.h"

@interface WeatherResultViewController ()


@property (nonatomic, weak) IBOutlet UILabel *province; //!< 省份名
@property (nonatomic, weak) IBOutlet UILabel *city; //!< 城市名
@property (nonatomic, weak) IBOutlet UILabel *weather; //!< 天气现象
@property (nonatomic, weak) IBOutlet UILabel *temperature; //!< 实时温度
@property (nonatomic, weak) IBOutlet UILabel *windDirection; //!< 风向
@property (nonatomic, weak) IBOutlet UILabel *windPower; //!< 风力，单位：级
@property (nonatomic, weak) IBOutlet UILabel *humidity; //!< 空气湿度
@property (nonatomic, weak) IBOutlet UILabel *reportTime; //!<数据发布时间

@property (weak, nonatomic) IBOutlet UIImageView *backgrounImageView;

@property (strong, nonatomic) UIImageView *tempImageView;

@end

@implementation WeatherResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self customNavigationItem];
    
    self.backgrounImageView.image = [ChoseWeatherBG choseWeatherBackgroundImageWithWeather:self.live.weather];
    
    self.province.text = self.live.province;
    self.city.text = self.live.city;
    self.reportTime.text = [NSString stringWithFormat:@"发布时间:%@", self.live.reportTime];
    self.weather.text = [NSString stringWithFormat:@"今日天气:%@", self.live.weather];
    self.temperature.text = [NSString stringWithFormat:@"%@°", self.live.temperature];
    self.windDirection.text = [NSString stringWithFormat:@"%@风", self.live.windDirection];
    self.windPower.text = [NSString stringWithFormat:@"风力指数%@级", self.live.windPower];
    self.humidity.text = [NSString stringWithFormat:@"空气湿度%@%%", self.live.humidity];
    
    
}

- (void)viewWillAppear:(BOOL)animated {

//    self.tempImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
////    [self.view addSubview: self.tempImageView];
//    _tempImageView.image = [UIImage imageNamed:@"weather_disaster_bg"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)customWeatherView {
//
//    WeatherBackgroundView *weatherView = [[WeatherBackgroundView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:weatherView];
//    weatherView.live = self.live;
//}

- (void)customNavigationItem{

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(rightItemPressed:)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark Action 

- (void)rightItemPressed:(UIBarButtonItem *)sender {

    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)setLive:(AMapLocalWeatherLive *)live {
    
    _live = live;

}

@end
