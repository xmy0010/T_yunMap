//
//  XRRootViewController.h
//  JustWalk
//
//  Created by Xinri on 15/10/12.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"

/*!
 1.检测网络
 2.加载控件
 3.导航栏的设置
 4.多个子类都具有功能的接口
 */
@interface XRRootViewController : UIViewController
{
@private
    // 在父类声明一个全局的_hud指针 使得子类也可以对_hud进行操作
    JGProgressHUD *_hud;
    // 蒙板
    UIView *_hudView;
}

/**添加加载控件*/
- (void)showHudWithString:(NSString *)title frame:(CGRect)frame;
// 隐藏HUD
- (void)hideHud;

// 弹出模态框
- (void)showAlertWithString:(NSString *)str;

// 设置导航栏样式
- (void)setNavStyle;

@end
