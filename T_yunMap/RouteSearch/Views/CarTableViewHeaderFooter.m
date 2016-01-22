//
//  CarTableViewHeaderFooter.m
//  T_yunMap
//
//  Created by T_yun on 16/1/22.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "CarTableViewHeaderFooter.h"

#define iconWidthHeight 36

@implementation CarTableViewHeaderFooter

+(instancetype)alloc {
    CarTableViewHeaderFooter *view = [super alloc];
    
    [view customSubviews];
    return  view;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self customSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self customSubviews];
    }
    return self;
}

#warning 
//该函数并不会调用
- (void)customSubviews {

    self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(Space_Normal_Eight, Space_Normal_Eight, iconWidthHeight, iconWidthHeight)];
    [self addSubview:self.icon];
    
    self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.icon.frame), Space_Normal_Eight, self.xmy_width - CGRectGetMaxX(self.icon.frame), iconWidthHeight)];
    self.titleLB.textAlignment = NSTextAlignmentRight;
    self.titleLB.font = [UIFont systemFontOfSize:18];
    [self addSubview:self.titleLB];
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    self.icon.frame = CGRectMake(Space_Normal_Eight, Space_Normal_Eight, iconWidthHeight, iconWidthHeight);
 
    
    self.titleLB.frame = CGRectMake(CGRectGetMaxX(self.icon.frame), Space_Normal_Eight, self.xmy_width - CGRectGetMaxX(self.icon.frame), iconWidthHeight);


}

@end
