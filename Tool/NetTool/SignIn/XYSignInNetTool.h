//
//  XYSignInNetTool.h
//  zhaoZhaoBa
//
//  Created by apple on 16/6/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYNetTool.h"
NS_ASSUME_NONNULL_BEGIN
@interface XYSignInNetTool : XYNetTool

/**
 *   验证码
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
                 failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;

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
                failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;




@end
NS_ASSUME_NONNULL_END
