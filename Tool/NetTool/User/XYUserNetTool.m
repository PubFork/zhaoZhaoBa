//
//  XYUserNetTool.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYUserNetTool.h"

@implementation XYUserNetTool
/**
 *  注册 或者 登陆
 *
 *  @param phone          电话号码
 *  @param code           验证码
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)logingOrRegistWithPhone:(NSString *)phone
                           code:(NSString *)code
                      isRefresh:(BOOL)isRefresh
                 viewController:(XYRootViewController *)viewController
                        success:(nullable void (^)(NSDictionary * dic))success
                        failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:@"%@%@",root_URL,@"DrivingSchool/api/usersignup.htm"];
    
    NSDictionary * parmeters = @{@"au_phone":phone,
                                 @"authcode":code};
    
    [XYNetTool postWithUrl:url
                parameters:parmeters
                 isRefresh:isRefresh
            viewController:viewController
                   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                       NSLog(@"Carouse Picture -> msg = %@ \n type = %@",responseObject[@"msg"],responseObject);
                       NSDictionary * dic = responseObject[@"data"];
                       success ? success(dic) : 0;
                   }   failure:failure];

}



/**
 *  发送验证码
 *
 *  @param phone          手机号
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
    
    [XYNetTool postWithUrl:url
                parameters:parmeters
                 isRefresh:isRefresh
            viewController:viewController
                   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                       success ? success() : 0;
                   }   failure:failure];
    

}


/**
 *  上传用户数据
 *
 *  @param token          token
 *  @param files          头像
 *  @param au_name        姓名
 *  @param au_sex         性别
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)updateUserInfoWithToken:(id)token
                          files:(id)files
                        au_name:(id)au_name
                         au_sex:(id)au_sex
                         au_age:(id)au_age
                      isRefresh:(BOOL)isRefresh
                 viewController:(XYRootViewController *)viewController
                        success:(nullable void (^)(NSDictionary * dic))success
                        failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:@"%@%@",root_URL,@"DrivingSchool/api/updateappuser.htm"];
    
    NSMutableDictionary * parmeters = @{@"token":token}.mutableCopy;
    
    files   ? parmeters[@"files"]   = files    : 0;
    au_name ? parmeters[@"au_name"] = au_name  : 0;
    au_sex  ? parmeters[@"au_sex"]  = au_sex   : 0;
    au_age  ? parmeters[@"au_age"]  = au_age   : 0;
    
    
    [XYNetTool postWithUrl:url
                parameters:parmeters
                 isRefresh:isRefresh
            viewController:viewController
                   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                       success ? success(responseObject[@"data"]) : 0;
                   }   failure:failure];
}


@end
