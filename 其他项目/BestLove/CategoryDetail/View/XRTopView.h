//
//  XRTopView.h
//  GreatVideo
//
//  Created by 鑫 李 on 15/10/14.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XRTopViewDelegate <NSObject>

- (void)sortButtonClicked:(NSString *)sortType;

@end

@interface XRTopView : UIView

@property (weak, nonatomic) id<XRTopViewDelegate> delegate;

@end
