//
//  XRDbTool.m
//  
//
//  Created by Xinri on 15/9/16.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import "XRDbTool.h"

@implementation XRDbTool

+ (FMDatabase *)createDBWithFileName:(NSString *)filename
{
    NSString *filePath =  [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@", filename]];
    
    return [FMDatabase databaseWithPath:filePath];
}

+ (void)closeDB:(FMDatabase *)db
{
    if (db) {
        [db close];
    }
}

@end
