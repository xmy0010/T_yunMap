//
//  XRCacheMovieDao.h
//  BestLove
//
//  Created by Xinri on 15/10/17.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "XRVideoModel.h"

/**cacheMovieDao*/
@interface XRCacheMovieDao : NSObject
{
    FMDatabase *_db;
}

- (BOOL)addMovie:(XRVideoModel *)movie;
- (BOOL)removeMovie:(XRVideoModel *)movie;

- (NSArray *)getAllMovies;

@end
