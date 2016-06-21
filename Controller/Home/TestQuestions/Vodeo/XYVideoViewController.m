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

#import "XYPlayViewViewController.h"

@interface XYVideoViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *imageBtn;
@property (weak, nonatomic) IBOutlet XYAddActionImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *downLabel;

//@property (nonatomic, strong)AVPlayer * player;

@property (nonatomic, strong)XYPlayViewViewController * playVC;

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
    
    XYDownloadModel * model = [XYDownloadModel downloadModelWithDic:self.myData];

    [self.videoImageView clickView:^(UIImageView *view) {
        [model clickImageViewWithPlayBlock:^(NSURL *url) {
            weakSelf.playVC.URL = url;
            [weakSelf presentViewController:weakSelf.playVC animated:YES completion:nil];
        } suspendBlock:^{
            
        } downloadBlock:^{
            weakSelf.downLabel.hidden = NO;
            [weakSelf.myData setValue:weakSelf forKey:download_text_key];
        } finishBolick:^{
            weakSelf.downLabel.hidden = YES;
            [weakSelf.myData setValue:nil forKey:download_text_key];
        }];
    }];
}

- (void)layoutSubViews
{
    [Manager setImageWithImageUrl:self.myData[video_ev_cover] button:self.imageBtn];
    
    [self.webView loadHTMLString:self.myData[video_ev_describe] baseURL:nil];
    
    

    XYDownloadModel * model = [XYDownloadModel downloadModelWithDic:self.myData];
    self.videoImageView.highlighted = model.isFinish;
    self.downLabel.hidden = model.isFinish;
    self.downLabel.text = model.downloadSpeed;

    
    model.label = self.downLabel;
    model.imageView = self.videoImageView;

    [self addActiveIVToMySelfView];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self removeActiveIVFromSelfView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self removeActiveIVFromSelfView];
}


- (XYPlayViewViewController *)playVC
{
    if (!_playVC) {
        _playVC = [[XYPlayViewViewController alloc] init];
    }
    return _playVC;
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
