//
//  MAMapView+Singleton.m
//  T_yunMap
//
//  Created by T_yun on 16/1/21.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "MAMapView+Singleton.h"

@implementation MAMapView (Singleton)

+(instancetype)shareMap {
    static MAMapView *map = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        map = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height)];
    });
    
    return map;
}

@end
