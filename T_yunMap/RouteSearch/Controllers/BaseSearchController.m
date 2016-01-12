//
//  BaseSearchController.m
//  T_yunMap
//
//  Created by T_yun on 16/1/12.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "BaseSearchController.h"
#import "NaviBarView.h"

@interface BaseSearchController ()

@property (nonatomic, strong) NaviBarView *naviBarView;

@end

@implementation BaseSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self customNavigationBarView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customNavigationBarView {

    NaviBarView *naviBarView = [[NaviBarView alloc] initWithFrame:CGRectMake(0, Operator_Bar_Height, ScreenSize.width, ToolBar_Height)];
    [self.view addSubview:naviBarView];
    self.naviBarView = naviBarView;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setStateButtonTitle:) name:SearchTabBarNotif object:nil];
    
    __weak typeof(self)weakSelf = self;
    naviBarView.BackButtonBlock = ^(){
    
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    naviBarView.StateButtonBlock = ^(){
        
#warning operation Code here...
    };
    
}

//设置stateButton的背景图片
- (void)setStateButtonWithImageName:(NSString *)name {

    UIButton *button = self.naviBarView.stateButton;
    
    NSString *disabledName = [NSString stringWithFormat:@"%@_disabled", name];
    [button setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:disabledName] forState:UIControlStateDisabled];
    
};

- (void)setStateButtonName:(NSString *)stateButtonName {

    [self setStateButtonWithImageName:stateButtonName];
}

///**通知回调*/
//- (void)setStateButtonTitle:(NSNotification *)notification {
//
//    NSArray *stateButtonTitles = @[@"default_path_searchbtn_bus",
//                                   @"default_path_searchbtn_car",
//                                   @"default_path_searchbtn_foot"];
//    
//    
//    NSInteger index = [notification.userInfo[@"index"] integerValue];
//    UIButton *button = self.naviBarView.stateButton;
//    NSString *normalName = stateButtonTitles[index];
//    NSString *disabledName = [NSString stringWithFormat:@"%@_disabled", normalName];
//    [button setBackgroundImage:[UIImage imageNamed:normalName] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:disabledName] forState:UIControlStateDisabled];
//}

@end
