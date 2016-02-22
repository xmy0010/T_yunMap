//
//  XRRanklistTopView.h
//  GreatVideo
//
//  Created by Xinri on 15/10/14.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XRRanklistTopViewDelegate <NSObject>

- (void)ranklistButtonClicked:(NSString *)sortType;

@end

@interface XRRanklistTopView : UIView

@property (weak, nonatomic) id<XRRanklistTopViewDelegate> delegate;

@end
