//
//  CarSearchController.m
//  T_yunMap
//
//  Created by T_yun on 16/1/12.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "CarSearchController.h"

@interface CarSearchController () <AMapSearchDelegate>{

    AMapSearchAPI *_routeSearch;
}

@end

@implementation CarSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.stateButtonName = @"default_path_searchbtn_car";
    self.searchType = SearchTypeCar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//重写
  /**路径导航搜索*/
- (void)searchRoute {

    NSLog(@"search");
   
        
        _routeSearch = [[AMapSearchAPI alloc] init];
        _routeSearch.delegate = self;
        
        //构造AMapDrivingRouteSearchRequest对象 设置驾车路径规划请求参数
        AMapDrivingRouteSearchRequest *request = [[AMapDrivingRouteSearchRequest alloc] init];
        request.origin = [AMapGeoPoint locationWithLatitude:30.662221 longitude:104.041367];
        request.destination = [AMapGeoPoint locationWithLatitude:30.69 longitude:104.06];
        /// 驾车导航策略：0-速度优先（时间）；1-费用优先（不走收费路段的最快道路）；2-距离优先；3-不走快速路；4-结合实时交通（躲避拥堵）；5-多策略（同时使用速度优先、费用优先、距离优先三个策略）；6-不走高速；7-不走高速且避免收费；8-躲避收费和拥堵；9-不走高速且躲避收费和拥堵
        request.strategy = 2;
        request.requireExtension = YES;
        
        [_routeSearch AMapDrivingRouteSearch:request];
    
}


#pragma mark - <AMapSearchDelegate>


@end
