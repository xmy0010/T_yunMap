//
//  XRDbTool.h
//  
//
//  Created by Xinri on 15/9/16.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface XRDbTool : NSObject

/*!
@method 根据指定的文件名创建数据库连接
@param filename 数据库文件名
@return 指向数据库的FMDatabase指针
 */
+ (FMDatabase *)createDBWithFileName:(NSString *)filename;

/*!
 @method 关闭数据库
 @param db 指向数据库的FMDatabase指针
 */
+ (void)closeDB:(FMDatabase *)db;

@end
