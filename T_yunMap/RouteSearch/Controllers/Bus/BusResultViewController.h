//
//  BusResultViewController.h
//  T_yunMap
//
//  Created by T_yun on 16/2/3.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusResultViewController : UIViewController

@property (nonatomic, copy) NSString *originName;
@property (nonatomic, copy) NSString *destinationName;
@property (nonatomic, copy) NSString *strantegy;

@property (nonatomic, strong) AMapRoute *route;

@end
