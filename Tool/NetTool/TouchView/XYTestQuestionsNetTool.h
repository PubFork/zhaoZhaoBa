//
//  XYTestQuestionsNetTool.h
//  zhaoZhaoBa
//
//  Created by apple on 16/6/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYNetTool.h"
NS_ASSUME_NONNULL_BEGIN
@interface XYTestQuestionsNetTool : XYNetTool


/**
 *  获取试题页面
 *
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)getTestQuestionsIsRefresh:(BOOL)isRefresh
                   viewController:(XYRootViewController *)viewController
                          success:(nullable void (^)(NSDictionary * dic))success
                          failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;




/**
 *  获取视频
 *
 *  @param page           页数
 *  @param type           2表示科目2, 3表示科目3
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)getVideoWithPage:(NSInteger)page
                    type:(NSInteger)type
               isRefresh:(BOOL)isRefresh
          viewController:(XYRootViewController *)viewController
                 success:(nullable void (^)(NSArray * array))success
                 failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;


@end
NS_ASSUME_NONNULL_END