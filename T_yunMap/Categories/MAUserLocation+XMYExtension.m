//
//  MAUserLocation+XMYExtension.m
//  T_yunMap
//
//  Created by T_yun on 16/1/13.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "MAUserLocation+XMYExtension.h"
#import <objc/runtime.h>



@implementation MAUserLocation (XMYExtension)
static char strCityKey = 'a';


//未解决异步问题  暂时搁置-----


- (NSString *)userCity {

    return objc_getAssociatedObject(self, &strCityKey);
}

- (void)setUserCity:(NSString *)userCity {

    objc_setAssociatedObject(self, &strCityKey, userCity, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

//刚开始想创建只读属性  但反地理编码为异步函数  不能实时返回想要的值
//- (NSString *)userCity {
//    //创建一个先进先出的调度队列
//    dispatch_queue_t myQueue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_SERIAL);
//   
//    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
//    
//    __block NSString *city;
//    dispatch_async(myQueue, ^{
//       
//       [geoCoder reverseGeocodeLocation:self.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//           
//           if (error) {
//               NSLog(@"%@", error.localizedDescription);
//               return ;
//           }
//           CLPlacemark *placemark = [placemarks firstObject];
//           NSDictionary *address = placemark.addressDictionary;
//           city = address[@"City"];
//           
//           
//       }];
//   });
//    
//    return city;
//    
//}


@end
