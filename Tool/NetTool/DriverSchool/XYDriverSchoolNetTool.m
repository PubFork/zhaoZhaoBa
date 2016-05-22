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
    
    [XYNetTool postWithUrl:url parameters:parmeters isRefresh:NO viewController:viewController success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
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
    
    [XYNetTool postWithUrl:url parameters:parmeters isRefresh:NO viewController:viewController success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"Driver School -> type = %@",responseObject);
        
        NSDictionary * dic = responseObject[@"data"];
        success ? success(dic) : 0;
    } failure:failure];

}
@end
