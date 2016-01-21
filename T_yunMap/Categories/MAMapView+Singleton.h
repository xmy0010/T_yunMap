//
//  MAMapView+Singleton.h
//  T_yunMap
//
//  Created by T_yun on 16/1/21.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface MAMapView (Singleton)

+(instancetype)shareMap;

@end
