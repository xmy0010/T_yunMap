//
//  CustomAnnotationView.m
//  T_yunMap
//
//  Created by T_yun on 16/1/7.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "CustomAnnotationView.h"

#define kCalloutWidth  200.
#define kCalloutHeight 70.

@interface CustomAnnotationView ()

@property (nonatomic, strong, readwrite) CustomCalloutView *calloutView;

@end

@implementation CustomAnnotationView

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    if (self.selected == selected) {
        
        return;
    }
    
    if (selected) {
        
        if (self.calloutView == nil) {
            
            self.calloutView = [[CustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x, -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
            
            self.calloutView.image = [UIImage imageNamed: @"mansion"];
            self.calloutView.title = self.annotation.title;
            self.calloutView.subTitle = self.annotation.subtitle;
            
            [self addSubview:self.calloutView];
        } else {
            [self.calloutView removeFromSuperview];
        }
        
        [super setSelected:selected animated:animated];
    }
}

@end
