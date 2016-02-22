//
//  XRRootModel.h
//  JustWalk
//
//  Created by Xinri on 15/10/13.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ProStr(str) @property (copy, nonatomic) NSString *(str);
#define ProArr(arr) @property (strong, nonatomic) NSArray *(arr);
#define ProDict(dict) @property (strong, nonatomic) NSDictionary *(dict);

@interface XRRootModel : NSObject

@end
