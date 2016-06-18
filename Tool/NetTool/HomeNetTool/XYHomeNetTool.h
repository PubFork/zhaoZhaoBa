//
//  XYHomeNetTool.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYNetTool.h"
#import "XYDriverSchoolNetTool.h"

NS_ASSUME_NONNULL_BEGIN

//////////////////////////////////轮播图 类型////////////////////////////////////////

/**
 *  首页
 */
static NSString * CarousePictureBannerType_home = @"1";
/**
 *  首页小
 */
static NSString * CarousePictureBannerType_home_small = @"2";
/**
 *  商店
 */
static NSString * CarousePictureBannerType_shop = @"5";


@interface XYHomeNetTool : NSObject

/**
 *  获取轮播图
 *
 *  @param type           轮播图类型  1首页轮播，2首页轮播图小，5商城轮播图
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 *
 */
+ (void)getCarousePictureWithBannerType:(NSString *)type
                              isRefresh:(BOOL)isRefresh
                         viewController:(XYRootViewController *)viewController
                                success:(nullable void (^)(NSArray * array))success
                                failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  获取城市列表
 *
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)getCityWithIsRefresh:(BOOL)isRefresh
              viewController:(XYRootViewController *)viewController
                     success:(nullable void (^)(NSArray * array))success
                     failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;


@end
NS_ASSUME_NONNULL_END