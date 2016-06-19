//
//  XYVideoViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/6/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYVideoViewController.h"
#import "XYAddActionImageView.h"
#import "XYDownloadNetTool.h"
#import "XYTestQuestionsNetTool.h"

#import <MediaPlayer/MediaPlayer.h>

@interface XYVideoViewController ()

@property (weak, nonatomic) IBOutlet UIButton *imageBtn;
@property (weak, nonatomic) IBOutlet XYAddActionImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *downLabel;


@property (nonatomic, assign)BOOL downloading;
@property (nonatomic, strong)NSURLSessionDownloadTask * downloadTask;

//@property (nonatomic, strong)AVPlayer * player;

@property (nonatomic, strong)MPMoviePlayerController * playerController;
@end

@implementation XYVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitleLabelText:@"教学视频"];
    
    
    [self layoutSubViews];
    
    
    [self.videoImageView clickView:^(UIImageView *view) {
        //play
        if (view.highlighted) {
            
            self.playerController.contentURL = [XYDownloadNetTool getVideoURLWithUrl:self.myData[video_ev_videourl]];
            
            [self.playerController play];
            
        } else {
            
            if (self.downloading) {
                [XYDownloadNetTool suspendWithDownloadTask:self.downloadTask url:self.myData[video_ev_videourl]];
                self.downloading = NO;
            } else {
                self.downloading = YES;
                self.downLabel.hidden = NO;
                WeakSelf(weakSelf);
                
                self.downloadTask = [XYDownloadNetTool  downloadFileURL:self.myData[video_ev_videourl] speed:^(NSString *download) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        weakSelf.downLabel.text = download;
                    });
                } finish:^(NSString *filePath) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSURL * URL = [NSURL URLWithString:filePath];
                        self.playerController.contentURL = URL;
                        
                        [self.playerController play];
                        
                        weakSelf.downLabel.hidden = YES;
                        view.highlighted = YES;
                    });
                }];
            }
           

        }
    }];
}

- (void)layoutSubViews
{
    [Manager setImageWithImageUrl:self.myData[video_ev_cover] button:self.imageBtn];
    
    [self.webView loadHTMLString:self.myData[video_ev_describe] baseURL:nil];
    
    
    NSURL * url = [XYDownloadNetTool getVideoURLWithUrl:self.myData[video_ev_videourl]];
    self.videoImageView.highlighted = url;
    
}


- (MPMoviePlayerController *)playerController
{
    
    if (_playerController == nil) {
    

        _playerController = [[MPMoviePlayerController alloc] init];
        _playerController.view.frame = self.view.frame;
        _playerController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;

        _playerController.controlStyle = MPMovieControlStyleFullscreen;
        
//        CGAffineTransform landscapeTransform = CGAffineTransformMakeRotation(M_PI / 2);
//        _playerController.view.transform = landscapeTransform;
//        _playerController.scalingMode = MPMovieScalingModeAspectFill;
        
        [self.view addSubview:_playerController.view];


    }
    return _playerController;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
