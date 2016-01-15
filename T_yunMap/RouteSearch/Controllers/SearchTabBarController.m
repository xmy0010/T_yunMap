//
//  SearchTabBarController.m
//  T_yunMap
//
//  Created by T_yun on 16/1/12.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "SearchTabBarController.h"
#import "FootSearchController.h"
#import "CarSearchController.h"
#import "BusSearchController.h"

@interface SearchTabBarController ()

@end

@implementation SearchTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setupViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupViewControllers {

    [self setupChildControllerWithClass:[CarSearchController class] tabBarimageName:@"default_path_pathmain_car" title:@"自驾"];
    
    [self setupChildControllerWithClass:[BusSearchController class] tabBarimageName:@"default_path_pathmain_bus" title:@"公交"];
    
    [self setupChildControllerWithClass:[FootSearchController class] tabBarimageName:@"default_path_pathmain_foot" title:@"步行"];
    
}

- (void)setupChildControllerWithClass:(Class)class tabBarimageName:(NSString *)imageName title:(NSString *)title{

    BaseSearchController *searchController = [[class alloc] init];
    searchController.tabBarItem.image = [UIImage imageNamed:imageName];
    searchController.tabBarItem.selectedImage = [UIImage imageNamed: [NSString stringWithFormat:@"%@_sel", imageName]];
    searchController.navigationController.navigationBarHidden = NO;
    searchController.title = title;
    
    [self addChildViewController: searchController];
}



#pragma mark - <UITabBarDelegate>
//- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
//    NSInteger index = self.selectedIndex;
//    
//    NSDictionary *params = @{@"index": [NSString stringWithFormat:@"%ld", index]};
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:SearchTabBarNotif object:nil userInfo:params];
//}

@end
