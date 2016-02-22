//
//  AppDelegate.h
//  GreatVideo
//
//  Created by Xinri on 15/10/13.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// 网络状况的提示
@property (assign, nonatomic, getter=isNotice) BOOL notice;
// 缓存进度的模型数组
@property (strong, nonatomic) NSMutableArray *progressArray;

@end

