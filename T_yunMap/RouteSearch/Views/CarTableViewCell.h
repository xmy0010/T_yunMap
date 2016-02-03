//
//  CarTableViewCell.h
//  T_yunMap
//
//  Created by T_yun on 16/1/22.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarTableViewCell : UITableViewCell

@property (nonatomic, strong) AMapStep *step;
@property (weak, nonatomic) IBOutlet UILabel *roadLB;
@property (weak, nonatomic) IBOutlet UILabel *instructionLB;
@property (weak, nonatomic) IBOutlet UIImageView *actionImageView;
@property (weak, nonatomic) IBOutlet UIImageView *passImageView;


@end
