//
//  CarTableViewHeaderFooter.h
//  T_yunMap
//
//  Created by T_yun on 16/1/22.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarTableViewHeaderFooter : UITableViewHeaderFooterView

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *titleLB;


- (void)customSubviews;

@end
