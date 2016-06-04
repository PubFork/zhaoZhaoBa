//
//  XYCommunityNetTool.h
//  zhaoZhaoBa
//
//  Created by apple on 16/6/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYNetTool.h"
NS_ASSUME_NONNULL_BEGIN


@interface XYCommunityNetTool : NSObject

/**
 *  获取社区汇  列表
 *
 *  @param page           页数
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)getCommunityListWithPage:(NSInteger)page
                       isRefresh:(BOOL)isRefresh
                  viewController:(XYRootViewController *)viewController
                         success:(nullable void (^)(NSArray * array))success
                         failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;


/**
 *  社区汇  详情
 *
 *  @param ID             ID
 *  @param page           页数
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)getCommunityDetailWithID:(NSNumber *)ID
                            page:(NSInteger)page
                       isRefresh:(BOOL)isRefresh
                  viewController:(XYRootViewController *)viewController
                         success:(nullable void (^)(NSArray * array))success
                         failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;



@end
NS_ASSUME_NONNULL_END