//
//  BusWalkingCell.h
//  T_yunMap
//
//  Created by T_yun on 16/2/16.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusWalkingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *detailLb;
@property (nonatomic, strong) AMapWalking *walking;

@end
