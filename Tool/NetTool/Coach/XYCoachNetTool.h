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





@end
NS_ASSUME_NONNULL_END