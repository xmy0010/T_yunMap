//
//  CustomCalloutView.m
//  T_yunMap
//
//  Created by T_yun on 16/1/7.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "CustomCalloutView.h"

#define kArrorHeight 10

#define kPortraitMargin 5
#define kPortraitWidth 70
#define kPortraitHeight 50

#define kTitleWidth 120
#define kTitleHeight 20

@interface CustomCalloutView () {

}
@property (nonatomic, strong) UIImageView *portaitView;
@property (nonatomic, strong) UILabel *subtitleLable;
@property (nonatomic, strong) UILabel *titleLable;

@end

@implementation CustomCalloutView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {

    //添加商户图
    self.portaitView = [[UIImageView alloc] initWithFrame:CGRectMake(kPortraitMargin, kPortraitMargin, kPortraitWidth, kPortraitHeight)];
    
    self.portaitView.backgroundColor = [UIColor blackColor];
    [self addSubview:_portaitView];
    
    //添加商户名
    self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(kPortraitMargin * 2 + kPortraitWidth, kPortraitMargin, kTitleWidth, kTitleHeight)];
    self.titleLable.font = [UIFont systemFontOfSize:14];
    self.titleLable.adjustsFontSizeToFitWidth = YES;
    self.titleLable.textColor = [UIColor whiteColor];
    self.titleLable.text = @"this is a title";
    [self addSubview:_titleLable];
    
    //添加商户地址
    self.subtitleLable = [[UILabel alloc] initWithFrame:CGRectMake(kPortraitMargin * 2 + kPortraitWidth, kPortraitMargin * 2 + kTitleHeight , kTitleWidth, kTitleHeight)];
    self.subtitleLable.font = [UIFont systemFontOfSize:12];
    self.subtitleLable.text = @"this is a subTitle";
    self.subtitleLable.textColor = [UIColor lightGrayColor];
    [self addSubview:_subtitleLable];
}

- (void)drawRect:(CGRect)rect {

    [self drawInContext:UIGraphicsGetCurrentContext()];
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowOffset = CGSizeMake(.0f, .0f);
}

- (void)drawInContext:(CGContextRef)context {

    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.8].CGColor);
    
    [self getDrawPath:context];
    CGContextFillPath(context);
}

- (void)setTitle:(NSString *)title {

    self.titleLable.text = title;
//    NSLog(@"3%@", _titleLable.text);
}

- (void)setSubTitle:(NSString *)subTitle {

    self.subtitleLable.text = subTitle;
//    NSLog(@"%@", subTitle);
}

- (void)setImage:(UIImage *)image {

    self.portaitView.image = image;
}

- (void)getDrawPath:(CGContextRef)context {

    CGRect rrect = self.bounds;
    CGFloat radius = 6.;
    CGFloat minX = CGRectGetMinX(rrect),
    midX = CGRectGetMidX(rrect),
    maxX = CGRectGetMaxX(rrect);
    
    CGFloat minY = CGRectGetMinY(rrect),
    maxY = CGRectGetMaxY(rrect) - kArrorHeight;
    
    CGContextMoveToPoint(context, midX + kArrorHeight, maxY);
    CGContextAddLineToPoint(context, midX, maxY + kArrorHeight);
    CGContextAddLineToPoint(context, midX - kArrorHeight, maxY);
    
    CGContextAddArcToPoint(context, minX, maxY, minX, minY, radius);
    CGContextAddArcToPoint(context, minX, minX, maxX, minY, radius);
    CGContextAddArcToPoint(context, maxX, minY, maxX, maxX, radius);
    CGContextAddArcToPoint(context, maxX, maxY, midX, maxY, radius);
    CGContextClosePath(context);
    
}

@end
