//
//  XRVideoListModel.m
//  GreatVideo
//
//  Created by Xinri on 15/10/13.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import "XRVideoModel.h"

@implementation XRVideoModel

@synthesize description;
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _identifier = value;
    }
}

@end
