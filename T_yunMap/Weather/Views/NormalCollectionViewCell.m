//
//  NormalCollectionViewCell.m
//  T_yunMap
//
//  Created by T_yun on 16/1/18.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "NormalCollectionViewCell.h"

@implementation NormalCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.layer.borderWidth = 2;
    self.layer.borderColor = [UIColor orangeColor].CGColor;
    self.layer.cornerRadius = 6;
    
    self.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.4];
}

@end
