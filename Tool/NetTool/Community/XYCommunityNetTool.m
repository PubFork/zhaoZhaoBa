//
//  XYCommunityNetTool.m
//  zhaoZhaoBa
//
//  Created by apple on 16/6/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYCommunityNetTool.h"

@implementation XYCommunityNetTool
/**
 *  获取社区汇  列表
 *
 *  @param page           页数
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)getCommunityListWithPage:(NSInteger)page
                       isRefresh:(BOOL)isRefresh
                  viewController:(XYRootViewController *)viewController
                         success:(nullable void (^)(NSArray * array))success
                         failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:@"%@%@",root_URL,@"DrivingSchool/api/communitylist.htm"];
    

    
    NSDictionary * parmeters = @{@"page":[NSString stringWithFormat:@"%ld",page],
                                 @"pageSize":@(pageSize)};
    
    [XYNetTool postWithUrl:url parameters:parmeters isRefresh:NO viewController:viewController success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSArray * array = responseObject[@"data"];
        success ? success(array) : 0;
    } failure:failure];

}

/**
 *  社区汇  详情
 *
 *  @param ID             ID
 *  @param page           页数
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)getCommunityDetailWithID:(NSNumber *)ID
                            page:(NSInteger)page
                       isRefresh:(BOOL)isRefresh
                  viewController:(XYRootViewController *)viewController
                         success:(nullable void (^)(NSDictionary * dic))success
                         failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:@"%@%@",root_URL,@"DrivingSchool/api/communitydetail.htm"];
    
    
    
    NSDictionary * parmeters = @{@"comid":ID,
                                 @"page":[NSString stringWithFormat:@"%ld",page],
                                 @"pageSize":@(pageSize)};
    
    [XYNetTool postWithUrl:url parameters:parmeters isRefresh:NO viewController:viewController success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        success ? success(responseObject[@"data"]) : 0;
    } failure:failure];

}


/**
 *  发布社区汇
 *
 *  @param content        内容
 *  @param files          图片
 *  @param isRefresh      是否 刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)releaseCommunityWithContent:(NSString *)content
                              files:(id)files
                          isRefresh:(BOOL)isRefresh
                     viewController:(XYRootViewController *)viewController
                            success:(nullable void (^)(NSDictionary * dic))success
                            failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:@"%@%@",root_URL,@"DrivingSchool/api/ddcommunity.htm"];
    
    
    
    NSDictionary * parmeters = @{@"ct_uid":[kUserD valueForKey:user_info_userID],
                                 @"files":files,
                                 @"ct_content":content};
    
    [XYNetTool postWithUrl:url parameters:parmeters isRefresh:NO viewController:viewController success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
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
+ (void)repleCommunityWithContent:(NSString *)content
                      communityID:(id)communityID
                      repleUserID:(id)repleUserID
                        isRefresh:(BOOL)isRefresh
                   viewController:(XYRootViewController *)viewController
                          success:(nullable void (^)(NSDictionary * dic))success
                          failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:@"%@%@",root_URL,@"DrivingSchool/api/addcommunityreply.htm"];
    
    
    
    NSDictionary * parmeters = @{@"r_uid":[kUserD valueForKey:user_info_userID],
                                 @"r_content":content,
                                 @"r_comid":communityID,
                                 @"r_repid":repleUserID};
    
    [XYNetTool postWithUrl:url parameters:parmeters isRefresh:NO viewController:viewController success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success ? success(responseObject[@"data"]) : 0;
    } failure:failure];
}
@end
