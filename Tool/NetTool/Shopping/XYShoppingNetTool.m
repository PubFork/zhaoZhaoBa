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
    
    [XYNetTool postWithUrl:url parameters:parmeters isRefresh:NO viewController:viewController success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSArray * array = responseObject[@"data"];
        success ? success(array) : 0;
    } failure:failure];
}
@end
