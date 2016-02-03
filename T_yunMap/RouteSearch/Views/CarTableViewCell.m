//
//  CarTableViewCell.m
//  T_yunMap
//
//  Created by T_yun on 16/1/22.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "CarTableViewCell.h"
#import "ActionImageChoice.h"

@implementation CarTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setStep:(AMapStep *)step {

    _step = step;
    self.roadLB.text = self.step.road;
    self.instructionLB.text = self.step.instruction;
    self.actionImageView.image = [ActionImageChoice ChoseImageWithAction:self.step.action];
}



@end
