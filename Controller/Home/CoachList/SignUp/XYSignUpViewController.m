//
//  XYSignUpViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYSignUpViewController.h"
#import "XYSignUpSelecCarTypeView.h"
#import "XYSignUpNetTool.h"

#import "XYCarousePicture.h"
#import "XYWebViewViewController.h"
#import "XYCoachViewController.h"


@interface XYSignUpViewController () 
@property (nonatomic, strong)XYSignUpSelecCarTypeView * signUpSelectCarTypeView;
@property (weak, nonatomic) IBOutlet XYCarousePicture *carouseView;
@property (weak, nonatomic) IBOutlet UIButton *imgBtn1;
@property (weak, nonatomic) IBOutlet UIButton *imgBtn2;

@property (weak, nonatomic) IBOutlet UITextField *nameTf;
@property (weak, nonatomic) IBOutlet UITextField *IDCardTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;

@property (weak, nonatomic) IBOutlet UILabel *coachLabel;
@property (weak, nonatomic) IBOutlet UILabel *carTypeLabel;

@property (nonatomic, copy)NSString * carTypeID;


@property (nonatomic, copy)NSString * img_link_1;
@property (nonatomic, copy)NSString * img_link_2;



@property (nonatomic, strong)NSDictionary * coachDic;

@end



@implementation XYSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitleLabelText:@"报名"];

    [self.signUpSelectCarTypeView addSignUpSelectCarTypeViewWithSuperView:self.view];
    WeakSelf(weakSelf);
    [self.signUpSelectCarTypeView getSelectCarTypeWithBlock:^(NSDictionary *carType) {
        weakSelf.carTypeID = carType[sign_up_ct_id];
        weakSelf.carTypeLabel.text = carType[sign_up_ct_title];
    }];
    
    [self requestData];
    
    
    [self.carouseView carousePictureClickPictureWithBlock:^(NSString *url) {
        XYWebViewViewController * wb = [[XYWebViewViewController alloc] init];
        wb.url = url;
        [self.navigationController pushViewController:wb animated:YES];
    }];
    
}

- (void)requestData
{
    WeakSelf(weakSelf);
    [XYSignUpNetTool getCareTypeWithIsRefresh:NO driverSchoolID:self.driverSchoolID viewController:self success:^(NSArray * _Nonnull array) {
        weakSelf.signUpSelectCarTypeView.groupArray = array;
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
    
    
    
    [XYSignUpNetTool getImageIsRefresh:NO viewController:self success:^(NSDictionary * _Nonnull dic) {
        
        NSArray * array = dic[@"topbanner"];
        weakSelf.carouseView.groupArray = array;
        
        array = dic[@"nextbanner"];

        NSDictionary * img1 = array.firstObject;
        NSDictionary * img2 = array.count > 1 ? array[1] : nil;
        
        [weakSelf.imgBtn1 setImageWithURL:[NSURL URLWithString:img1[carousePicture_imageUrl]] forState:UIControlStateNormal placeholder:kDefaultImage];
        weakSelf.img_link_1 = img1[carousePicture_link];
        
        if (img2) {
            [weakSelf.imgBtn2 setImageWithURL:[NSURL URLWithString:img2[carousePicture_imageUrl]] forState:UIControlStateNormal placeholder:kDefaultImage];
            weakSelf.img_link_2 = img1[carousePicture_link];
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
}

- (IBAction)clickSelectCarType:(id)sender {
    [self.signUpSelectCarTypeView showView];
}

- (IBAction)clickSignUpBtn:(id)sender {
    
    if (self.nameTf.text.length <= 1) {
        [kShowLabel setText:@"请填写姓名"];
        return;
    }
    
    if ([kManager valiMobile:self.phoneTF.text]) {
        [kShowLabel setText:[kManager valiMobile:self.phoneTF.text]];
        return;
    }
    
    if ([kManager idCardWithID:self.IDCardTF.text]) {
        [kShowLabel setText:[kManager idCardWithID:self.IDCardTF.text]];
        return;
    }
    
    if (!self.coachDic) {
        [kShowLabel setText:@"请选择教练"];
        return;
    }
    
    if (!self.carTypeID) {
        [kShowLabel setText:@"请选择车型"];
        return;
    }
    
    
    WeakSelf(weakSelf);
    [XYSignUpNetTool signUpWithName:self.nameTf.text IDCard:self.IDCardTF.text phone:self.phoneTF.text driverSchoolID:self.driverSchoolID userID:@"0" coachID:self.coachDic[coach_c_id] carType:self.carTypeID su_payselect:self.su_payselect isRefresh:YES viewController:self success:^{
        
        [kShowLabel setText:@"报名成功"];
        
    } failure:nil];
    
   
}


- (IBAction)clickBtn1:(id)sender {
    XYWebViewViewController * wb = [[XYWebViewViewController alloc] init];
    wb.url = self.img_link_1;
    [self.navigationController pushViewController:wb animated:YES];
}


- (IBAction)clickBtn2:(id)sender {
    XYWebViewViewController * wb = [[XYWebViewViewController alloc] init];
    wb.url = self.img_link_2;
    [self.navigationController pushViewController:wb animated:YES];
}

- (IBAction)clickCoachBtn:(id)sender {
    
    XYCoachViewController * coachVC = [[XYCoachViewController alloc] init];
    coachVC.isSelect = YES;
    coachVC.drvierSchoolID = self.driverSchoolID;
    [self.navigationController pushViewController:coachVC animated:YES];
    
    WeakSelf(weakSelf);
    [coachVC selectCoachWithBlock:^(NSDictionary *coachDic) {
        weakSelf.coachLabel.text = coachDic[coach_c_name];
        weakSelf.coachDic = coachDic;
    }];
}
#pragma mark -------------------------------------------------------
#pragma mark Lazy Loading

- (XYSignUpSelecCarTypeView *)signUpSelectCarTypeView
{
    if (!_signUpSelectCarTypeView) {
        _signUpSelectCarTypeView = [[XYSignUpSelecCarTypeView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 30 + 44 * 3 + 30)];
    }
    return _signUpSelectCarTypeView;
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
