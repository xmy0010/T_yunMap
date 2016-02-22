//
//  XRPlayerSettingView.m
//  BestLove
//
//  Created by Xinri on 15/10/14.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import "XRPlayerSettingView.h"
#import "XRVideoModel.h"
#import "Common.h"
#import "XRMovieDao.h"


@interface XRPlayerSettingView()
{
    BOOL _playFlag;
    
    UIActivityIndicatorView *_indicator;
    
    XRMovieDao *_Dao;
    
    XRVideoModel *_model;
}

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTime;
@property (weak, nonatomic) IBOutlet UILabel *totalTime;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property (weak, nonatomic) IBOutlet UIButton *changeTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *printScreenButton;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;


@end

@implementation XRPlayerSettingView

- (instancetype)initWithModel:(XRVideoModel *)model
{
    self = [[NSBundle mainBundle] loadNibNamed:@"XRPlayerSettingView" owner:nil options:nil].firstObject;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(local) name:@"Local" object:nil];
    
    [_titleLabel setText:model.title];
    [_totalTime setText:[NSString stringWithFormat:@"%02d:%02d", model.duration.intValue / 60, model.duration.intValue % 60]];
    [_slider setMinimumTrackImage:[UIImage imageNamed:@"progress_white"] forState:UIControlStateNormal];
    [_slider setThumbImage:[UIImage imageNamed:@"player_handle"] forState:UIControlStateNormal];
    [_slider setMaximumTrackImage:[UIImage imageNamed:@"progress_gray"] forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(progressChange:) name:@"Progress" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(currentTimeChanged:) name:@"CurrentTime" object:nil];
    
    if (model.playInfo.count == 1) {
        [_changeTypeButton setTitle:model.playInfo[0][@"name"] forState:UIControlStateNormal];
    } else {
        if ([model.playInfo[0][@"url"] isEqualToString:model.playUrl]) {
            [_changeTypeButton setTitle:model.playInfo[0][@"name"] forState:UIControlStateNormal];
        } else {
            [_changeTypeButton setTitle:model.playInfo[1][@"name"] forState:UIControlStateNormal];
        }
    }
    [_changeTypeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_changeTypeButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    [_changeTypeButton.layer setBorderWidth:1];
    [_changeTypeButton.layer setCornerRadius:5];
    [_printScreenButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    [_printScreenButton.layer setBorderWidth:1];
    [_printScreenButton.layer setCornerRadius:5];
    [_collectButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    [_collectButton.layer setBorderWidth:1];
    [_collectButton.layer setCornerRadius:5];
    [_shareButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    [_shareButton.layer setBorderWidth:1];
    [_shareButton.layer setCornerRadius:5];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playButtonBgChange) name:@"Play" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pauseButtonBgChange) name:@"Pause" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeType1:) name:@"ChangeType" object:nil];
    
    _model = model;
    
    return self;
}

- (void)local
{
    [_changeTypeButton setHidden:YES];
}

- (void)changeType1:(NSNotification *)note
{
    int flag = [note.object intValue];
    [_changeTypeButton setTitle:_model.playInfo[flag][@"name"] forState:UIControlStateNormal];
}

- (void)playButtonBgChange
{
    [_playButton setBackgroundImage:[UIImage imageNamed:@"btn_pause"] forState:UIControlStateNormal];
}

- (void)pauseButtonBgChange
{
    [_playButton setBackgroundImage:[UIImage imageNamed:@"btn_play"] forState:UIControlStateNormal];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 监听当前时间
- (void)currentTimeChanged:(NSNotification *)note
{
    [_currentTime setText:note.object];
    if ([_currentTime.text isEqualToString:_totalTime.text]) {
        [_playButton setBackgroundImage:[UIImage imageNamed:@"btn_play"] forState:UIControlStateNormal];
        _playDoneBlock();
//        _playFlag = YES;
//        _playButtonClickdeBloock(_playFlag);
    }
}

#pragma mark - 监听进度条
- (void)progressChange:(NSNotification *)note
{
    [_slider setValue:[note.object doubleValue] animated:NO];
}

- (IBAction)backButtonClicked:(id)sender {
    _backButtonClickedBlock();
}

- (IBAction)changeType:(id)sender {
    _changeTypeButtonClicked();
}

- (IBAction)printScreen:(id)sender {
    _printScreenmButtonClicked();
}

- (IBAction)collect:(id)sender {
    _collectButtonClicked();
}

- (IBAction)share:(id)sender {
    _shareButtonClicked();
}

- (IBAction)playButtonClicked:(UIButton *)sender {
    if (!_playFlag) {
        [sender setBackgroundImage:[UIImage imageNamed:@"btn_play"] forState:UIControlStateNormal];
        _playFlag = YES;
        _playButtonClickedBlock(_playFlag);
    } else {
        [sender setBackgroundImage:[UIImage imageNamed:@"btn_pause"] forState:UIControlStateNormal];
        _playFlag = NO;
        _playButtonClickedBlock(_playFlag);
    }
}

- (IBAction)nextMovie:(id)sender {
    
}

- (IBAction)sliderClicked:(UISlider *)sender {
    _sliderButtonClickedBlock(sender.value);
}

@end
