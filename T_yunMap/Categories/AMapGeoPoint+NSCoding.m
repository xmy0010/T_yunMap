//
//  AMapGeoPoint+NSCoding.m
//  T_yunMap
//
//  Created by T_yun on 16/1/15.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "AMapGeoPoint+NSCoding.h"

@implementation AMapGeoPoint (NSCoding)

- (void)encodeWithCoder:(NSCoder *)aCoder {

    [aCoder encodeFloat:self.longitude forKey:@"longitude"];
    [aCoder encodeFloat:self.latitude forKey:@"latitude"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {

    if (self = [super init]) {
        self.latitude = [aDecoder decodeFloatForKey:@"latitude"];
        self.longitude = [aDecoder decodeFloatForKey:@"longitude"];
    }
    
    return self;
}

@end
