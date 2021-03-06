//
//  AppDelegate.m
//  T_yunMap
//
//  Created by T_yun on 16/1/5.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "AppDelegate.h"
#import "HomepageViewController.h"
#import "HomepageNavigationController.h"
#import <BmobSDK/Bmob.h>

#import "PointSearchController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [MAMapServices sharedServices].apiKey = Gaode_key;
    [AMapSearchServices sharedServices].apiKey = Gaode_key;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    HomepageViewController *homepageVC = [[HomepageViewController alloc] init];
    HomepageNavigationController *naviC = [[HomepageNavigationController alloc] initWithRootViewController:homepageVC];
    self.window.rootViewController = naviC;
    naviC.mapView = homepageVC.mapView;

    // 向bmob服务器注册你自己的应用
    [Bmob registerWithAppKey:@"40941a8f19a9c7ef5da23ffa9c529614"];
    
    [self.window makeKeyAndVisible];
    
    [self setupSVProgressHud];
    
    
    return YES;
}


- (void)setupSVProgressHud {
    
    //前景 背景
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.7]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    
    //遮挡
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
