//
//  XRDailyTableViewCell.m
//  GreatVideo
//
//  Created by Xinri on 15/10/13.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import "XRDailyTableViewCell.h"
#import "Common.h"
#import "XRVideoModel.h"

@interface XRDailyTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *videoTitle;
@property (weak, nonatomic) IBOutlet UILabel *videoCategory;
@property (weak, nonatomic) IBOutlet UILabel *videoDuration;
@property (weak, nonatomic) IBOutlet UILabel *rankListPositon;

@end

@implementation XRDailyTableViewCell

- (void)setRankPosition:(NSInteger)rankPosition
{
    [_rankListPositon setHidden:NO];
    _rankPosition = rankPosition;
    [_rankListPositon setText:[NSString stringWithFormat:@"%ld", (long)_rankPosition]];
}

- (void)setVideoModel:(XRVideoModel *)videoModel
{
    _videoModel = videoModel;
    
    [_bgImageView sd_setImageWithURL:[NSURL URLWithString:_videoModel.coverForFeed]];
    [_videoTitle setText:_videoModel.title];
    [_videoCategory setText:[NSString stringWithFormat:@"#%@", _videoModel.category]];
    [_videoDuration setText:[NSString stringWithFormat:@"%d' %d", _videoModel.duration.intValue / 60, _videoModel.duration.intValue % 60]];
}

@end
