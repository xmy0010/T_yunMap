//
//  XRCategoryDatailModel.h
//  GreatVideo
//
//  Created by 鑫 李 on 15/10/14.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import "XRRootModel.h"

@interface XRCategoryDatailModel : XRRootModel

@property (strong, nonatomic) NSNumber *count;
ProStr(nextPageUrl);
@property (strong, nonatomic) NSMutableArray *videoList;

@end
