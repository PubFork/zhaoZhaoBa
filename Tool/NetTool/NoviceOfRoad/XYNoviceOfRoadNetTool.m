//
//  XYNoviceOfRoadNetTool.m
//  zhaoZhaoBa
//
//  Created by apple on 16/6/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYNoviceOfRoadNetTool.h"

@implementation XYNoviceOfRoadNetTool
/**
 *  新手上路  列表
 *
 *  @param page           页数
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)getNoviceOfRoadListWithPage:(NSInteger)page
                          isRefresh:(BOOL)isRefresh
                     viewController:(XYRootViewController *)viewController
                            success:(nullable void (^)(NSArray * array))success
                            failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:@"%@%@",root_URL,@"DrivingSchool/api/noviceroadlist.htm"];
    
    
    
    NSDictionary * parmeters = @{@"page":[NSString stringWithFormat:@"%ld",page],
                                 @"pageSize":@(pageSize)};
    
    [XYNetTool postWithUrl:url parameters:parmeters isRefresh:isRefresh viewController:viewController success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSArray * array = responseObject[@"data"];
        success ? success(array) : 0;
    } failure:failure];
}

/**
 *  新手上路  详情
 *
 *  @param ID             ID
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)getNoviceOfRoadDetailWithID:(NSNumber *)ID
                          isRefresh:(BOOL)isRefresh
                     viewController:(XYRootViewController *)viewController
                            success:(nullable void (^)(NSDictionary * dic))success
                            failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;

{
    NSString * url = [NSString stringWithFormat:@"%@%@",root_URL,@"DrivingSchool/api/noviceroaddetail.htm"];
    
    
    
    NSDictionary * parmeters = @{@"nrid":ID};
    
    [XYNetTool postWithUrl:url parameters:parmeters isRefresh:isRefresh viewController:viewController success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success ? success(responseObject[@"data"]) : 0;
    } failure:failure];
}
@end
