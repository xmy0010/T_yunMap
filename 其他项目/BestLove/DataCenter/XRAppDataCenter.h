//
//  XRAppDataCenter.h
//  GreatVideo
//
//  Created by Xinri on 15/10/13.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XRDailyListModel, XRCategoryDatailModel;

typedef void(^DailySuccessBlock)(XRDailyListModel *dailyList);
typedef void(^FailureBlock)(NSError *error);

typedef void(^CategorySuccessBlock)(NSArray *catrgotryArray);

typedef void(^CategorySortCategorySuccessBlockBlock)(XRCategoryDatailModel *categoryDetail);
typedef void(^RanklistSuccessBlock)(XRCategoryDatailModel *ranklist);
/*!
 数据管理中心
 */
@interface XRAppDataCenter : NSObject

/**单例*/
+ (instancetype)defaultCenter;

/**获取每日精选数据*/
- (void)getDailyDataWithUrlString:(NSString *)urlString isClear:(BOOL)clear Success:(DailySuccessBlock)success Failure:(FailureBlock)failure;

/**获取分类数据*/
- (void)getCategoryDataWithUrlString:(NSString *)urlString Success:(CategorySuccessBlock)success Failure:(FailureBlock)failure;

/**获取分类详情排序数据*/
- (void)getCategoryDetailDataWithUrlString:(NSString *)urlString WithCategoryName:(NSString *)categoryName WithSortType:(NSString *)sortType isClear:(BOOL)clear Success:(CategorySortCategorySuccessBlockBlock)success Failure:(FailureBlock)failure;

/**获取排行榜数据*/
- (void)getRanklistDataWithUrlString:(NSString *)urlString WithSortType:(NSString *)sortType Success:(RanklistSuccessBlock)success Failure:(FailureBlock)failure;

@end
