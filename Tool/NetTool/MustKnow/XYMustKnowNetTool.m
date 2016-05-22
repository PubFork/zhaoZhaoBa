//
//  XYMustKnowNetTool.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYMustKnowNetTool.h"

@implementation XYMustKnowNetTool
/**
 *  必知晓
 *
 *  @param page           页数
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)getMustKnowWithPage:(NSInteger)page
                  isRefresh:(BOOL)isRefresh
             viewController:(XYRootViewController *)viewController
                    success:(nullable void (^)(NSArray * array))success
                    failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:@"%@%@",root_URL,@"DrivingSchool/api/mustknowlist.htm"];
    
    NSDictionary * parmeters = @{@"page":@(page),
                                 @"pageSize":@(pageSize)};
    
    [XYNetTool postWithUrl:url
                parameters:parmeters
                 isRefresh:isRefresh
            viewController:viewController
                   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                       NSLog(@"Carouse Picture -> msg = %@ \n type = %@",responseObject[@"msg"],responseObject);
                       NSArray * array = responseObject[@"data"];
                       success ? success(array) : 0;
                   }   failure:failure];
    

}


/**
 *  必知晓 详情
 *
 *  @param ID           ID
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)getMustKnowDetailWithID:(NSInteger)ID
                      isRefresh:(BOOL)isRefresh
                 viewController:(XYRootViewController *)viewController
                        success:(nullable void (^)(NSDictionary * dic))success
                        failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:@"%@%@",root_URL,@"DrivingSchool/api/mustknowdetail.htm"];
    
    NSDictionary * parmeters = @{@"mkId":@(ID)};
    
    [XYNetTool postWithUrl:url
                parameters:parmeters
                 isRefresh:isRefresh
            viewController:viewController
                   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                       NSLog(@"Carouse Picture -> msg = %@ \n type = %@",responseObject[@"msg"],responseObject);
                       NSDictionary * dic = responseObject[@"data"];
                       success ? success(dic) : 0;
                   }   failure:failure];

}
@end
