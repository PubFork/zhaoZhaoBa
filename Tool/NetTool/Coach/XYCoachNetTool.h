//
//  XYCoachNetTool.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYNetTool.h"
NS_ASSUME_NONNULL_BEGIN
@interface XYCoachNetTool : NSObject


/**
 *  获取教练 列表
 *
 *  @param type           排序 类型
 *  @param drvierSchoolID           驾校ID
 *  @param sortRule       升序 还是 降序
 *  @param page           第几页
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)getCoachWithSortType:(NSString *)type
              drvierSchoolID:(NSNumber *)drvierSchoolID
                        rule:(NSString *)rule
                        page:(NSInteger)page
                   isRefresh:(BOOL)isRefresh
              viewController:(XYRootViewController *)viewController
                     success:(nullable void (^)(NSArray * array))success
                     failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;


/**
 *  获取 教练详情
 *
 *  @param coachID        教练ID
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)getCoachDetailWithID:(NSNumber *)coachID
                   isRefresh:(BOOL)isRefresh
              viewController:(XYRootViewController *)viewController
                     success:(nullable void (^)(NSDictionary * dic))success
                     failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;


/**
 *  获取教练 评论列表
 *
 *  @param coachID        教练ID
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)getCoachCommentWithID:(NSNumber *)coachID
                         page:(NSInteger)page
                    isRefresh:(BOOL)isRefresh
               viewController:(XYRootViewController *)viewController
                      success:(nullable void (^)(NSArray * array))success
                      failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  教练 评论 详情
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
 *  @param pc_star        星际 1-5
 *  @param pc_like        顶是1, 踩是-1
 *  @param pc_pass        通过是1, 没有是-1
 *  @param pd_dsid        教练ID
 *  @param isRefresh      是否 刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)releaseDSCommunityWithContent:(NSString *)content
                              pc_star:(NSInteger)pc_star
                              pc_like:(NSInteger)pc_like
                              pc_pass:(NSInteger)pc_pass
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
+ (void)repleCOCommunityWithContent:(NSString *)content
                        communityID:(id)communityID
                        repleUserID:(id)repleUserID
                          isRefresh:(BOOL)isRefresh
                     viewController:(XYRootViewController *)viewController
                            success:(nullable void (^)(NSDictionary * dic))success
                            failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;


@end
NS_ASSUME_NONNULL_END