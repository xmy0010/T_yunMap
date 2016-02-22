//
//  XRDailyTableViewCell.h
//  GreatVideo
//
//  Created by Xinri on 15/10/13.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XRVideoModel;

@interface XRDailyTableViewCell : UITableViewCell

@property (strong, nonatomic) XRVideoModel *videoModel;
@property (assign, nonatomic) NSInteger rankPosition;

@end
