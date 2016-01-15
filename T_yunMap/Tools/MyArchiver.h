//
//  MyArchiver.h
//  T_yunMap
//
//  Created by T_yun on 16/1/15.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyArchiver : NSObject

+ (void)archiverWithObject:(id)obj forKey:(NSString *)key;

+ (id)fetchWithKey:(NSString *)key;

+ (void)removeData;

@end
