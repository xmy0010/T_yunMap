//
//  XRRanklistTopView.m
//  GreatVideo
//
//  Created by Xinri on 15/10/14.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import "XRRanklistTopView.h"

@interface XRRanklistTopView()
{
    UIButton *_selectButton;
}

@property (weak, nonatomic) IBOutlet UIButton *lButton;
@property (weak, nonatomic) IBOutlet UIButton *cButton;
@property (weak, nonatomic) IBOutlet UIButton *rButton;

@end

@implementation XRRanklistTopView

- (IBAction)rankListButtonClicked:(UIButton *)sender {
    if (!_selectButton) {
        _selectButton = _lButton;
    }
    [_selectButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _selectButton = sender;
    
    [_delegate ranklistButtonClicked:sender.currentTitle];
}


@end
