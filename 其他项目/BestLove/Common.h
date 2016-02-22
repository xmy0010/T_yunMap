//
//  Common.h
//  JustWalk
//
//  Created by Xinri on 15/10/12.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#ifndef JustWalk_Common_h
#define JustWalk_Common_h

#import "AFNetworking.h"
#import "JGProgressHUD.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

// 屏幕宽高
#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height

// 广告接口
//#define URL_Adv @"http://baobab.wandoujia.com/api/v1/configs"

// 每日精选
#define URL_Daily @"http://baobab.wandoujia.com/api/v1/feed"

// 分类接口
#define URL_Category @"http://baobab.wandoujia.com/api/v1/categories"
// ?num=10&date=20151013

// 按时间排序
#define URL_Category_sort @"http://baobab.wandoujia.com/api/v1/videos"
// ?num=10&categoryName=%E6%97%85%E8%A1%8C&strategy=date
// 按分享排序
//#define URL_Category_shareCount @"http://baobab.wandoujia.com/api/v1/videos"
// ?num=10&categoryName=%E6%97%85%E8%A1%8C&strategy=shareCount

#define URL_Ranklist @"http://baobab.wandoujia.com/api/v1/ranklist"
//http://baobab.wandoujia.com/api/v1/ranklist?strategy=weekly&vc=125&u=dbd8ad358eda66bd9fc384b4d6a5d428e11c6cce&v=1.8.1&f=iphone
//

// 下载
#define URL_Download @"http://117.23.2.79/m.wdjcdn.com/baobab/"

#endif
