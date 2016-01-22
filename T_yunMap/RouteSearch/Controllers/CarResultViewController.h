//
//  CarResultViewController.h
//  T_yunMap
//
//  Created by T_yun on 16/1/22.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarResultViewController : UIViewController

@property (nonatomic, strong) AMapRoute *aMapRoute;
@property (nonatomic, copy) NSString *originName;
@property (nonatomic, copy) NSString *destinationName;

@end
