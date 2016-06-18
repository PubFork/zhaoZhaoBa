//
//  XYSignUpViewController.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYRootViewController.h"

@interface XYSignUpViewController : XYRootViewController
@property (nonatomic, strong)id driverSchoolID;


//支付方式: 1学时支付,2全额支付
@property (nonatomic, assign)NSInteger su_payselect;
@end
