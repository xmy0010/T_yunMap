//
//  MyArchiver.m
//  T_yunMap
//
//  Created by T_yun on 16/1/15.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "MyArchiver.h"

@implementation MyArchiver

+ (void)archiverWithObject:(id)obj forKey:(NSString *)key {
    

    //实例化一个文件管理类
//    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //判断路径下的文件是否存在
//    if ([fileManager fileExistsAtPath:[self searchFilePath]] == NO) {
        //不存在则创建路径文件
        
        //mutabeData用来存储归档完成以后的数据
        NSMutableData *data = [NSMutableData data];
        
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        
        //归档
        [archiver encodeObject:obj forKey:key];
        
        //完成归档
        [archiver finishEncoding];
        
        //写入文件
        [data writeToFile:[self searchFilePath] atomically:YES];
//    }
    
    
}

+ (void)removeData {

    NSFileManager *manager = [NSFileManager defaultManager];
    
    [manager removeItemAtPath:[self searchFilePath] error:nil];
}

+ (id)fetchWithKey:(NSString *)key {
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSMutableArray *arr = @[].mutableCopy;
    if ([manager fileExistsAtPath:[self searchFilePath]]) {
        
        NSMutableData *data = [NSMutableData dataWithContentsOfFile:[self searchFilePath]];
        
        //反归档操作
        NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        
        arr = [unArchiver decodeObjectForKey:key];
        
        //完成归档
        [unArchiver finishDecoding];
    }
    
    return arr;
}


+ (NSString *)searchFilePath {

    NSString *tempDirectory = NSHomeDirectory();
    NSString *filePath = [tempDirectory stringByAppendingPathComponent:@"Documents/tip.data"];
    
    NSLog(@"%@", filePath);
    return filePath;
    
}


@end
