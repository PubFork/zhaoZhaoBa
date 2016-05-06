//
//  XYNetTool.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYNetTool.h"

@implementation XYNetTool

+ (AFHTTPSessionManager *)getDefaultManager
{
    AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc] init];
    return manager;
}


#pragma mark -------------------------------------------------------
#pragma mark Base Request

+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nonnull))success
                      failure:(void (^)(NSURLSessionDataTask * _Nonnull, NSError * _Nonnull))failure
{
   return [[self.class getDefaultManager] GET:URLString parameters:parameters success:success failure:failure];
}


+ (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
                             parameters:(id)parameters
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
{
    return [[self.class getDefaultManager] POST:URLString parameters:parameters success:success failure:failure];
}


#pragma mark -------------------------------------------------------
#pragma mark Super Request

- (nullable NSURLSessionDataTask *)getWithUrl:(NSString *)URLString
                                   parameters:(nullable id)parameters
                                    isRefresh:(BOOL)isRefresh
                               viewController:(XYRootViewController *)viewController
                                      success:(nullable void (^)(NSURLSessionDataTask *task, id responseObject))success
                                      failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    if (isRefresh) {
        [viewController addActiveIVToMySelfView];
    }
    
    return [self.class GET:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [viewController removeActiveIVFromSelfView];
        
        success ? success(task, responseObject) : 0;
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [viewController removeActiveIVFromSelfView];
        [kShowLabel setText:@"网络未连接" position:1];
        
        failure ? failure(task, error) : 0;
    }];
}



- (nullable NSURLSessionDataTask *)postWithUrl:(NSString *)URLString
                                    parameters:(nullable id)parameters
                                     isRefresh:(BOOL)isRefresh
                                viewController:(XYRootViewController *)viewController
                                       success:(nullable void (^)(NSURLSessionDataTask *task, id responseObject))success
                                       failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    if (isRefresh) {
        [viewController addActiveIVToMySelfView];
    }
    
    return [self.class POST:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [viewController removeActiveIVFromSelfView];
        
        success ? success(task, responseObject) : 0;
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [viewController removeActiveIVFromSelfView];
        [kShowLabel setText:@"网络未连接" position:1];
        
        failure ? failure(task, error) : 0;
    }];
}

@end
