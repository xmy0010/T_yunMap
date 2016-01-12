//
//  HomepageNavigationController.m
//  T_yunMap
//
//  Created by T_yun on 16/1/11.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "HomepageNavigationController.h"
#import "TitleButton.h"

@interface HomepageNavigationController ()

@end

@implementation HomepageNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
   
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    self.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    
    self.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///**不用系统toolBar 自定义View*/
//- (void)customToolBar {
//
//    self.toolbarHidden = NO;
//    UIToolbar *toolBar = self.toolbar;
//    toolBar.translucent = YES;
//    [toolBar setBackgroundImage:[UIImage imageNamed:@"navigationbar"] forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
//
//    
//    UIBarButtonItem *routeItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(busItemPressed:)];
//
////    CGFloat itemWidth_Height = ToolBar_Height - Space_Normal_Eight * 2;
////    CGRect rect = CGRectMake(Space_Normal_Eight, Space_Normal_Eight, itemWidth_Height, itemWidth_Height);
////    TitleButton *routeButton = [[TitleButton alloc] initWithFrame: rect];
////    routeButton.titleLabel.text = @"路线";
////    routeButton.imageView.image = [UIImage imageNamed: @"default_generalsearch_va_introduce_icon_route"];
////    routeItem.customView = routeButton;
//
//    
//  
//}

#pragma mark - Actions
- (void)busItemPressed:(UIBarButtonItem *)sender {

    
}

@end
