//
//  PointSearchController.m
//  T_yunMap
//
//  Created by T_yun on 16/1/12.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "PointSearchController.h"

@interface PointSearchController () <AMapSearchDelegate> {

    AMapSearchAPI *_search;
}

@end

@implementation PointSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化检索对象
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
    
    //构造AMapInputTipsSearchRequest对象 设置请求参数
    AMapInputTipsSearchRequest *tipsRequest = [[AMapInputTipsSearchRequest alloc] init];
    tipsRequest.keywords = @"肯德基";
    tipsRequest.city = @"成都";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
