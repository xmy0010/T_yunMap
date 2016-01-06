//
//  TypeSettingView.h
//  T_yunMap
//
//  Created by T_yun on 16/1/6.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>

@interface TypeSettingView : UIControl

- (instancetype)initWithInsideViewFrame:(CGRect)frame inView:(UIView *)suView mapView:(MAMapView *)mapView;

- (void)show;

@end
