//
//  XYDriverSchoolNetTool.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYNetTool.h"
NS_ASSUME_NONNULL_BEGIN



@interface XYDriverSchoolNetTool : NSObject



/**
 *  获取驾校 列表
 *
 *  @param type           排序 类型
 *  @param sortRule       升序 还是 降序
 *  @param page           第几页
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)getDriverSchoolWithSortType:(NSString *)type
                         isSortRule:(NSString *)sortRule
                               page:(NSInteger)page
                          isRefresh:(BOOL)isRefresh
                     viewController:(XYRootViewController *)viewController
                            success:(nullable void (^)(NSArray * array))success
                            failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;


/**
 *  驾校详情
 *
 *  @param ID             驾校ID
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)getDriverSchoolDetailWithID:(NSInteger)ID
                          isRefresh:(BOOL)isRefresh
                     viewController:(XYRootViewController *)viewController
                            success:(nullable void (^)(NSDictionary * dic))success
                            failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  驾校详情 评论  列表
 *
 *  @param page           页数
 *  @param dsid           驾校ID
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)getDSCommunityListWithPage:(NSInteger)page
                         isRefresh:(BOOL)isRefresh
                              dsid:(id)dsid
                    viewController:(XYRootViewController *)viewController
                           success:(nullable void (^)(NSArray * array))success
                            failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;


/**
 *  驾校详情 评论 详情
 *
 *  @param ID             ID
 *  @param page           页数
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)getDSCommunityDetailWithID:(NSNumber *)ID
                              page:(NSInteger)page
                         isRefresh:(BOOL)isRefresh
                    viewController:(XYRootViewController *)viewController
                           success:(nullable void (^)(NSDictionary * dic))success
                           failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;


/**
 *  发布评论
 *
 *  @param content        内容
 *  @param files          图片
 *  @param pd_dsid        驾校ID
 *  @param isRefresh      是否 刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)releaseDSCommunityWithContent:(NSString *)content
                                files:(id)files
                              pd_dsid:(id)pd_dsid
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
+ (void)repleDSCommunityWithContent:(NSString *)content
                        communityID:(id)communityID
                        repleUserID:(id)repleUserID
                          isRefresh:(BOOL)isRefresh
                     viewController:(XYRootViewController *)viewController
                            success:(nullable void (^)(NSDictionary * dic))success
                            failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;



@end
NS_ASSUME_NONNULL_END