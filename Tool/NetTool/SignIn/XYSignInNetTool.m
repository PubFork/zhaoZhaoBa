//
//  XYSignInNetTool.m
//  zhaoZhaoBa
//
//  Created by apple on 16/6/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYSignInNetTool.h"

@implementation XYSignInNetTool
/**
 *  验证码
 *
 *  @param phone          phone
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)getCodeWithPhone:(NSString *)phone
               isRefresh:(BOOL)isRefresh
          viewController:(XYRootViewController *)viewController
                 success:(nullable void (^)())success
                 failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:@"%@%@",root_URL,@"DrivingSchool/api/getauthcode.htm"];
    
    NSDictionary * parmeters = @{@"au_phone":phone};

    [XYNetTool postWithUrl:url parameters:parmeters isRefresh:isRefresh viewController:viewController success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success ? success() : 0;
    } failure:failure];
}


/**
 *  登陆
 *  @param phone            电话
 *  @param code             验证码
 *  @param invitation        邀请码
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)signInWithPhone:(NSString *)phone
                   code:(NSString *)code
             invitation:(NSString *)invitation
              isRefresh:(BOOL)isRefresh
         viewController:(XYRootViewController *)viewController
                success:(nullable void (^)(NSDictionary * dic))success
                failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:@"%@%@",root_URL,@"DrivingSchool/api/usersignup.htm"];
    
    NSMutableDictionary * parmeters = @{@"au_phone":phone,
                                        @"authcode":code}.mutableCopy;
    invitation ? parmeters[@"au_code"] = invitation : 0;
    
    [XYNetTool postWithUrl:url parameters:parmeters isRefresh:isRefresh viewController:viewController success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if ([responseObject[@"ret"] integerValue] == 0 || [responseObject[@"ret"] integerValue] == 1) {
            success ? success(responseObject[@"data"]) : 0;
        }
        success ? success(responseObject[@"data"]) : 0;
    } failure:failure];
}

@end
