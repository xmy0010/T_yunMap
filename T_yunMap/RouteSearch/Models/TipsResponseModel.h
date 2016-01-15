//
//  TipsResponseModel.h
//  T_yunMap
//
//  Created by T_yun on 16/1/14.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "BaseModel.h"


//高德已有类似的model  AMapTip  
@interface TipsResponseModel : BaseModel

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *adcode;
@property (nonatomic, copy) NSString *district;
@property (nonatomic, strong) AMapGeoPoint *location;

@end
