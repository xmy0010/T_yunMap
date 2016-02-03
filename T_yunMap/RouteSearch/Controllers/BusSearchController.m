//
//  BusSearchController.m
//  T_yunMap
//
//  Created by T_yun on 16/1/12.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "BusSearchController.h"
#import "MAMapView+Singleton.h"
#import "MAUserLocation+XMYExtension.h"
#import "BusResultViewController.h"

@interface BusSearchController ()



@end

@implementation BusSearchController


//- (NSArray *)dataArray {
//
//    if (_dataArray == nil) {
//        _dataArray = @[@"最快捷模式",
//                       @"最经济模式",
//                       @"最少换乘模式",
//                       @"最少步行模式",
//                       @"最舒适模式",
//                       @"不乘地铁模式"];
//        
//    }
//    
//    return _dataArray;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.stateButtonName = @"default_path_searchbtn_bus";
    self.searchType = SearchTypeBus;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//重写父类方法进行搜索
- (void)searchRoute {

    AMapTransitRouteSearchRequest *request = [[AMapTransitRouteSearchRequest alloc] init];
    request.origin = self.originLocation;
    request.destination = self.destinationLocation;
    request.city = [MAMapView shareMap].userLocation.userCity;
    
    [self.search AMapTransitRouteSearch:request];
    [SVProgressHUD showWithStatus:@"搜索中"];
}


#pragma mark - AMapSearchDelegate
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response {

    
    AMapRoute *route = response.route;
    BusResultViewController *resultVC = [[BusResultViewController alloc] init];
    resultVC.route = route;
    [SVProgressHUD dismiss];
    [self.navigationController pushViewController:resultVC animated:YES];
}


@end
