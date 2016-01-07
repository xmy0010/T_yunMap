//
//  CustomCalloutView.h
//  T_yunMap
//
//  Created by T_yun on 16/1/7.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCalloutView : UIView

/**商户图*/
@property (nonatomic, strong) UIImage *image;
/**商户名*/
@property (nonatomic, copy) NSString *title;
/**地址*/
@property (nonatomic, copy) NSString *subTitle;

@end
