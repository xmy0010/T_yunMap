//
//  XRDetailViewController.m
//  GreatVideo
//
//  Created by Xinri on 15/10/14.
//  Copyright (c) 2015年 Xinri. All rights reserved.
//

#import "XRDetailViewController.h"
#import "XRVideoModel.h"
#import "XRPlayerViewController.h"
#import "XRMovieDao.h"
#import "UMSocial.h"
#import "XRCacheMovieDao.h"
#import "AppDelegate.h"
#import "XRCacheModel.h"

@interface XRDetailViewController () <UMSocialUIDelegate>
{
    UIImageView *_imageView;
    
    XRMovieDao *_Dao;
    XRCacheMovieDao *_cacheDao;
}

@property (weak, nonatomic) IBOutlet UIButton *videoImageButton;
@property (weak, nonatomic) IBOutlet UILabel *videoTitle;
@property (weak, nonatomic) IBOutlet UILabel *videoType;
@property (weak, nonatomic) IBOutlet UILabel *videoDuration;
@property (weak, nonatomic) IBOutlet UILabel *videoDesc;

@property (weak, nonatomic) IBOutlet UIButton *collectButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *cacheButton;

@end

@implementation XRDetailViewController

- (instancetype)initWIthRootViewFrame:(CGRect)frame andModel:(XRVideoModel *)model
{
    if (self = [super init]) {
        self.view = [[NSBundle mainBundle] loadNibNamed:@"XRDetailViewController" owner:self options:nil].firstObject
        ;
        [self.view setFrame:frame];
        
        _Dao = [[XRMovieDao alloc] init];
        _cacheDao = [[XRCacheMovieDao alloc] init];
        
        int flag = 0;
        if ([_cacheDao getAllMovies].count == 0) {
            self.videoModel = model;
        } else {
            for (XRVideoModel *cacheModel in [_cacheDao getAllMovies]) {
                if (cacheModel.identifier == model.identifier) {
                    self.videoModel = cacheModel;
                } else {
                    flag ++;
                }
                if (flag == [_cacheDao getAllMovies].count) {
                    self.videoModel = model;
                }
            }
        }
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_imageView setFrame:CGRectMake(_videoImageButton.bounds.origin.x, _videoImageButton.bounds.origin.y, _videoImageButton.bounds.size.width * 1.25, _videoImageButton.bounds.size.height * 1.25)];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self imageAnimaiton];
}

- (void)imageAnimaiton
{
    [UIView animateWithDuration:20 animations:^{
        [_imageView setTransform:CGAffineTransformMakeScale(1.5, 1.5)];
        //                [_imageView.layer setMasksToBounds:YES];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:20 animations:^{
            [_imageView setTransform:CGAffineTransformMakeScale(1.25, 1.25)];
        }];
    }];
}

- (IBAction)palyButtonClicked:(id)sender {
    
    XRPlayerViewController *playerViewController = [[XRPlayerViewController alloc] initWithModel:_videoModel];
    
    [self presentViewController:playerViewController animated:NO completion:nil];
    
//    [self.navigationController pushViewController:playerViewController animated:YES];
}

- (void)setVideoModel:(XRVideoModel *)videoModel
{
    _videoModel = videoModel;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(_videoImageButton.bounds.origin.x, _videoImageButton.bounds.origin.y, _videoImageButton.bounds.size.width * 1.25, _videoImageButton.bounds.size.height * 1.25)];
//    [imageView setTransform:CGAffineTransformMakeScale(1.25, 1.25)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:_videoModel.coverForDetail]];
    [_videoImageButton addSubview:imageView];
    [_videoImageButton setClipsToBounds:YES];
    _imageView = imageView;
    
    [_videoTitle setText:_videoModel.title];
    [_videoType setText:[NSString stringWithFormat:@"#%@", _videoModel.category]];
    [_videoDuration setText:[NSString stringWithFormat:@"%d' %d", _videoModel.duration.intValue / 60, _videoModel.duration.intValue % 60]];
    
    [_videoDesc setText:_videoModel.description];

    int flag = 0;
    if ([_Dao getAllMovies].count == 0) {
        [_collectButton setTitle:[NSString stringWithFormat:@"收藏 %d", [_videoModel.consumption[@"collectionCount"] intValue]] forState:UIControlStateNormal];
    } else {
        for (XRVideoModel *collectModel in [_Dao getAllMovies]) {
            if (collectModel.identifier == _videoModel.identifier) {
                [_collectButton setTitle:@"已收藏" forState:UIControlStateNormal];
                [_collectButton setEnabled:NO];
            } else {
                flag ++;
            }
            if (flag == [_Dao getAllMovies].count) {
                [_collectButton setTitle:[NSString stringWithFormat:@"收藏 %d", [_videoModel.consumption[@"collectionCount"] intValue]] forState:UIControlStateNormal];
            }
        }
    }
    
    int flag1 = 0;
    for (XRVideoModel *cacheModel in [_cacheDao getAllMovies]) {
        if (cacheModel.identifier == videoModel.identifier) {
            [_cacheButton setTitle:@"已缓存" forState:UIControlStateNormal];
            [_cacheButton setEnabled:NO];
        } else {
            flag1 ++;
        }
        if (flag1 == [_cacheDao getAllMovies].count) {
//            AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
//            
//            int flag2 = 0;
//            if (appDelegate.progressArray.count == 0) {
//                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getProgress:) name:@"Cacheing" object:nil];
//            }
//            for (XRCacheModel *cacheModel in appDelegate.progressArray) {
//                if (cacheModel.Identifier.intValue == _videoModel.identifier.intValue) {
//                    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getProgress:) name:[NSString stringWithFormat:@"%d-Cacheing", cacheModel.Identifier.intValue] object:nil];
//                } else {
//                    flag2 ++;
//                }
//                if (flag2 == appDelegate.progressArray.count) {
//                    [_cacheButton setTitle:@"缓存" forState:UIControlStateNormal];
//                    [_cacheButton setEnabled:YES];
//                }
//            }
        }
    }
    
    [_shareButton setTitle:[NSString stringWithFormat:@"分享 %d", [_videoModel.consumption[@"shareCount"] intValue]] forState:UIControlStateNormal];
    
    [self.view setNeedsDisplay];
}

