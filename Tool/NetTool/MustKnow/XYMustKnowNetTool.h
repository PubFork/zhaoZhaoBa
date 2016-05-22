//
//  XYMustKnowNetTool.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYNetTool.h"

NS_ASSUME_NONNULL_BEGIN
@interface XYMustKnowNetTool : NSObject

/**
 *  必知晓
 *
 *  @param page           页数
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)getMustKnowWithPage:(NSInteger)page
                  isRefresh:(BOOL)isRefresh
             viewController:(XYRootViewController *)viewController
                    success:(nullable void (^)(NSArray * array))success
                    failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  必知晓 详情
 *
 *  @param ID           ID
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)getMustKnowDetailWithID:(NSInteger)ID
                      isRefresh:(BOOL)isRefresh
                 viewController:(XYRootViewController *)viewController
                        success:(nullable void (^)(NSDictionary * dic))success
                        failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
NS_ASSUME_NONNULL_END