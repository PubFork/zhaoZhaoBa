//
//  XYCommunityNetTool.h
//  zhaoZhaoBa
//
//  Created by apple on 16/6/4.
//  Copyright © 2016年 apple. All rights reserved.
//

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
                         success:(nullable void (^)(NSDictionary * dic))success
                         failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;


/**
 *  发布社区汇
 *
 *  @param content        内容
 *  @param files          图片
 *  @param isRefresh      是否 刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)releaseCommunityWithContent:(NSString *)content
                              files:(id)files
                          isRefresh:(BOOL)isRefresh
                     viewController:(XYRootViewController *)viewController
                            success:(nullable void (^)(NSDictionary * dic))success
                            failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;


/**
 *  发布回复
 *
 *  @param content        内容
 *  @param communityID          评论ID
 *  @param repleUserID          被回复人的ID
 *  @param isRefresh      是否 刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)repleCommunityWithContent:(NSString *)content
                      communityID:(id)communityID
                      repleUserID:(id)repleUserID
                        isRefresh:(BOOL)isRefresh
                   viewController:(XYRootViewController *)viewController
                          success:(nullable void (^)(NSDictionary * dic))success
                          failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;


/**
 *  点赞 / 取消赞
 *
 type  0 => 社区汇 , 1 => 驾校  , 2 => 教练
 *  @param isRefresh      是否 刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)praiseDSCommunityWithID:(id)ID
                           type:(CommunityStyle)type
                      isRefresh:(BOOL)isRefresh
                 viewController:(XYRootViewController *)viewController
                        success:(nullable void (^)(NSDictionary * dic))success
                        failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;





@end
NS_ASSUME_NONNULL_END