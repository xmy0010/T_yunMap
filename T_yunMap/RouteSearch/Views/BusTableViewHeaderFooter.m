//
//  BusTableViewHeaderFooter.m
//  T_yunMap
//
//  Created by T_yun on 16/2/17.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "BusTableViewHeaderFooter.h"
#import <Masonry.h>

#define kIconHeightWidth 20
@implementation BusTableViewHeaderFooter



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customSubviews];
    }
    return self;
}

- (void)customSubviews {

    self.icon = [[UIImageView alloc] init];
    [self addSubview:self.icon];
    self.icon.contentMode = UIViewContentModeScaleToFill;
    
    self.titleLB = [[UILabel alloc] init];
    [self addSubview:self.titleLB];
}

- (void)layoutSubviews {

    [super layoutSubviews];
 
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.height.equalTo(@kIconHeightWidth);
        make.width.equalTo(@kIconHeightWidth);
    }];
    
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.centerX.equalTo(self.mas_centerX);
    }];
}

@end
