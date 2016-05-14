//
//  XYSignUpViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYSignUpViewController.h"
#import "XYSignUpSelecCarTypeView.h"

@interface XYSignUpViewController () 
@property (nonatomic, strong)NSMutableArray * groupArray;
@property (nonatomic, strong)XYSignUpSelecCarTypeView * signUpSelectCarTypeView;
@end



@implementation XYSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitleLabelText:@"报名"];

    [self.signUpSelectCarTypeView addSignUpSelectCarTypeViewWithSuperView:self.view];
    
    self.groupArray = @[@"C1 (手动挡小车)", @"C2 (自动挡小车)",@"B2 (大型货车)"].mutableCopy;
    self.signUpSelectCarTypeView.groupArray = self.groupArray;
    
}

- (IBAction)clickSelectCarType:(id)sender {
    [self.signUpSelectCarTypeView showView];
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
