//
//  CustomAnnotationView.h
//  T_yunMap
//
//  Created by T_yun on 16/1/7.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "CustomCalloutView.h"

@interface CustomAnnotationView : MAAnnotationView

@property (nonatomic, readonly) CustomCalloutView *calloutView;

@end