// 更新缓存进度
- (void)getProgress:(NSNotification *)note
{
    float progress = [note.object floatValue];
    [_cacheButton setTitle:[NSString stringWithFormat:@"缓存 %d%%", (int)(progress * 100)] forState:UIControlStateNormal];
    [_cacheButton setEnabled:NO];
    if (progress == 1) {
        [_cacheButton setTitle:@"已缓存" forState:UIControlStateNormal];
        [_cacheButton setEnabled:NO];
    }
}

- (IBAction)collectButtonClicked:(UIButton *)sender {
//    NSLog(@"%@", NSHomeDirectory());
    NSArray *array = [_Dao getAllMovies];
    int flag = 0;
    if (array.count == 0) {
        if ([_Dao addMovie:_videoModel]) {
            [self showCollectMsg:@"收藏成功"];
            [sender setEnabled:NO];
            [sender setTitle:@"已收藏" forState:UIControlStateNormal];
        }
    } else {
        for (XRVideoModel *model in array) {
            if (model.identifier.intValue == _videoModel.identifier.intValue) {
//                [self showCollectMsg:@"已经收藏,请前往个人中心查看"];
            } else {
                flag ++;
            }
            if (flag == array.count) {
                if ([_Dao addMovie:_videoModel]) {
                    [self showCollectMsg:@"收藏成功"];
                    [sender setEnabled:NO];
                    [sender setTitle:@"已收藏" forState:UIControlStateNormal];
                }
            }
        }
    }
}

#pragma mark - 弹出收藏提示
- (void)showCollectMsg:(NSString *)str
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, screen_height / 2 - 40, screen_width, 40)];
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

- (IBAction)shareButtonClicked:(id)sender {
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"56211784e0f55aa49f001c41"
                                      shareText:[NSString stringWithFormat:@"%@ -来自<最爱-BestLove>", _videoModel.description]
                                     shareImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_videoModel.coverForSharing]]]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToTencent,UMShareToSina,UMShareToRenren,nil]
                                       delegate:self];
}

- (IBAction)cacheButtonClicked:(id)sender {
    [sender setEnabled:NO];
    NSString *savedName = [_videoModel.playUrl componentsSeparatedByString:@"/"].lastObject;
    NSString *savedPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", savedName];
    [self downloadFileWithOption:nil
                   withInferface:[NSString stringWithFormat:@"%@%@", URL_Download, savedName]
               savedPath:savedPath
         downloadSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            // 缓存成功后添加进数据库
             [_cacheDao addMovie:_videoModel];
             [_cacheButton setTitle:@"已缓存" forState:UIControlStateNormal];
         } downloadFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
             // 缓存失败后删除已缓存数据
             NSString *savedPath = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), savedName];
             NSFileManager * fileManager = [[NSFileManager alloc]init];
             [fileManager removeItemAtPath:savedPath error:nil];
             [sender setEnabled:YES];
         } progress:^(float progress) {
             [_cacheButton setTitle:[NSString stringWithFormat:@"缓存 %d%%", (int)(progress * 100)] forState:UIControlStateNormal];
#warning 在缓存过程中退出详情视图控制器再次进入时有BUG
//             [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"%d-Cacheing", _videoModel.identifier.intValue] object:@(progress)];
//             
//             AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
//             int flag;
//             if (appDelegate.progressArray.count == 0) {
//                 XRCacheModel *cacheModel = [[XRCacheModel alloc] init];
//                 [cacheModel setIdentifier:_videoModel.identifier];
//                 [appDelegate.progressArray addObject:cacheModel];
//             } else {
//                 for (XRCacheModel *model in appDelegate.progressArray) {
//                     if (_videoModel.identifier.intValue == model.Identifier.intValue) {
//                         
//                     } else {
//                         flag ++;
//                     }
//                     if (flag == appDelegate.progressArray.count) {
//                         XRCacheModel *cacheModel = [[XRCacheModel alloc] init];
//                         [cacheModel setIdentifier:_videoModel.identifier];
//                         [appDelegate.progressArray addObject:cacheModel];
//                     }
//                 }
//             }
             
    }];
//    NSLog(@"%@", NSHomeDirectory());
}

- (void)downloadFileWithOption:(NSDictionary *)paramDic
                 withInferface:(NSString*)requestURL
                     savedPath:(NSString*)savedPath
               downloadSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               downloadFailure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
                      progress:(void (^)(float progress))progress

{
    
    //沙盒路径    //NSString *savedPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/xxx.zip"];
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request =[serializer requestWithMethod:@"GET" URLString:requestURL parameters:paramDic error:nil];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:savedPath append:NO]];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        float p = (float)totalBytesRead / totalBytesExpectedToRead;
        progress(p);
//        NSLog(@"download：%f", (float)totalBytesRead / totalBytesExpectedToRead);
    }];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation,responseObject);
        NSLog(@"下载成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
        NSLog(@"下载失败");
        [self showCollectMsg:@"网络拥堵哟, 请再试一次哟~"];
    }];
    
    [operation start];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
