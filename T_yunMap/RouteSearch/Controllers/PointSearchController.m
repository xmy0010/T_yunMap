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
    
    //发起输入提示搜索
    [_search AMapInputTipsSearch:tipsRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <AMapSearchDelegate>
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response {

    if (response.tips.count == 0) {
        
        [SVProgressHUD showErrorWithStatus:@"未能找到地址信息.请重新输入"];
    }
    
    //通过AMapInputTipsSearchResponse
    NSString *strCount = [NSString stringWithFormat:@"cont:%ld", response.count];
    NSString *strtips = @"";
    for (AMapTip *p in response.tips) {
        strtips = [NSString stringWithFormat:@"%@ \n %@", strtips, p.description];
        
       
    }
    NSString *result = [NSString stringWithFormat:@"%@ \n %@", strCount, strtips];
     NSLog(@"InputTips:%@", result);
}


@end
