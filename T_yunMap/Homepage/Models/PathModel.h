//
//  PathModel.h
//  T_yunMap
//
//  Created by T_yun on 16/1/9.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "BaseModel.h"

@interface PathModel : BaseModel

@property (nonatomic, assign) long long distance;
@property (nonatomic, assign) long long duration;
@property (nonatomic, strong) NSMutableString *strategy;
@property (nonatomic, strong) NSArray *steps;
@property (nonatomic, assign) CGFloat tolls;
@property (nonatomic, assign) CGFloat tollDistance;

@end
