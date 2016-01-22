//
//  CarDetailViewController.h
//  T_yunMap
//
//  Created by T_yun on 16/1/22.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarDetailViewController : UIViewController


@property (nonatomic, strong) NSArray *steps;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, copy) NSString *originName;
@property (nonatomic, copy) NSString *destinationName;

@end
