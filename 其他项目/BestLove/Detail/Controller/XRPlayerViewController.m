//
//  XRPlayerViewController.m
//  GreatVideo
//
//  Created by Xinri on 15/10/14.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import "XRPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "XRVideoModel.h"
#import "XRPlayerSettingView.h"
#import "XRMovieDao.h"
#import "UMSocial.h"
#import "XRCacheMovieDao.h"

@interface XRPlayerViewController () <UMSocialUIDelegate>
{
    AVPlayer *_player;
    AVPlayerLayer *_playerLayer;
    
    XRPlayerSettingView *_settingView;
    
    UIActivityIndicatorView *_indicator;
    
    UILabel *_volumeLabel;
    
    float _volume;
    float _tempY;
    float _delta;
    BOOL _isFlag;
    
    XRMovieDao *_Dao;
    XRCacheMovieDao *_cacheDao;
    
    BOOL _isShared;
    
    NSString *_playUrl;
}

@end

@implementation XRPlayerViewController

- (instancetype)initWithModel:(XRVideoModel *)model
{
    if (self = [super init]) {
        self.model = model;
//        self.view = [[NSBundle mainBundle] loadNibNamed:@"XRPlayerViewController" owner:self options:nil].firstObject;
//        [self.view setFrame:CGRectMake(0, 0, screen_height, screen_width)];
        self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (!_isShared) {
        [super viewWillDisappear:animated];
        [_player replaceCurrentItemWithPlayerItem:nil];
        _player = nil;
        [self removeFromParentViewController];
        [self.view removeFromSuperview];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _Dao = [[XRMovieDao alloc] init];
    _cacheDao = [[XRCacheMovieDao alloc] init];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self setLoadingImage];
    
    // 添加视频
    _player = [AVPlayer playerWithPlayerItem:[self getPlayerItem:_model.playUrl]];
    _playUrl = _model.playUrl;
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    [playerLayer setFrame:CGRectMake(0, 0, screen_height, screen_width)];
    [playerLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.view.layer addSublayer:playerLayer];
    _playerLayer = playerLayer;
    
    // 视频开始播放
    [_player play];
    [_player setVolume:0.5];
    _delta = 0.5;
    
    // 设置音量视图
    [self setVolueView];
    
    // 设置进度条
    [self setProgress];
    
    // 创建视频的设置视图
    [self setSettingView];
}

#pragma mark - 设置音量视图
- (void)setVolueView
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, screen_width / 2 - 15, 100, 30)];
    [label setText:@"音量: 50"];
    [label setFont:[UIFont fontWithName:@"Lobster 1.4" size:13]];
    [label setTextColor:[UIColor whiteColor]];
    
    UIPanGestureRecognizer *r = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:r];
    
    [self.view addSubview:label];
    _volumeLabel = label;
    [_volumeLabel setHidden:YES];
}

#warning 音量设置不准确
- (void)pan:(UIPanGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        [_volumeLabel setHidden:NO];
        [_settingView setHidden:YES];
    }
    
    CGPoint point = [sender translationInView:self.view];
    if (point.y < 0) {
        if (fabs(point.y / 200) + _player.volume <=1) {
            [_player setVolume:fabs(point.y / 200) + _player.volume];
        }
    } else {
        if (_player.volume -  fabs(point.y / 200) >= 0) {
            [_player setVolume:_player.volume -  fabs(point.y / 200)];
        }
    }
//    NSLog(@"%f", _player.volume);
    [UIView animateWithDuration:1 animations:^{
        [_volumeLabel setText:[NSString stringWithFormat:@"音量: %d", (int)(_player.volume * 100)]];
    }];
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        [_volumeLabel setHidden:YES];
    }
}

#pragma mark - 设置进度条
- (void)setProgress
{
    __weak AVPlayer *player = _player;
    [player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        float currentTime = CMTimeGetSeconds(time);
        float totalTime = CMTimeGetSeconds(player.currentItem.duration);
        if (currentTime) {
//            [progressView setProgress:(currentTime / totalTime) animated:YES];
            if ((int)currentTime == 0) {
                [_indicator stopAnimating];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Progress" object:@(currentTime / totalTime)];
        }
//        [timeLabel setText:[NSString stringWithFormat:@"%02d:%02d/%02d:%02d", (int)currentTime / 60, (int)currentTime % 60, (int)totalTime / 60, (int)totalTime % 60]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CurrentTime" object:[NSString stringWithFormat:@"%02d:%02d", (int)currentTime / 60, (int)currentTime % 60]];
    }];
}

