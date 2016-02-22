//
//  XRSettingViewController.m
//  BestLove
//
//  Created by Xinri on 15/10/16.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import "XRSettingViewController.h"

@interface XRSettingViewController ()

@end

@implementation XRSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    [label setText:@"版本号：v 1.1"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:20]];
    
    [self.view addSubview:label];
}

@end
