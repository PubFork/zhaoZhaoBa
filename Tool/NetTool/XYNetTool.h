//
//  XYNetTool.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"
#import "XYRootViewController.h"

NS_ASSUME_NONNULL_BEGIN
@interface XYNetTool : NSObject

+ (nullable AFHTTPSessionManager *)getDefaultManager;

#pragma mark -------------------------------------------------------
#pragma mark Base Request
/**
 *  基础 GET 请求
 *
 *  @param URLString  url
 *  @param parameters 数据
 *  @param success    成功
 *  @param failure    失败
 *
 *  @return task
 */
+ (nullable NSURLSessionDataTask *)GET:(NSString *)URLString
                            parameters:(nullable id)parameters
                               success:(nullable void (^)(NSURLSessionDataTask *task, id responseObject))success
                               failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  基础 POST 请求
 *
 *  @param URLString  url
 *  @param parameters 数据
 *  @param success    成功
 *  @param failure    失败
 *
 *  @return task
 */
+ (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
                             parameters:(id)parameters
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


#pragma mark -------------------------------------------------------
#pragma mark Super Request

- (nullable NSURLSessionDataTask *)getWithUrl:(NSString *)URLString
                                   parameters:(nullable id)parameters
                                    isRefresh:(BOOL)isRefresh
                               viewController:(XYRootViewController *)viewController
                                      success:(nullable void (^)(NSURLSessionDataTask *task, id responseObject))success
                                      failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;


- (nullable NSURLSessionDataTask *)postWithUrl:(NSString *)URLString
                                    parameters:(nullable id)parameters
                                    isRefresh:(BOOL)isRefresh
                                viewController:(XYRootViewController *)viewController
                                    success:(nullable void (^)(NSURLSessionDataTask *task, id responseObject))success
                                    failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
NS_ASSUME_NONNULL_END