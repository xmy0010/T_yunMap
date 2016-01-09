//
//  RouteModel.h
//  T_yunMap
//
//  Created by T_yun on 16/1/9.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "BaseModel.h"

@interface RouteModel : BaseModel

@property (nonatomic, strong) AMapGeoPoint *origin;
@property (nonatomic, strong) AMapGeoPoint *destination;
@property (nonatomic, assign) CGFloat taxiCost;
@property (nonatomic, strong) AMapPath *paths;
@property (nonatomic, strong) id transits;

@end
