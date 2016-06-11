//
//  XYDriverSchoolNetTool.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYDriverSchoolNetTool.h"

@implementation XYDriverSchoolNetTool

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
                            failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:@"%@%@",root_URL,@"DrivingSchool/api/schoollist.htm"];
    
    NSString * latitude = [kUserD valueForKey:kLocation_latitude];
    NSString * longitude = [kUserD valueForKey:kLocation_longitude];
    
    latitude = latitude ? latitude : @"39.851333";
    longitude = longitude ? longitude : @"116.33677";
    
    NSDictionary * parmeters = @{@"latitude":latitude,
                                 @"longitude":longitude,
                                 @"sortby":type,
                                 @"sortrule":sortRule,
                                 @"page":[NSString stringWithFormat:@"%ld",page],
                                 @"pageSize":@(pageSize)};
    
    [XYNetTool postWithUrl:url parameters:parmeters isRefresh:isRefresh viewController:viewController success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"Driver School -> type = %@",responseObject);
        
        NSArray * array = responseObject[@"data"];
        success ? success(array) : 0;
    } failure:failure];
}


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
                            failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:@"%@%@",root_URL,@"DrivingSchool/api/driversschooldetail.htm"];
    
    
    NSDictionary * parmeters = @{@"dsid":@(ID)};
    
    [XYNetTool postWithUrl:url parameters:parmeters isRefresh:isRefresh viewController:viewController success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"Driver School -> type = %@",responseObject);
        
        NSDictionary * dic = responseObject[@"data"];
        success ? success(dic) : 0;
    } failure:failure];

}


/**
 *  驾校详情 评论  列表
 *
 *  @param page           页数
 *  @param dsid           驾校ID
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)getDSCommunityListWithPage:(NSInteger)page
                         isRefresh:(BOOL)isRefresh
                              dsid:(id)dsid
                    viewController:(XYRootViewController *)viewController
                           success:(nullable void (^)(NSArray * array))success
                           failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;
{
    NSString * url = [NSString stringWithFormat:@"%@%@",root_URL,@"DrivingSchool/api/praisedslist.htm"];
    
    
    
    NSDictionary * parmeters = @{@"page":[NSString stringWithFormat:@"%ld",page],
                                 @"pageSize":@(pageSize),
                                 @"dsid":dsid};
    
    [XYNetTool postWithUrl:url parameters:parmeters isRefresh:isRefresh viewController:viewController success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSArray * array = responseObject[@"data"];
        success ? success(array) : 0;
    } failure:failure];
}


/**
 *  驾校详情 评论 详情
 *
 *  @param ID             ID
 *  @param page           页数
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)getDSCommunityDetailWithID:(NSNumber *)ID
                              page:(NSInteger)page
                         isRefresh:(BOOL)isRefresh
                    viewController:(XYRootViewController *)viewController
                           success:(nullable void (^)(NSDictionary * dic))success
                           failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:@"%@%@",root_URL,@"DrivingSchool/api/praisedsdetail.htm"];
    
    
    
    NSDictionary * parmeters = @{@"pdid":ID,
                                 @"page":[NSString stringWithFormat:@"%ld",page],
                                 @"pageSize":@(pageSize)};
    
    [XYNetTool postWithUrl:url parameters:parmeters isRefresh:isRefresh viewController:viewController success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        success ? success(responseObject[@"data"]) : 0;
    } failure:failure];
}


/**
 *  发布评论
 *
 *  @param content        内容
 *  @param servier        服务星际 1-5
 *  @param envir          环境 1-5
 *  @param car            车辆 1-5
 *  @param files          图片
 *  @param pd_dsid        驾校ID
 *  @param isRefresh      是否 刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)releaseDSCommunityWithContent:(NSString *)content
                              servier:(NSInteger)servier
                                envir:(NSInteger)envir
                                  car:(NSInteger)car
                                files:(id)files
                              pd_dsid:(id)pd_dsid
                            isRefresh:(BOOL)isRefresh
                       viewController:(XYRootViewController *)viewController
                              success:(nullable void (^)(NSDictionary * dic))success
                              failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;
{
    NSString * url = [NSString stringWithFormat:@"%@%@",root_URL,@"DrivingSchool/api/addpraiseds.htm"];
    
    
    
    NSDictionary * parmeters = @{@"pd_uid":[kUserD valueForKey:user_info_userID],
                                 @"files":files,
                                 @"pd_dsid":pd_dsid,
                                 @"pd_content":content,
                                 @"pd_service":@(servier),
                                 @"pd_envir":@(envir),
                                 @"pd_vehicle":@(car)};
    
    [XYNetTool postWithUrl:url parameters:parmeters isRefresh:isRefresh viewController:viewController success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success ? success(responseObject[@"data"]) : 0;
    } failure:failure];
}

/**
 *  发布回复
 *
 *  @param content        内容
 *  @param communityID          评论ID
 *  @param repleUserID          被回复人的ID
 *  @param isRefresh      是否 刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)repleDSCommunityWithContent:(NSString *)content
                        communityID:(id)communityID
                        repleUserID:(id)repleUserID
                          isRefresh:(BOOL)isRefresh
                     viewController:(XYRootViewController *)viewController
                            success:(nullable void (^)(NSDictionary * dic))success
                            failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:@"%@%@",root_URL,@"DrivingSchool/api/addpraisedsreply.htm"];
    
    
    
    NSMutableDictionary * parmeters = @{ @"r_uid":[kUserD valueForKey:user_info_userID],
                                         @"r_content":content,
                                         @"pdid":communityID
                                         }.mutableCopy;
    repleUserID ? parmeters[@"r_repid"] = repleUserID : 0;
    
    [XYNetTool postWithUrl:url parameters:parmeters isRefresh:isRefresh viewController:viewController success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success ? success(responseObject[@"data"]) : 0;
    } failure:failure];
}


@end
