//
//  XYCareShowNetTool.m
//  zhaoZhaoBa
//
//  Created by apple on 16/6/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYCareShowNetTool.h"

@implementation XYCareShowNetTool
/**
 *  车展  列表
 *
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)getCareShowIsRefresh:(BOOL)isRefresh
              viewController:(XYRootViewController *)viewController
                     success:(nullable void (^)(NSDictionary * dic))success
                     failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:@"%@%@",root_URL,@"DrivingSchool/api/carbrandlist.htm"];
    
    [XYNetTool postWithUrl:url parameters:nil isRefresh:isRefresh viewController:viewController success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success ? success(responseObject[@"data"]) : 0;
    } failure:failure];
}


/**
 *  获取 车展 型号列表
 *
 *  @param carID          车id
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)getCareShowTypeWithCarID:(id)carID
                       isRefresh:(BOOL)isRefresh
                  viewController:(XYRootViewController *)viewController
                         success:(nullable void (^)(NSDictionary * dic))success
                         failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:@"%@%@",root_URL,@"DrivingSchool/api/carshowlist.htm"];
    
    NSDictionary * parameters = @{@"cartypeid":carID};
    
    [XYNetTool postWithUrl:url parameters:parameters isRefresh:isRefresh viewController:viewController success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success ? success(responseObject[@"data"]) : 0;
    } failure:failure];
}

/**
 *  获取 车展 图片列表
 *
 *  @param carID          车型号id
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)getCareImageListWithCarTypeID:(id)carTypeID
                            isRefresh:(BOOL)isRefresh
                       viewController:(XYRootViewController *)viewController
                              success:(nullable void (^)(NSDictionary * dic))success
                              failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:@"%@%@",root_URL,@"DrivingSchool/api/picturelist.htm"];
    
    NSDictionary * parameters = @{@"carid":carTypeID};
    
    [XYNetTool postWithUrl:url parameters:parameters isRefresh:isRefresh viewController:viewController success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success ? success(responseObject[@"data"]) : 0;
    } failure:failure];

}



/**
 *  获取 车 所有图片列表
 *
 *  @param carTypeID          车型号id
 *  @param page             页数
 *  @param carID          车id
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)getCareImageTypeWithCarTypeID:(id)carTypeID
                                 page:(NSInteger)page
                          imageListID:(id)imageListID
                            isRefresh:(BOOL)isRefresh
                       viewController:(XYRootViewController *)viewController
                              success:(nullable void (^)(NSDictionary * dic))success
                              failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:@"%@%@",root_URL,@"DrivingSchool/api/pictureproduct.htm"];
    
    NSDictionary * parameters = @{@"carid":carTypeID,
                                  @"typeid":imageListID,
                                  @"page":@(page),
                                  @"pageSize":@(pageSize)};
    
    [XYNetTool postWithUrl:url parameters:parameters isRefresh:isRefresh viewController:viewController success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success ? success(responseObject[@"data"]) : 0;
    } failure:failure];
}

@end
