//
//  XRAppDataCenter.m
//  GreatVideo
//
//  Created by Xinri on 15/10/13.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import "XRAppDataCenter.h"
#import "XRDailyListModel.h"
#import "XRDailyModel.h"
#import "XRVideoModel.h"
#import "Common.h"
#import "XRCategoryModel.h"
#import "XRCategoryDatailModel.h"

@implementation XRAppDataCenter
{
    XRDailyListModel *_dailyListModel;
    XRCategoryDatailModel *_categoryDatailModel;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"XRAppDataCenter" reason:@"禁止调用此初始化方法" userInfo:nil];
}

- (instancetype)initPrivate
{
    if (self = [super init]) {
        // init data here
        _dailyListModel =[[XRDailyListModel alloc] init];
        _dailyListModel.dailyList = [NSMutableArray array];
        
        _categoryDatailModel = [[XRCategoryDatailModel alloc] init];
        _categoryDatailModel.videoList = [NSMutableArray array];
    }
    return self;
}

#pragma mark - 单例
+ (instancetype)defaultCenter
{
    static XRAppDataCenter *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XRAppDataCenter alloc] initPrivate];
    });
    
    return instance;
}

#pragma mark - 获取每日精选诗句
- (void)getDailyDataWithUrlString:(NSString *)urlString isClear:(BOOL)clear Success:(DailySuccessBlock)success Failure:(FailureBlock)failure
{
    if (clear) {
        _dailyListModel = nil;
        _dailyListModel = [[XRDailyListModel alloc] init];
        _dailyListModel.dailyList = [NSMutableArray array];
    }
    // ?num=10&date=20151013
    // 获取到今天的日期
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    NSDateComponents *cmp = [calendar components:unit fromDate:nowDate];
    NSInteger nowYear = [cmp year];
    NSInteger nowMonth = [cmp month];
    NSInteger nowDay = [cmp day];
    NSString *today = [NSString stringWithFormat:@"%ld%ld%ld", (long)nowYear, (long)nowMonth, (long)nowDay];
    
    NSDictionary *dict = @{@"num": @"5", @"date": today};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 关闭自动解析
//    [manager setResponseSerializer:[AFCompoundResponseSerial                  izer serializer]];
    [manager GET:urlString parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@", responseObject);
        [_dailyListModel setNextPageUrl:responseObject[@"nextPageUrl"]];
        [_dailyListModel setNextPublishTime:responseObject[@"nextPublishTime"]];
        for (NSDictionary *dict in responseObject[@"dailyList"]) {
            XRDailyModel *temp2 = [[XRDailyModel alloc] init];
            [temp2 setDate:dict[@"date"]];
            [temp2 setTotal:dict[@"total"]];
            NSMutableArray *tempArray3 = [NSMutableArray array];
            for (NSDictionary *dic in dict[@"videoList"]) {
                XRVideoModel *temp3 = [[XRVideoModel alloc] init];
                [temp3 setValuesForKeysWithDictionary:dic];
                [tempArray3 addObject:temp3];
            }
            [temp2 setVideoList:[tempArray3 copy]];
            [_dailyListModel.dailyList addObject:temp2];
        }
        
        success(_dailyListModel);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

#pragma mark - 获取分类数据
- (void)getCategoryDataWithUrlString:(NSString *)urlString Success:(CategorySuccessBlock)success Failure:(FailureBlock)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 关闭自动解析
    //    [manager setResponseSerializer:[AFCompoundResponseSerializer serializer]];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@", responseObject);
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dict in responseObject) {
            XRCategoryModel *model = [[XRCategoryModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [tempArray addObject:model];
        }
        success([tempArray copy]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

#pragma mark - 获取分类详情排序数据
- (void)getCategoryDetailDataWithUrlString:(NSString *)urlString WithCategoryName:(NSString *)categoryName WithSortType:(NSString *)sortType isClear:(BOOL)clear Success:(CategorySortCategorySuccessBlockBlock)success Failure:(FailureBlock)failure
{
    if (clear) {
        _categoryDatailModel = nil;
        _categoryDatailModel = [[XRCategoryDatailModel alloc] init];
        _categoryDatailModel.videoList = [NSMutableArray array];
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 关闭自动解析
    //    [manager setResponseSerializer:[AFCompoundResponseSerializer serializer]];
    // ?num=10&categoryName=%E6%97%85%E8%A1%8C&strategy=date
    NSDictionary *dict = nil;
    
    if (categoryName.length > 0 && sortType.length > 0) {
        dict = @{
                 @"num": @"10",
                 @"categoryName": [categoryName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                 @"strategy": sortType
                 };
        urlString = [NSString stringWithFormat:@"%@?num=%@&categoryName=%@&strategy=%@", urlString, dict[@"num"], dict[@"categoryName"], dict[@"strategy"]];
    }
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                NSLog(@"%@", responseObject);
        [_categoryDatailModel setCount:responseObject[@"count"]];
        [_categoryDatailModel setNextPageUrl:responseObject[@"nextPageUrl"]];
        for (NSDictionary *dic in responseObject[@"videoList"]) {
            XRVideoModel *temp = [[XRVideoModel alloc] init];
            [temp setValuesForKeysWithDictionary:dic];
            [_categoryDatailModel.videoList addObject:temp];
        }
        success(_categoryDatailModel);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

#pragma mark - 获取排行榜数据
- (void)getRanklistDataWithUrlString:(NSString *)urlString WithSortType:(NSString *)sortType Success:(RanklistSuccessBlock)success Failure:(FailureBlock)failure
{
    urlString = [NSString stringWithFormat:@"%@?strategy=%@", urlString, sortType];
//    NSLog(@"%@", urlString);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@", responseObject);
        XRCategoryDatailModel *tempModel = [[XRCategoryDatailModel alloc] init];
        tempModel.videoList = [NSMutableArray array];
        [tempModel setCount:responseObject[@"count"]];
        [tempModel setNextPageUrl:responseObject[@"nextPageUrl"]];
        for (NSDictionary *dic in responseObject[@"videoList"]) {
            XRVideoModel *temp = [[XRVideoModel alloc] init];
            [temp setValuesForKeysWithDictionary:dic];
            [tempModel.videoList addObject:temp];
        }
        success(tempModel);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

@end
