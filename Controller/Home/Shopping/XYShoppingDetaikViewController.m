//
//  XYShoppingDetaikViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/6/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYShoppingDetaikViewController.h"
#import "XYShoppingNetTool.h"
#import "XYAddActionView.h"

@interface XYShoppingDetaikViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel1;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *briefLabel;



@property (weak, nonatomic) IBOutlet XYAddActionView *backGroudView;
@property (weak, nonatomic) IBOutlet UIView *userInfoView;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;

@property (nonatomic, strong)NSDictionary * myData;
@end

@implementation XYShoppingDetaikViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitleLabelText:@"商品详情"];
    
    [self requestData];
    self.buyBtn.layer.cornerRadius = 5;
    self.buyBtn.layer.masksToBounds = YES;
    
    WeakSelf(weakSelf);
    [self.backGroudView clickView:^(UIView *view) {
        weakSelf.userInfoView.hidden = YES;
        view.hidden = YES;
    }];
}

- (void)requestData
{
    WeakSelf(weakSelf);
    
    [XYShoppingNetTool getShoppingDetailWithMallid:self.shoppingID isRefresh:YES viewController:self success:^(NSDictionary * _Nonnull dic) {
        
        [weakSelf layoutSubViewsWithDic:dic];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
}

- (void)layoutSubViewsWithDic:(NSDictionary *)dic
{
    self.myData = dic;
    
    [self.imageView setImageWithURL:[NSURL URLWithString:dic[shopping_sm_img]] placeholder:kDefaultImage];
    self.priceLabel.text = [kManager getStringWithObj:dic[shopping_sm_price]];
    self.detailLabel.text = dic[shopping_sm_describe];
    self.briefLabel.text = dic[shopping_sm_brief];
    self.titleLabel1.text = dic[shopping_sm_title];
}

- (IBAction)clickBuy:(id)sender {
    
    self.userInfoView.hidden = NO;
    self.backGroudView.hidden = NO;
}
- (IBAction)clickCancleBtn:(id)sender {
    self.userInfoView.hidden = YES;
    self.backGroudView.hidden = YES;
}
- (IBAction)clickSureBtn:(id)sender {
    
    if (!self.nameTF.text.length) {
        [kShowLabel setText:@"姓名不能为空"];
        return;
    }
    
    if (!self.addressTF.text.length) {
        [kShowLabel setText:@"地址不能为空"];
        return;
    }
    
    if ([kManager valiMobile:self.phoneTF.text]) {
        [kShowLabel setText:[kManager valiMobile:self.phoneTF.text]];
        return;
    }
    
    WeakSelf(weakSelf);
    
    
    [XYShoppingNetTool getBuyShoppingWithMallid:self.myData[shopping_sm_id]
                                          token:@(0)
                                     om_address:self.addressTF.text
                                       om_uname:self.nameTF.text
                                       om_phone:self.phoneTF.text
                                      isRefresh:YES
                                 viewController:self
                                        success:^(NSDictionary * _Nonnull dic) {
                                            [kShowLabel setText:@"兑换成功"];
                                            [weakSelf clickCancleBtn:nil];
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
