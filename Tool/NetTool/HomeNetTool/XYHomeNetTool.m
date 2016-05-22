//
//  XYHomeNetTool.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYHomeNetTool.h"

@implementation XYHomeNetTool
/**
 *  获取轮播图
 *
 *  @param type           轮播图类型
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 *
 */
+ (void)getCarousePictureWithBannerType:(NSString *)type
                              isRefresh:(BOOL)isRefresh
                         viewController:(XYRootViewController *)viewController
                                success:(nullable void (^)(NSArray * array))success
                                failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:@"%@%@",root_URL,@"DrivingSchool/api/indexbanner.htm"];
    
    NSDictionary * parmeters = @{@"bannertype":type};
    
    [XYNetTool postWithUrl:url parameters:parmeters
                 isRefresh:isRefresh
            viewController:viewController
                   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                      NSLog(@"Carouse Picture -> msg = %@ \n type = %@",responseObject[@"msg"],responseObject);
                      NSArray * array = responseObject[@"data"];
                      success ? success(array) : 0;
                }   failure:failure];
}


@end
