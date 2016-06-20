//
//  XYPlayViewViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/6/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYPlayViewViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface XYPlayViewViewController ()
@property (nonatomic, strong)MPMoviePlayerController * playerController;

@end

@implementation XYPlayViewViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.playerController.contentURL = self.URL;
    [self.playerController play];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskLandscapeRight;
//}
// Returns interface orientation masks.
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (MPMoviePlayerController *)playerController
{
    
    if (_playerController == nil) {
        
        
        _playerController = [[MPMoviePlayerController alloc] init];
        _playerController.view.frame = self.view.frame;
        _playerController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        _playerController.controlStyle = MPMovieControlStyleFullscreen;
        
        
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
