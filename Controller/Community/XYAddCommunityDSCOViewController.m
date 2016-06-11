//
//  XYAddCommunityDSCOViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/6/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYAddCommunityDSCOViewController.h"
#import "CWStarRateView.h"
#import "XYDriverSchoolNetTool.h"
#import "XYCoachNetTool.h"

@interface XYAddCommunityDSCOViewController () <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

////////////////////////////////// drvierSchool////////////////////////////////////////
@property (weak, nonatomic) IBOutlet UIImageView *drvierSchoolImageView;
@property (weak, nonatomic) IBOutlet UILabel *drvierSchoolNameLabel;
@property (weak, nonatomic) IBOutlet CWStarRateView *drvierSchoolStart;
@property (weak, nonatomic) IBOutlet CWStarRateView *drvierSchoolServerStart;
@property (weak, nonatomic) IBOutlet CWStarRateView *drvierSchoolEnvironmentStart;
@property (weak, nonatomic) IBOutlet CWStarRateView *environmentCarStart;
@property (weak, nonatomic) IBOutlet UITextView *driverSchoolCommunityTV;
@property (weak, nonatomic) IBOutlet UILabel *driverSchoolCommunityTVLabel;
@property (weak, nonatomic) IBOutlet UIButton *driverSchoolSubmitBtn;


////////////////////////////////// coach ////////////////////////////////////////

@property (weak, nonatomic) IBOutlet UIImageView *coachImageView;
@property (weak, nonatomic) IBOutlet UILabel *coachNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *coachDriverSchoolLabel;
@property (weak, nonatomic) IBOutlet UIButton *coachLikeBtn;
@property (weak, nonatomic) IBOutlet UIButton *coachUnlikeBtn;
@property (weak, nonatomic) IBOutlet UILabel *coachHistoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *coachPassLabel;
@property (weak, nonatomic) IBOutlet UIButton *coachPraiseBtn;
@property (weak, nonatomic) IBOutlet UIButton *coachUnpraiseBtn;
@property (weak, nonatomic) IBOutlet UIButton *coachPassBtn;
@property (weak, nonatomic) IBOutlet UIButton *coachUnpassBtn;
@property (weak, nonatomic) IBOutlet CWStarRateView *coachCommunityStart;
@property (weak, nonatomic) IBOutlet UITextView *coachCommunityTV;
@property (weak, nonatomic) IBOutlet UILabel *coachCommunityTVLabel;
@property (weak, nonatomic) IBOutlet UIButton *coachSubmitBtn;




@end

@implementation XYAddCommunityDSCOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.drvierSchoolStart.userInteractionEnabled = NO;
    
    
    self.drvierSchoolServerStart.scorePercent = 0;
    self.environmentCarStart.scorePercent = 0;
    self.drvierSchoolEnvironmentStart.scorePercent = 0;
    self.coachCommunityStart.scorePercent = 0;

    
}

- (IBAction)clickCoachPraiseBtn:(id)sender {
    self.coachPraiseBtn.backgroundColor = kDefaultBackgroudColor;
    self.coachUnpraiseBtn.backgroundColor = kWhiteColor;
}
- (IBAction)clickCoachUnpraiseBtn:(id)sender {
    self.coachPraiseBtn.backgroundColor = kWhiteColor;
    self.coachUnpraiseBtn.backgroundColor = kDefaultBackgroudColor;
}

- (IBAction)clickCoachPassBtn:(id)sender {
    [self aaa:YES];
}
- (IBAction)clickCoachUnpassBtn:(id)sender {
    [self aaa:NO];
}

- (void)aaa:(BOOL)b
{
    b=!b;
    [self.coachPassBtn setHighlighted:b];
    [self.coachUnpassBtn setHighlighted:!b];
}


- (IBAction)clickDriverSchoolSubmitBtn:(id)sender {
    
    if (!self.driverSchoolCommunityTV.text.length) {
        [kShowLabel setText:@"请填写对驾校的评价"];
        return;
    }
    
    if (!self.drvierSchoolServerStart.scorePercent) {
        [kShowLabel setText:@"请对驾校的服务进行打分"];
        return;
    }
    
    if (!self.drvierSchoolEnvironmentStart.scorePercent) {
        [kShowLabel setText:@"请对驾校的环境进行打分"];
        return;
    }
    
    if (!self.environmentCarStart.scorePercent) {
        [kShowLabel setText:@"请对驾校的车辆进行打分"];
        return;
    }
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"评价一旦提交无法更改，确认提交吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 101;
    [alert show];
    
}
- (IBAction)clickCoachSubmitBtn:(id)sender {
    
    if (!self.coachCommunityTV.text.length) {
        [kShowLabel setText:@"请填写对驾校的评价"];
        return;
    }
    
    if (!self.coachCommunityStart.scorePercent) {
        [kShowLabel setText:@"请对驾校的服务进行打分"];
        return;
    }
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"评价一旦提交无法更改，确认提交吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 102;
    [alert show];
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    WeakSelf(weakSelf);

    if (buttonIndex) {
        switch (alertView.tag) {
            case 101: {
                [XYDriverSchoolNetTool releaseDSCommunityWithContent:self.driverSchoolCommunityTV.text
                                                             servier:(int)(self.drvierSchoolServerStart.scorePercent*5)
                                                               envir:(int)(self.drvierSchoolEnvironmentStart.scorePercent*5)
                                                                 car:(int)(self.environmentCarStart.scorePercent*5)
                                                               files:@""
                                                             pd_dsid:self.driverSchoolID
                                                           isRefresh:YES
                                                      viewController:self
                                                             success:^(NSDictionary * _Nonnull dic) {
                                                                 [kShowLabel setText:@"评价成功"];
                                                                 weakSelf.driverSchoolCommunityTV.userInteractionEnabled = NO;
                                                                 weakSelf.drvierSchoolServerStart.userInteractionEnabled = NO;
                                                                 weakSelf.drvierSchoolEnvironmentStart.userInteractionEnabled = NO;
                                                                 weakSelf.environmentCarStart.userInteractionEnabled = NO;
                                                                 weakSelf.driverSchoolSubmitBtn.userInteractionEnabled = NO;

                                                             } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                                                                 
                                                             }];

                break;
            }
            case 102: {
                [XYCoachNetTool releaseDSCommunityWithContent:self.coachCommunityTV.text
                                                      pc_star:(int)(self.coachCommunityStart.scorePercent*5)
                                                      pc_like:1
                                                      pc_pass:1
                                                      pd_dsid:self.coachID
                                                    isRefresh:YES
                                               viewController:self
                                                      success:^(NSDictionary * _Nonnull dic) {
                                                          [kShowLabel setText:@"评价成功"];
                                                          weakSelf.coachCommunityTV.userInteractionEnabled = NO;
                                                          weakSelf.coachCommunityStart.userInteractionEnabled = NO;
                                                          weakSelf.coachPassBtn.userInteractionEnabled = NO;
                                                          weakSelf.coachUnpassBtn.userInteractionEnabled = NO;
                                                          weakSelf.coachPraiseBtn.userInteractionEnabled = NO;
                                                          weakSelf.coachUnpraiseBtn.userInteractionEnabled = NO;
                                                          weakSelf.coachSubmitBtn.userInteractionEnabled = NO;

                                                      } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                                                        
                                                      }];

                break;
            }
                
        }
    }
}

#pragma mark -------------------------------------------------------
#pragma mark TV Delegate
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView == self.coachCommunityTV) {
        self.coachCommunityTVLabel.hidden = textView.text.length;
    } else {
        self.driverSchoolCommunityTVLabel.hidden = textView.text.length;
    }
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
