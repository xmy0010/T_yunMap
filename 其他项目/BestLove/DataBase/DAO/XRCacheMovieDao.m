//
//  XRCacheMovieDao.m
//  BestLove
//
//  Created by Xinri on 15/10/17.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import "XRCacheMovieDao.h"
#import "XRDbTool.h"

@implementation XRCacheMovieDao

- (instancetype)init
{
    if (self = [super init]) {
        _db = [XRDbTool createDBWithFileName:@"movie.db"];
        [_db open];
        //        NSLog(@"%@", NSHomeDirectory());
        if ([_db executeStatements:@"create table if not exists TbCacheMovie (identifier int primary key, date int,duration int,idx int,category varchar(20),coverBlurred varchar(100),coverForDetail varchar(100),coverForFeed varchar(100),coverForSharing varchar(100),description varchar(200),playUrl varchar(100),rawWebUrl varchar(100),title varchar(100),webUrl varchar(100),collectionCount int,playCount int,replyCount int,shareCount int,name1 varchar(50),type1 varchar(50),url1 varchar(100),name2 varchar(50),type2 varchar(50),url2 varchar(100))"]) {
            //            NSLog(@"创建表成功");
        }
    }
    return self;
}

- (BOOL)addMovie:(XRVideoModel *)movie
{
    if (movie.playInfo.count == 2) {
        return [_db executeUpdate:@"insert into TbCacheMovie values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", movie.identifier, movie.date, movie.duration, movie.idx, movie.category, movie.coverBlurred, movie.coverForDetail, movie.coverForFeed, movie.coverForSharing, movie.description, movie.playUrl, movie.rawWebUrl, movie.title, movie.webUrl, movie.consumption[@"collectionCount"], movie.consumption[@"playCount"], movie.consumption[@"replyCount"], movie.consumption[@"shareCount"],  movie.playInfo[0][@"name"], movie.playInfo[0][@"type"], movie.playInfo[0][@"url" ], movie.playInfo[1][@"name"], movie.playInfo[1][@"type"], movie.playInfo[1][@"url"]];
    } else {
        return [_db executeUpdate:@"insert into TbCacheMovie values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", movie.identifier, movie.date, movie.duration, movie.idx, movie.category, movie.coverBlurred, movie.coverForDetail, movie.coverForFeed, movie.coverForSharing, movie.description, movie.playUrl, movie.rawWebUrl, movie.title, movie.webUrl, movie.consumption[@"collectionCount"], movie.consumption[@"playCount"], movie.consumption[@"replyCount"], movie.consumption[@"shareCount"],  movie.playInfo[0][@"name"], movie.playInfo[0][@"type"], movie.playInfo[0][@"url" ], nil, nil, nil];
    }
    return NO;
}

- (BOOL)removeMovie:(XRVideoModel *)movie
{
    return [_db executeUpdate:@"delete from TbCacheMovie where identifier=?", movie.identifier];
}

- (NSArray *)getAllMovies
{
    NSMutableArray *empsArray = [NSMutableArray array];
    FMResultSet *rs = [_db executeQuery:@"select * from TbCacheMovie"];
    while ([rs next]) {
        XRVideoModel *model = [[XRVideoModel alloc] init];
        [model setCategory:[rs stringForColumn:@"category"]];
        [model setConsumption:@{@"collectionCount": [rs objectForColumnName:@"collectionCount"], @"playCount": [rs objectForColumnName:@"playCount"], @"replyCount": [rs objectForColumnName:@"replyCount"], @"shareCount": [rs objectForColumnName:@"shareCount"]}];
        [model setCoverBlurred:[rs stringForColumn:@"coverBlurred"]];
        [model setCoverForDetail:[rs stringForColumn:@"coverForDetail"]];
        [model setCoverForFeed:[rs stringForColumn:@"coverForFeed"]];
        [model setCoverForSharing:[rs stringForColumn:@"coverForSharing"]];
        [model setDescription:[rs stringForColumn:@"description"]];
        [model setPlayUrl:[rs stringForColumn:@"playUrl"]];
        [model setRawWebUrl:[rs stringForColumn:@"rawWebUrl"]];
        [model setTitle:[rs stringForColumn:@"title"]];
        [model setWebUrl:[rs stringForColumn:@"webUrl"]];
        
        [model setDate:[rs objectForColumnName:@"date"]];
        [model setDuration:[rs objectForColumnName:@"duration"]];
        [model setIdentifier:[rs objectForColumnName:@"identifier"]];
        [model setIdx:[rs objectForColumnName:@"idx"]];
        
        if ([rs stringForColumn:@"name2"]) {
            [model setPlayInfo:@[@{@"name": [rs stringForColumn:@"name1"], @"type": [rs stringForColumn:@"type1"], @"url": [rs stringForColumn:@"url1"]}, @{@"name": [rs stringForColumn:@"name2"], @"type": [rs stringForColumn:@"type2"], @"url": [rs stringForColumn:@"url2"]}]];
        } else {
            [model setPlayInfo:@[@{@"name": [rs stringForColumn:@"name1"], @"type": [rs stringForColumn:@"type1"], @"url": [rs stringForColumn:@"url1"]}]];
        }
        
        
        [empsArray addObject:model];
    }
    
    return [empsArray copy];
}

@end
