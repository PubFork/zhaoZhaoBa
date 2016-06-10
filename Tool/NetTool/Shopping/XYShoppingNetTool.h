//
//  XYShoppingNetTool.h
//  zhaoZhaoBa
//
//  Created by apple on 16/6/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYNetTool.h"
NS_ASSUME_NONNULL_BEGIN
@interface XYShoppingNetTool : NSObject

/**
 *  积分商城  列表
 *
 *  @param page           页数
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)getShoppingListWithPage:(NSInteger)page
                      isRefresh:(BOOL)isRefresh
                 viewController:(XYRootViewController *)viewController
                        success:(nullable void (^)(NSArray * array))success
                        failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;


@end
NS_ASSUME_NONNULL_END