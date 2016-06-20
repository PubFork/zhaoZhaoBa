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

@interface XYVideoViewController () <UIWebViewDelegate>

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

- (void)dealloc
{
    NSLog(@"video dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitleLabelText:@"教学视频"];
    
    
    [self layoutSubViews];
    
    
    WeakSelf(weakSelf);
    
    XYDownloadModel * model = [XYDownloadNetTool getDownloadDic][self.myData[video_ev_videourl]];


    [self.videoImageView clickView:^(UIImageView *view) {
        //play
        if (view.highlighted) {
            
            weakSelf.playerController.contentURL = model.localURL;
            
            [weakSelf.playerController play];
            
        } else {
            if (weakSelf.downloading) {
                [XYDownloadNetTool suspendWithDownloadTask:weakSelf.downloadTask url:weakSelf.myData[video_ev_videourl]];
                weakSelf.downloading = NO;
                [self.myData setValue:nil forKey:download_text_key];
            } else {
                [weakSelf downloadVideo];
            }
        }
    }];
}

- (void)layoutSubViews
{
    [Manager setImageWithImageUrl:self.myData[video_ev_cover] button:self.imageBtn];
    
    [self.webView loadHTMLString:self.myData[video_ev_describe] baseURL:nil];
    
    

    XYDownloadModel * model = [XYDownloadNetTool getDownloadDic][self.myData[video_ev_videourl]];
    self.videoImageView.highlighted = model.isFinish;
    self.downLabel.hidden = model.isFinish;
    self.downLabel.text = model.downloadSpeed;
    
    
    if (!model) {
        model = [XYDownloadModel createDownLoadModeWithDic:self.myData];
    }
    
    model.label = self.downLabel;

    [self addActiveIVToMySelfView];
    
}


- (void)downloadVideo
{
    [self.myData setValue:self forKey:download_text_key];

    self.downloading = YES;
    self.downLabel.hidden = NO;
    
    WeakSelf(weakSelf);
    self.downloadTask = [XYDownloadNetTool  downloadFileURL:self.myData[video_ev_videourl] speed:^(NSString *download) {
        dispatch_async(dispatch_get_main_queue(), ^{
//            weakSelf.downLabel.text = download;
        });
    } finish:^(NSString *filePath) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.downLabel.hidden = YES;
            weakSelf.videoImageView.highlighted = YES;
            [weakSelf.myData setValue:nil forKey:download_text_key];
        });
    }];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self removeActiveIVFromSelfView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self removeActiveIVFromSelfView];
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