#pragma mark - 创建视频的设置视图
- (void)setSettingView
{
    _settingView = [[XRPlayerSettingView alloc] initWithModel:_model];
    [_settingView setFrame:self.view.bounds];
    
    if ([_cacheDao getAllMovies].count == 0) {
    } else {
        for (XRVideoModel *cacheModel in [_cacheDao getAllMovies]) {
            if (cacheModel.identifier == _model.identifier) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"Local" object:nil];
            }
        }
    }
    
    XRPlayerViewController *playerViewController = self;
    AVPlayer *player = _player;
    UIActivityIndicatorView *indicator = _indicator;
    
    [_settingView setBackButtonClickedBlock:^{
        [player pause];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Pause" object:nil];
        [playerViewController dismissViewControllerAnimated:NO completion:nil];
    }];
    [_settingView setPlayButtonClickedBlock:^(BOOL playFlag) {
        playFlag ? [player pause] : [player play];
    }];
    [_settingView setSliderButtonClickedBlock:^(float value) {
        [indicator startAnimating];
        float seconds = _model.duration.floatValue * value;
        CMTime time = CMTimeMakeWithSeconds(seconds, 1.0);
        [player seekToTime:time completionHandler:^(BOOL finished) {
            [indicator stopAnimating];
            [player play];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Play" object:nil];
        }];
    }];
    [_settingView setPlayDoneBlock:^{
        [playerViewController dismissViewControllerAnimated:NO completion:nil];
    }];
    XRMovieDao *Dao = _Dao;
    XRVideoModel *model = _model;
    [_settingView setCollectButtonClicked:^{
        NSArray *array = [Dao getAllMovies];
        int flag = 0;
        if (array.count == 0) {
            if ([Dao addMovie:model]) {
                [playerViewController showCollectMsg:@"收藏成功"];
            }
        } else {
            for (XRVideoModel *tempModel in array) {
                if (tempModel.identifier.intValue == model.identifier.intValue) {
                    [playerViewController showCollectMsg:@"已经收藏,请前往个人中心查看"];
                } else {
                    flag ++;
                }
                if (flag == array.count) {
                    if ([Dao addMovie:model]) {
                        [playerViewController showCollectMsg:@"收藏成功"];
                    }
                }
            }
        }
    }];
    [_settingView setShareButtonClicked:^{
        [player pause];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Pause" object:nil];
        _isShared = YES;
        [UMSocialSnsService presentSnsIconSheetView:playerViewController
                                             appKey:@"56211784e0f55aa49f001c41"
                                          shareText:[NSString stringWithFormat:@"%@ -来自<最爱-BestLove>", model.description]
                                         shareImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.coverForSharing]]]
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToTencent,UMShareToSina,UMShareToQQ,UMShareToWechatTimeline,nil]
                                           delegate:playerViewController];
    }];
    __block NSString *playUrl = _playUrl;
    [_settingView setChangeTypeButtonClicked:^{
        if (_model.playInfo.count == 2) {
            if ([playUrl isEqualToString:model.playInfo[0][@"url"]]) {
                [player replaceCurrentItemWithPlayerItem:[playerViewController getPlayerItem:model.playInfo[1][@"url"]]];
                [player play];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeType" object:@(1)];
                playUrl = model.playInfo[1][@"url"];
            } else {
                [player replaceCurrentItemWithPlayerItem:[playerViewController getPlayerItem:model.playInfo[0][@"url"]]];
                [player play];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeType" object:@(0)];
                playUrl = model.playInfo[0][@"url"];
            }
        }
    }];
    
    [self.view addSubview:_settingView];
    [_settingView setHidden:YES];
    
#warning 截图
    __weak XRPlayerSettingView *settingView = _settingView;
    AVPlayerLayer *pLayer = _playerLayer;
    [settingView setPrintScreenmButtonClicked:^{
        [settingView setHidden:YES];
        //延迟1秒保存
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
            
            UIGraphicsBeginImageContext(pLayer.bounds.size);
            
            [pLayer renderInContext:UIGraphicsGetCurrentContext()];
            
            UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
            
            //将截屏保存到相册
            UIImageWriteToSavedPhotosAlbum(viewImage,self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        });
    }];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [self showCollectMsg:@"保存失败,请检查是否拥有相关的权限"];
    } else {
        [self showCollectMsg:@"保存成功!请前往系统相册查看!"];
    }
}

#pragma mark - UMSocialUIDelegate
- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    if (response.responseCode == UMSResponseCodeSuccess) {
        [_player play];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Play" object:nil];
    }
    _isShared = NO;
}

#pragma mark - 弹出收藏提示
- (void)showCollectMsg:(NSString *)str
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, screen_width / 2 - 40, screen_height, 40)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:str];
    [label setFont:[UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:14]];
    [label setBackgroundColor:[UIColor blackColor]];
    [label setTextColor:[UIColor whiteColor]];
    [self.view addSubview:label];
    [UIView animateWithDuration:4 animations:^{
        [label setAlpha:0];
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_settingView setAlpha:1];
    [_settingView setHidden:!_settingView.hidden];
}

#pragma mark - 得到一个播放item
- (AVPlayerItem *)getPlayerItem:(NSString *)url
{
    int flag = 0;
    AVPlayerItem *playerItem = nil;
    if ([_cacheDao getAllMovies].count == 0) {
        playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:url]];
    } else {
        for (XRVideoModel *cacheModel in [_cacheDao getAllMovies]) {
            if (cacheModel.identifier == _model.identifier) {
                NSString *savedName = [[cacheModel playUrl] componentsSeparatedByString:@"/"].lastObject;
                NSString *savedPath = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), savedName];
                playerItem = [AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:savedPath]];
            } else {
                flag ++;
            }
            if (flag == [_cacheDao getAllMovies].count) {
                playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:url]];
            }
        }
    }
    
    return playerItem;
}

// 支持设备自动旋转
- (BOOL)shouldAutorotate
{
    return YES;
}

// 支持横竖屏显示
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeLeft;
}

// 设置视频加载时的小圈圈
- (void)setLoadingImage
{
    _indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(screen_height / 2 - 22, screen_width / 2 - 22, 44, 44)];
    [self.view addSubview:_indicator];
    [_indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [_indicator startAnimating];
}

@end
