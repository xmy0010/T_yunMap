//
//  BaseSearchController.m
//  T_yunMap
//
//  Created by T_yun on 16/1/12.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "BaseSearchController.h"
#import "NaviBarView.h"
#import "PointSearchController.h"

@interface BaseSearchController () <UITextFieldDelegate> {

    
}

@property (nonatomic, strong) NaviBarView *naviBarView;
@property (nonatomic, strong) UITextField *originTF;
@property (nonatomic, strong) UITextField *destinationTF;


@end

@implementation BaseSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg01"]];
    self.navigationController.navigationBarHidden = YES;
    [self customNavigationBarView];
    
    [self customSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customNavigationBarView {

    NaviBarView *naviBarView = [[NaviBarView alloc] initWithFrame:CGRectMake(0, Operator_Bar_Height, ScreenSize.width, ToolBar_Height)];
    [self.view addSubview:naviBarView];
    self.naviBarView = naviBarView;
    

    
    __weak typeof(self)weakSelf = self;
    naviBarView.BackButtonBlock = ^(){
    
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    naviBarView.StateButtonBlock = ^(){
     
        if (self.destinationTF.text == nil || self.originTF.text == nil) {
            
            [SVProgressHUD showErrorWithStatus:@"起点和终点不能为空!"];
        } else {
            NSLog(@"1");
            [self searchRoute];
        }
     
    };
    
}

- (void)customSubviews  {

    CGFloat marginX = 50;
    CGFloat marginY = 100;
    CGFloat width = ScreenSize.width - marginX * 2;
    CGFloat height = 40;
    CGFloat imageWidth_Height = 22;
    
    self.originTF = [[UITextField alloc] initWithFrame:CGRectMake(marginX, marginY, width, height)];
    [self.view addSubview:self.originTF];
    self.originTF.backgroundColor = [UIColor whiteColor];
    self.originTF.delegate = self;
    
    self.destinationTF = [[UITextField alloc] initWithFrame:CGRectMake(marginX, marginY + height + Space_Normal_Ten * 2, width, height)];
    [self.view addSubview:self.destinationTF];
    self.destinationTF.backgroundColor = [UIColor whiteColor];
    self.destinationTF.delegate = self;
    
    UIImageView *originImageView = [[UIImageView alloc] initWithFrame:CGRectMake(Space_Normal_Eight, CGRectGetMidY(self.originTF.frame) - imageWidth_Height / 2, imageWidth_Height, imageWidth_Height)];
    [self.view addSubview:originImageView];
    originImageView.image = [UIImage imageNamed: @"default_path_pathmain_text_start_normal"];
    
    UIImageView *dotImageView = [[UIImageView alloc] initWithFrame:CGRectMake(Space_Normal_Eight, CGRectGetMaxY(originImageView.frame) + Space_Normal_Eight, imageWidth_Height, imageWidth_Height)];
    [self.view addSubview:dotImageView];
    dotImageView.image = [UIImage imageNamed: @"default_path_pathmain_line_point3_normal"];
    
    UIImageView *destinationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(Space_Normal_Eight, CGRectGetMidY(self.destinationTF.frame) - imageWidth_Height / 2, imageWidth_Height, imageWidth_Height)];
    [self.view addSubview:destinationImageView];
    destinationImageView.image = [UIImage imageNamed:@"default_path_pathmain_text_end_normal"];
    
    
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

#pragma mark Action - 
/**子类重写实现搜索*/
- (void)searchRoute {

    
}


#pragma mark <UITextFieldDelegate>
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

    PointSearchController *pointVC = [[PointSearchController alloc] init];
    pointVC.searchType = self.searchType;
    pointVC.PointSearchBlock = ^(AMapTip *tip){
    
        textField.text = tip.name;
        if (textField == self.originTF) {
            
            self.originLocation = tip.location;
        } else if (textField == self.destinationTF) {
            
            self.destinationLocation = tip.location;
        }
        
    };
    [self.navigationController pushViewController:pointVC animated:YES];
    
    return NO;
}



@end
