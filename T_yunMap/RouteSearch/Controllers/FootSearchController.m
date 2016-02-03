//
//  FootSearchController.m
//  T_yunMap
//
//  Created by T_yun on 16/1/12.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "FootSearchController.h"
#import "CarResultViewController.h"


@interface FootSearchController () <AMapSearchDelegate>

@end

@implementation FootSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.stateButtonName = @"default_path_searchbtn_foot";
    self.searchType = SearchTypeFoot;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**重写父类搜索方法*/
- (void)searchRoute {

    AMapWalkingRouteSearchRequest *request = [[AMapWalkingRouteSearchRequest alloc] init];
    request.origin = self.originLocation;
    request.destination = self.destinationLocation;
    
    [self.search AMapWalkingRouteSearch:request];
    [SVProgressHUD showWithStatus:@"搜索中"];
    
}

#pragma mark -<AMapSearchDelegate>
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response {
    
    UIStoryboard *routeSb = [UIStoryboard storyboardWithName:@"RouteStoryboard" bundle:nil];
    CarResultViewController *carResultVC = [routeSb instantiateViewControllerWithIdentifier:@"CarResultViewController"];

    carResultVC.aMapRoute = response.route;
    carResultVC.originName = self.originTF.text;
    carResultVC.destinationName = self.destinationTF.text;
    carResultVC.isFootSerach = YES;
    
    
    [self.navigationController pushViewController:carResultVC animated:YES];
    
    [SVProgressHUD dismiss];
}

@end
