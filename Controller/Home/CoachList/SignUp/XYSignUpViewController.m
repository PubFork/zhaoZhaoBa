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

@interface XYSignUpViewController () 
@property (nonatomic, strong)XYSignUpSelecCarTypeView * signUpSelectCarTypeView;

@property (weak, nonatomic) IBOutlet UITextField *nameTf;
@property (weak, nonatomic) IBOutlet UITextField *IDCardTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;


@end



@implementation XYSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitleLabelText:@"报名"];

    [self.signUpSelectCarTypeView addSignUpSelectCarTypeViewWithSuperView:self.view];
    
    [self requestData];
    
}

- (void)requestData
{
    WeakSelf(weakSelf);
    [XYSignUpNetTool getCareTypeWithIsRefresh:YES viewController:self success:^(NSArray * _Nonnull array) {
        weakSelf.signUpSelectCarTypeView.groupArray = array;
    } failure:nil];
}

- (IBAction)clickSelectCarType:(id)sender {
    [self.signUpSelectCarTypeView showView];
}

- (IBAction)clickSignUpBtn:(id)sender {
    
//    [XYSignUpNetTool signUpWithName:self.nameTf.text
//                             IDCard:self.IDCardTF.text
//                              phone:self.phoneTF.text
//                     driverSchoolID:<#(nonnull NSString *)#>
//                             userID:<#(nonnull NSString *)#>
//                            coachID:<#(nonnull NSString *)#>
//                            carType:<#(nonnull NSString *)#>
//                           sRefresh:YES
//                     viewController:self
//                            success:^{
//                                
//                            } failure:nil];
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
