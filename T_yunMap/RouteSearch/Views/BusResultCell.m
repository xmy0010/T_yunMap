//
//  BusResultCell.m
//  T_yunMap
//
//  Created by T_yun on 16/2/3.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "BusResultCell.h"

@interface BusResultCell ()

@property (weak, nonatomic) IBOutlet UILabel *busRoute;
@property (weak, nonatomic) IBOutlet UILabel *durationLB;
@property (weak, nonatomic) IBOutlet UILabel *costLB;
@property (weak, nonatomic) IBOutlet UILabel *walkingDistanceLB;
@property (weak, nonatomic) IBOutlet UILabel *totalDistanceLB;
@property (weak, nonatomic) IBOutlet UILabel *originStop;



@end


@implementation BusResultCell

- (void)awakeFromNib {
    // Initialization code
    

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTransit:(AMapTransit *)transit {

    //    @property (nonatomic, assign) CGFloat    cost; //!< 此公交方案价格（单位：元）
    //    @property (nonatomic, assign) NSInteger  duration; //!< 此换乘方案预期时间（单位：秒）
    //    @property (nonatomic, assign) BOOL       nightflag; //!< 是否是夜班车
    //    @property (nonatomic, assign) NSInteger  walkingDistance; //!< 此方案总步行距离（单位：米）
    //    @property (nonatomic, strong) NSArray   *segments; //!< 换乘路段 AMapSegment 数组
    
    _transit = transit;
    
    self.durationLB.text = [NSString stringWithFormat:@"耗时%ld分钟", self.transit.duration / 60];
    self.costLB.text = [NSString stringWithFormat:@"花费%.2f元", self.transit.cost];
    self.walkingDistanceLB.text = [NSString stringWithFormat:@"步行%ld米", self.transit.walkingDistance];
    
    NSMutableString *route = [NSMutableString string];
    NSInteger totalDistance = 0;
    NSArray *segments = self.transit.segments;
    
    AMapSegment *tempSegment = segments.firstObject;
    AMapBusLine *tempLine = tempSegment.buslines.firstObject;
    self.originStop.text = tempLine.departureStop.name;
    self.originStop.layer.borderWidth = 1.;
    self.originStop.layer.borderColor = [UIColor grayColor].CGColor;
    
    for (AMapSegment *segment in segments) {
        
        NSArray *buslines = segment.buslines;
        
        //暂时用数组中第一个选择作为整条线路长度的参考
        AMapBusLine *firstBusLine = buslines.firstObject;
        totalDistance += firstBusLine.distance;
        
        for (AMapBusLine *busline in buslines) {
            
            [route appendFormat:@"%@/", [[busline.name componentsSeparatedByString:@"("] firstObject]];
            
        }
        route = [NSMutableString stringWithString:[route substringToIndex:route.length - 1]];
        [route appendString:@" > "];
    }
    route = [NSMutableString stringWithString:[route substringToIndex:route.length - 3]];
    self.busRoute.text = [route substringToIndex:route.length - 2];
    self.totalDistanceLB.text = [NSString stringWithFormat:@"全程%.2f公里", totalDistance / 1000.];
}

@end
