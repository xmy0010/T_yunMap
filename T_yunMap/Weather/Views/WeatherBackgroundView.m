//
//  WeatherBackgroundView.m
//  T_yunMap
//
//  Created by T_yun on 16/1/18.
//  weakright © 2016年 T_yun. All rights reserved.
//

#import "WeatherBackgroundView.h"
#import "ChoseWeatherBG.h"

@interface WeatherBackgroundView ()


@property (nonatomic, weak) IBOutlet UILabel *province; //!< 省份名
@property (nonatomic, weak) IBOutlet UILabel *city; //!< 城市名
@property (nonatomic, weak) IBOutlet UILabel *weather; //!< 天气现象
@property (nonatomic, weak) IBOutlet UILabel *temperature; //!< 实时温度
@property (nonatomic, weak) IBOutlet UILabel *windDirection; //!< 风向
@property (nonatomic, weak) IBOutlet UILabel *windPower; //!< 风力，单位：级
@property (nonatomic, weak) IBOutlet UILabel *humidity; //!< 空气湿度
@property (nonatomic, weak) IBOutlet UILabel *reportTime; //!<数据发布时间

@property (weak, nonatomic) IBOutlet UIImageView *backgrounImageView;


@end


@implementation WeatherBackgroundView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"WeatherBackgroundView" owner:nil options:nil] lastObject];
    }
    return self;
}

- (void)setLive:(AMapLocalWeatherLive *)live {

    _live = live;
    self.province.text = live.province;
    self.city.text = live.city;
    self.reportTime.text = live.reportTime;
    self.weather.text = live.weather;
    self.temperature.text = live.temperature;
    self.windDirection.text = live.windDirection;
    self.windPower.text = live.windPower;
    self.humidity.text = live.humidity;
    
    self.backgrounImageView.image = [ChoseWeatherBG choseWeatherBackgroundImageWithWeather:self.weather.text];
}


@end
