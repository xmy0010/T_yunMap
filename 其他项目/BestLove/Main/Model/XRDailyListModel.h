//
//  XRDailyListModel.h
//  GreatVideo
//
//  Created by Xinri on 15/10/13.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import "XRRootModel.h"

@interface XRDailyListModel : XRRootModel

@property (strong, nonatomic) NSMutableArray *dailyList;
ProStr(nextPageUrl);
@property (strong, nonatomic) NSNumber *nextPublishTime;

@end
