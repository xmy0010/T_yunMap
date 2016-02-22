//
//  XRTopView.m
//  GreatVideo
//
//  Created by 鑫 李 on 15/10/14.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import "XRTopView.h"

@interface XRTopView()

@property (weak, nonatomic) IBOutlet UIButton *leftButton;

@end

@implementation XRTopView
{
    UIButton *_selectButton;
}

- (IBAction)sortByDate:(UIButton *)sender {
    if (((int)sender.tag == 301) && !_selectButton) {
        _selectButton = _leftButton;
    }
    [_selectButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _selectButton = sender;
    
    [_delegate sortButtonClicked:sender.currentTitle];
}

@end
