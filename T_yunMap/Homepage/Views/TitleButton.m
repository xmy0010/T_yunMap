//
//  TitleButton.m
//  CD1505Weibo
//
//  Created by HeHui on 15/12/30.
//  Copyright © 2015年 Hawie. All rights reserved.
//

#import "TitleButton.h"

@implementation TitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleRatio = 0.5;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}


- (CGRect) imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imgX = 0;
    CGFloat imgY = 0;
    CGFloat imgW = (1-_titleRatio) * CGRectGetWidth(contentRect);
    CGFloat imgH = CGRectGetHeight(contentRect);
    return CGRectMake(imgX, imgY, imgW, imgH);
}


- (CGRect) titleRectForContentRect:(CGRect)contentRect
{
    CGFloat tX = _titleRatio * CGRectGetWidth(contentRect);
    CGFloat tY = 0;
    CGFloat tW = CGRectGetWidth(contentRect) * _titleRatio;
    CGFloat tH = CGRectGetHeight(contentRect);
    
    return CGRectMake(tX, tY, tW, tH);
}

@end
