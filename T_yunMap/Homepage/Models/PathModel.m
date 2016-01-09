//
//  PathModel.m
//  T_yunMap
//
//  Created by T_yun on 16/1/9.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "PathModel.h"

@implementation PathModel

- (void)setSteps:(NSArray *)steps {

    NSMutableArray *retArray = @[].mutableCopy;
    
    for (AMapSearchObject *searchObj in steps) {
        
        [retArray addObject:searchObj];
    }
    
    _steps = retArray.copy;
}


@end
