//
//  BusWalkingCell.m
//  T_yunMap
//
//  Created by T_yun on 16/2/16.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "BusWalkingCell.h"

@implementation BusWalkingCell

- (void)awakeFromNib {
    // Initialization code
    
    long minute = self.walking.duration / 60;
    self.detailLb.text = [NSString stringWithFormat:@"步行%ld米 耗时%ld分钟",self.walking.distance, minute > 1 ? minute : 1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
