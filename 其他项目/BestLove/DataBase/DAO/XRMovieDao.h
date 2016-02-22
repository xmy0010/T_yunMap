//
//  XRMovieDao.h
//  BestLove
//
//  Created by Xinri on 15/10/16.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "XRVideoModel.h"

/**movieDao*/
@interface XRMovieDao : NSObject
{
    FMDatabase *_db;
}

- (BOOL)addMovie:(XRVideoModel *)movie;
- (BOOL)removeMovie:(XRVideoModel *)movie;

- (NSArray *)getAllMovies;

@end
