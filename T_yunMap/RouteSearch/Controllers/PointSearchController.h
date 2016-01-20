//
//  PointSearchController.h
//  T_yunMap
//
//  Created by T_yun on 16/1/13.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PointSearchController : UIViewController

@property (nonatomic, weak) MAMapView *mapView;

@property (nonatomic, copy) void(^PointSearchBlock)(AMapTip *);

@property (nonatomic, assign) SearchType searchType;

@end
