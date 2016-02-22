//
//  XRVideoListModel.h
//  GreatVideo
//
//  Created by Xinri on 15/10/13.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import "XRRootModel.h"

@interface XRVideoModel : XRRootModel

ProStr(category);
ProDict(consumption);
ProStr(coverBlurred);
ProStr(coverForDetail);
ProStr(coverForFeed);
ProStr(coverForSharing);
ProStr(description);
@property (strong, nonatomic) NSNumber *date;
@property (strong, nonatomic) NSNumber *duration;
@property (strong, nonatomic) NSNumber *identifier;
@property (strong, nonatomic) NSNumber *idx;
ProArr(playInfo);
ProStr(playUrl);
ProStr(rawWebUrl);
ProStr(title);
ProStr(webUrl);

@end
