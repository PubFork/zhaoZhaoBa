//
//  XYSignUpNetTool.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYSignUpNetTool.h"

@implementation XYSignUpNetTool


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
                         failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:@"%@%@",root_URL,@"DrivingSchool/api/cartypelist.htm"];
    
    
    
    [XYNetTool postWithUrl:url
                parameters:@{@"dsid":driverSchoolID}
                 isRefresh:isRefresh
            viewController:viewController
                   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                       NSLog(@"Carouse Picture -> msg = %@ \n type = %@",responseObject[@"msg"],responseObject);
                       NSArray * array = responseObject[@"data"];
                       success ? success(array) : 0;
                   }   failure:failure];

}

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
               failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:@"%@%@",root_URL,@"DrivingSchool/api/submitentry.htm"];
    
    NSDictionary * parmeters = @{sign_up_su_name    :name,
                                 sign_up_su_idNumber:IDCard,
                                 sign_up_su_phone   :phone,
                                 sign_up_su_dsid    :driverSchoolID,
                                 sign_up_su_uid     :userID,
                                 sign_up_su_coach   :coachID,
                                 sign_up_su_carType :carType,
                                 sign_up_su_payselect: @(su_payselect)};
    
    [XYNetTool postWithUrl:url
                parameters:parmeters
                 isRefresh:isRefresh
            viewController:viewController
                   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                       NSLog(@"Carouse Picture -> msg = %@ \n type = %@",responseObject[@"msg"],responseObject);
                       success ? success() : 0;
                   }   failure:failure];
    

}

/**
 *  获取图片
 */
+ (void)getImageIsRefresh:(BOOL)isRefresh
           viewController:(XYRootViewController *)viewController
                  success:(nullable void (^)(NSDictionary * dic))success
                  failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:@"%@%@",root_URL,@"DrivingSchool/api/signuppagead.htm"];
    
    
    
    [XYNetTool postWithUrl:url
                parameters:nil
                 isRefresh:isRefresh
            viewController:viewController
                   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                       NSLog(@"Carouse Picture -> msg = %@ \n type = %@",responseObject[@"msg"],responseObject);
                       success ? success(responseObject[@"data"]) : 0;
                   }   failure:failure];
}
@end
