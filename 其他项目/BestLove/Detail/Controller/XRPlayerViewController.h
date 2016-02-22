//
//  XRPlayerViewController.h
//  GreatVideo
//
//  Created by Xinri on 15/10/14.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import "XRRootViewController.h"

@class XRVideoModel;

@interface XRPlayerViewController : XRRootViewController

@property (strong, nonatomic) XRVideoModel *model;

- (instancetype)initWithModel:(XRVideoModel *)model;

@end
