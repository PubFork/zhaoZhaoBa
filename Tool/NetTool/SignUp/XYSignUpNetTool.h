//
//  XYSignUpNetTool.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYNetTool.h"


/**
 *  姓名
 */
static NSString * _Nonnull  sign_up_su_name = @"su_name";
/**
 *  身份证
 */
static NSString * _Nonnull sign_up_su_idNumber = @"su_idNumber";
/**
 *  手机
 */
static NSString * _Nonnull sign_up_su_phone = @"su_phone";

/**
 *  支付方式
 */
static NSString * _Nonnull sign_up_su_payselect = @"su_payselect";

/**
 *  驾校id
 */
static NSString * _Nonnull sign_up_su_dsid = @"su_dsid";

/**
 * 用户ID
 */
static NSString * _Nonnull sign_up_su_uid = @"token";


/**
 * 教练ID
 */
static NSString * _Nonnull sign_up_su_coach = @"cid";

/**
 * 车型ID
 */
static NSString * _Nonnull sign_up_su_carType = @"ctid";



NS_ASSUME_NONNULL_BEGIN
@interface XYSignUpNetTool : NSObject


/**
 *  获取 车型
 *
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)getCareTypeWithIsRefresh:(BOOL)isRefresh
                  driverSchoolID:(id)driverSchoolID
                  viewController:(XYRootViewController *)viewController
                         success:(nullable void (^)(NSArray * array))success
                         failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  报名
 *
 *  @param name           姓名
 *  @param IDCard         身份证
 *  @param phone          手机
 *  @param driverSchoolID 驾校id
 *  @param userID         用户id
 *  @param coachID        教练id
 *  @param carType        车型
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)signUpWithName:(NSString *)name
                IDCard:(NSString *)IDCard
                 phone:(NSString *)phone
        driverSchoolID:(NSString *)driverSchoolID
                userID:(NSString *)userID
               coachID:(NSString *)coachID
               carType:(NSString *)carType
          su_payselect:(NSInteger)su_payselect
             isRefresh:(BOOL)isRefresh
        viewController:(XYRootViewController *)viewController
               success:(nullable void (^)())success
               failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;



/**
 *  获取图片
 */
+ (void)getImageIsRefresh:(BOOL)isRefresh
           viewController:(XYRootViewController *)viewController
                  success:(nullable void (^)(NSDictionary * dic))success
                  failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;




@end
NS_ASSUME_NONNULL_END