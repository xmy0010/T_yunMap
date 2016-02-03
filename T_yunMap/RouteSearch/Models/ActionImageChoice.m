//
//  ActionImageChoice.m
//  T_yunMap
//
//  Created by T_yun on 16/1/23.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "ActionImageChoice.h"

@implementation ActionImageChoice

+ (UIImage *)ChoseImageWithAction:(NSString *)action {

    NSArray *actionsArray = @[@"左前",
                              @"左后",
                              @"右前",
                              @"右后",
                              @"直行",
                              @"左",
                              @"右",
                              @"掉头"];
    
    for (int index = 0; index < actionsArray.count; index++) {
        
        if ([action containsString:actionsArray[index]]) {
            
             UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"default_navi_action_%d", index]];
            return image;
        }
    }

    return nil;
}

@end
