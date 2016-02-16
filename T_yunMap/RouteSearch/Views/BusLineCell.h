//
//  BusLineCell.h
//  T_yunMap
//
//  Created by T_yun on 16/2/16.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusLineCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *typeIcon;
@property (weak, nonatomic) IBOutlet UILabel *buslineLB;
@property (weak, nonatomic) IBOutlet UIView *rightView;

@property (nonatomic, strong) AMapBusLine *busline;


@end
