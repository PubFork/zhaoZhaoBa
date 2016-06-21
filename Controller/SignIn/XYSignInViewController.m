//
//  XYSignInViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/6/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYSignInViewController.h"
#import "XYSignInNetTool.h"

@interface XYSignInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UIButton *sendCodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *invitationCodeTF;

@property (weak, nonatomic) IBOutlet UIButton *signInBtn;
@property (nonatomic, strong)NSTimer * countdownTimer;



@property (nonatomic, assign)NSInteger timeNumber;
@end

@implementation XYSignInViewController
+ (XYSignInViewController *)shareSignInViewController
{
    static XYSignInViewController * signVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        signVC = [[XYSignInViewController alloc] init];
    });
    return signVC;
}


+ (void)showSignViewControllerWithViewController:(UIViewController *)vc
{
    [vc presentViewController:[XYSignInViewController shareSignInViewController] animated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitleLabelText:@"手机号快捷登录"];
    
    self.sendCodeBtn.layer.borderColor = kNavigationBarTextColor.CGColor;
    self.sendCodeBtn.layer.borderWidth = 1;
    
    self.signInBtn.layer.cornerRadius = 5;
    self.signInBtn.layer.masksToBounds = YES;
}


/**
 *  倒计时
 *
 *  @param timer <#timer description#>
 */
- (void)changeTimer:(NSTimer *)timer
{
    self.timeNumber --;
    if (self.timeNumber == 0) {
        
        
        self.sendCodeBtn.layer.borderColor = kNavigationBarTextColor.CGColor;
        [self.sendCodeBtn setTitleColor:kNavigationBarTextColor forState:UIControlStateNormal];

        self.sendCodeBtn.enabled = YES;
        [self.countdownTimer invalidate];
        [self.sendCodeBtn setTitle:[NSString stringWithFormat:@"发送验证码"] forState:UIControlStateNormal];
        
        return;
    }
    [self.sendCodeBtn setTitle:[NSString stringWithFormat:@"重新发送(%ld)",(long)self.timeNumber] forState:UIControlStateNormal];
}

#pragma mark -------------------------------------------------------
#pragma mark Click

- (void)clickLeftBtn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickSendCodeBtn:(id)sender {
    [self.view endEditing:YES];
    if ([kManager valiMobile:self.phoneTF.text]) {
        [kShowLabel setText:[kManager valiMobile:self.phoneTF.text]];
        return;
    }
    
    WeakSelf(weakSelf);
    [XYSignInNetTool getCodeWithPhone:self.phoneTF.text isRefresh:YES viewController:self success:^{
        
        [weakSelf.sendCodeBtn setTitle:@"重新发送(60)" forState:UIControlStateNormal];
        weakSelf.sendCodeBtn.enabled = NO;
        weakSelf.sendCodeBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [weakSelf.sendCodeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        
        self.timeNumber = 60;
        self.countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeTimer:) userInfo:nil repeats:YES];
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
}



- (IBAction)clickSignInBtn:(id)sender {
    [self.view endEditing:YES];

    if ([kManager valiMobile:self.phoneTF.text]) {
        [kShowLabel setText:[kManager valiMobile:self.phoneTF.text]];
        return;
    }
    
    if (self.codeTF.text.length <= 0) {
        [kShowLabel setText:@"请输入验证码"];
        return;
    }
    
    WeakSelf(weakSelf);
    [XYSignInNetTool signInWithPhone:self.phoneTF.text code:self.codeTF.text invitation:self.invitationCodeTF.text isRefresh:YES viewController:self success:^(NSDictionary * _Nonnull dic) {
        [kUserD setValue:dic forKey:user_info_key];
        [kUserD synchronize];
        [weakSelf clickRightBtn];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
    
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
