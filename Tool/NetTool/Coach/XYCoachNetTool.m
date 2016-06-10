//
//  XYCoachNetTool.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYCoachNetTool.h"

@implementation XYCoachNetTool
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
                     failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:@"%@%@",root_URL,@"DrivingSchool/api/coachrank.htm"];
    
    NSDictionary * parmeters = @{
                                 @"sortby":type,
                                 @"sortrule":rule,
                                 @"page":[NSString stringWithFormat:@"%ld",page],
                                 @"pageSize":@(pageSize)}.mutableCopy;

    drvierSchoolID ? [parmeters setValue:drvierSchoolID forKey:@"dsid"] : 0;
    
    [XYNetTool postWithUrl:url parameters:parmeters isRefresh:isRefresh viewController:viewController success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"Coach List -> type = %@",responseObject);
        
        NSArray * array = responseObject[@"data"];
        success ? success(array) : 0;
    } failure:failure];

}


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
                     failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:@"%@%@",root_URL,@"DrivingSchool/api/coachdetail.htm"];
    
    NSDictionary * parmeters = @{@"cid":coachID};
    
    [XYNetTool postWithUrl:url parameters:parmeters isRefresh:isRefresh viewController:viewController success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"Coach Detail -> type = %@",responseObject);
        success ? success(responseObject[@"data"]) : 0;
    } failure:failure];
}


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
{
    NSString * url = [NSString stringWithFormat:@"%@%@",root_URL,@"DrivingSchool/api/coachcomment.htm"];
    
    NSDictionary * parmeters = @{
                                 @"cid":coachID,
                                 @"page":[NSString stringWithFormat:@"%ld",page],
                                 @"pageSize":@(pageSize)};
    
    [XYNetTool postWithUrl:url parameters:parmeters isRefresh:isRefresh viewController:viewController success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"Coach List -> type = %@",responseObject);
        
        NSArray * array = responseObject[@"data"];
        success ? success(array) : 0;
    } failure:failure];
}

@end
