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


//////////////////////////////////驾校列表类型////////////////////////////////////////

/**
 *  默认
 */
static NSString * DriverSchoolSortType_default = @"default";

/**
 *  推荐
 */
static NSString * DriverSchoolSortType_recommend = @"recommend";

/**
 *  价格
 */
static NSString * DriverSchoolSortType_price = @"price";

/**
 *  距离
 */
static NSString * DriverSchoolSortType_distance = @"distance";

/**
 *  报名人数
 */
static NSString * DriverSchoolSortType_signnumber = @"signnumber";




////////////////////////////////// 驾校 排序 ////////////////////////////////////////

/**
 *  驾校列表 升序
 */
static NSString * DrvierSchoolSortRule_asc = @"asc";

/**
 *  驾校列表 降序
 */
static NSString * DrvierSchoolSortRule_desc = @"desc";

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

@end
NS_ASSUME_NONNULL_END