//
//  XYShoppingNetTool.m
//  zhaoZhaoBa
//
//  Created by apple on 16/6/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYShoppingNetTool.h"

@implementation XYShoppingNetTool

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
                        failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:@"%@%@",root_URL,@"DrivingSchool/api/shoppingmall.htm"];
    
    
    
    NSDictionary * parmeters = @{@"page":[NSString stringWithFormat:@"%ld",page],
                                 @"pageSize":@(pageSize)};
    
    [XYNetTool postWithUrl:url parameters:parmeters isRefresh:isRefresh viewController:viewController success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSArray * array = responseObject[@"data"];
        success ? success(array) : 0;
    } failure:failure];
}

/**
 *  获取商品 详情
 *
 *  @param mallid         商品 ID
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)getShoppingDetailWithMallid:(id)mallid
                          isRefresh:(BOOL)isRefresh
                     viewController:(XYRootViewController *)viewController
                            success:(nullable void (^)(NSDictionary * dic))success
                            failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:@"%@%@",root_URL,@"DrivingSchool/api/shoppingmalldetail.htm"];
    
    NSDictionary * parmeters = @{@"mallid":mallid};
    
    [XYNetTool postWithUrl:url parameters:parmeters isRefresh:isRefresh viewController:viewController success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success ? success(responseObject[@"data"]) : 0;
    } failure:failure];
}


/**
 *  买商品
 *
 *  @param om_mallid      ID
 *  @param token          token description
 *  @param om_address     地址
 *  @param om_uname       姓名
 *  @param om_phone       电话
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)getBuyShoppingWithMallid:(id)om_mallid
                           token:(id)token
                      om_address:(id)om_address
                        om_uname:(id)om_uname
                        om_phone:(id)om_phone
                       isRefresh:(BOOL)isRefresh
                  viewController:(XYRootViewController *)viewController
                         success:(nullable void (^)(NSDictionary * dic))success
                         failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:@"%@%@",root_URL,@"DrivingSchool/api/conversion.htm"];
    
    NSDictionary * parmeters = @{@"om_mallid"   :om_mallid,
                                 @"token"       :token,
                                 @"om_address"  :om_address,
                                 @"om_uname"    :om_uname,
                                 @"om_phone"    :om_phone};
    
    [XYNetTool postWithUrl:url parameters:parmeters isRefresh:isRefresh viewController:viewController success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success ? success(responseObject[@"data"]) : 0;
    } failure:failure];
}
@end
