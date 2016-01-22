//
//  BaseSearchController.h
//  T_yunMap
//
//  Created by T_yun on 16/1/12.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseSearchController : UIViewController <AMapSearchDelegate>

@property (nonatomic, strong) NSString *stateButtonName;
@property (nonatomic, assign) SearchType searchType;
@property (nonatomic, strong) AMapGeoPoint *originLocation;
@property (nonatomic, strong) AMapGeoPoint *destinationLocation;

@property (nonatomic, strong) UITextField *destinationTF;
@property (nonatomic, strong) UITextField *originTF;




- (void)searchRoute;

@end
