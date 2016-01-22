//
//  AMapTip+NSCoding.m
//  T_yunMap
//
//  Created by T_yun on 16/1/15.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "AMapTip+NSCoding.h"

@implementation AMapTip (NSCoding)

- (NSString *)longitude {

    return [NSString stringWithFormat:@"%f", self.location.longitude];
}

- (void)setLongitude:(NSString *)longitude {

    self.location.longitude = [longitude floatValue];
}

- (NSString *)latitude {

    return  [NSString stringWithFormat:@"%f", self.location.latitude];
    
}

- (void)setLatitude:(NSString *)latitude {

    self.location.latitude = [latitude floatValue];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {

//    @property (nonatomic, copy) NSString     *uid; //!< poi的id
//    @property (nonatomic, copy) NSString     *name; //!< 名称
//    @property (nonatomic, copy) NSString     *adcode; //!< 区域编码
//    @property (nonatomic, copy) NSString     *district; //!< 所属区域
//    @property (nonatomic, copy) AMapGeoPoint *location; //!< 位置
    
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.adcode forKey:@"adcode"];
    [aCoder encodeObject:self.district forKey:@"district"];
    [aCoder encodeObject:self.location forKey:@"location"];
    [aCoder encodeObject:self.latitude forKey:@"latitude"];
    [aCoder encodeObject:self.longitude forKey:@"longitude"];
    
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {

    if (self = [super init]) {
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.adcode = [aDecoder decodeObjectForKey:@"adcod"];
        self.district = [aDecoder decodeObjectForKey:@"district"];
        self.location = [aDecoder decodeObjectForKey:@"location"];
        self.latitude = [aDecoder decodeObjectForKey:@"latitude"];
        self.longitude = [aDecoder decodeObjectForKey:@"longitude"];
    }
    
    return self;
}

@end
