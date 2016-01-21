//
//  ChoseWeatherBG.m
//  T_yunMap
//
//  Created by T_yun on 16/1/18.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "ChoseWeatherBG.h"

@implementation ChoseWeatherBG



+ (UIImage *)choseWeatherBackgroundImageWithWeather:(NSString *)weather {
    //阴
    NSArray *clear = @[@"晴"];
    NSArray *cloudy = @[@"多云"];
    
    NSArray *stom = @[@"雷阵雨并伴有冰雹",
                      @"雷阵雨"];
    NSArray *rain = @[@"阵雨",
                      @"雨夹雪",
                      @"小雨",
                      @"中雨",
                      @"大雨",
                      @"暴雨",
                      @"大暴雨",
                      @"特大暴雨",
                      @"大暴雨-特大暴雨",
                      @"暴雨-大暴雨",
                      @"大雨-暴雨",
                      @"中雨-大雨",
                      @"小雨-中雨",
                      @"冻雨"];
    NSArray *snow = @[@"小雪",
                      @"中雪",
                      @"大雪",
                      @"暴雪",
                      @"若高吹雪",
                      @"大雪-暴雪",
                      @"中雪-大雪",
                      @"小雪-中雪"];
    NSArray *foggy = @[@"雾",
                      @"沙尘暴",
                      @"扬沙",
                      @"浮尘",
                      @"强沙尘暴",
                      @"清霾",
                      @"霾"];
    
    NSArray *imageNames = @[@"clear_d_portrait.jpg",
                            @"cloudy_d_portrait.jpg",
                            @"storm_d_portrait.jpg",
                            @"rain_d_portrait.jpg",
                            @"snow_d_portrait.jpg",
                            @"foggy_d_portrait.jpg",
                            @"weather_disaster_bg.jpg"];
    
    
    NSArray *weatherArrays = @[clear, cloudy, rain, stom, snow, foggy];
    
    for (int index = 0; index < weatherArrays.count; index++) {

        if ([weatherArrays[index] containsObject:weather]) {
            
            return [UIImage imageNamed: imageNames[index]];
        }
    }
    
    return [UIImage imageNamed:[imageNames lastObject]];
}

@end
