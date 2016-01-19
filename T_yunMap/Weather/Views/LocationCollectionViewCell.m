//
//  LocationCollectionViewCell.m
//  T_yunMap
//
//  Created by T_yun on 16/1/18.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "LocationCollectionViewCell.h"

@implementation LocationCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.layer.borderWidth = 2;
    self.layer.borderColor = [UIColor greenColor].CGColor;
    self.layer.cornerRadius = 6;
    
    self.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.4];
}

@end
