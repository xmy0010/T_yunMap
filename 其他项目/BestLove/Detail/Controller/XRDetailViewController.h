//
//  XRDetailViewController.h
//  GreatVideo
//
//  Created by Xinri on 15/10/14.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import "XRRootViewController.h"

@class XRVideoModel;

@interface XRDetailViewController : XRRootViewController

@property (strong, nonatomic) XRVideoModel *videoModel;

- (instancetype)initWIthRootViewFrame:(CGRect)frame andModel:(XRVideoModel *)model;

@end
