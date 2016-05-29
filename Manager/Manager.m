//
//  Manager.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "Manager.h"

@implementation Manager

+ (Manager *)shareManager
{
    static Manager * manger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [[Manager alloc] init];
    });
    return manger;
}

- (void)createAlertOnceSureWithMessage:(NSString *)message title:(NSString *)title
{
    if (!title) {
        title = @"提示";
    }
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:nil
                                          otherButtonTitles:@"确定", nil];
    [alert show];
}

- (NSString *)getStringWithObj:(id)obj
{
    return [NSString stringWithFormat:@"%@",obj];
}
- (NSString *)getStringAddNumberWithObj:(id)obj
{
    return [NSString stringWithFormat:@"%@人已报名",obj];
}
- (NSString *)getStringAddKMWithObj:(id)obj
{
    return [NSString stringWithFormat:@"%@km",obj];
}


/**
 *  获取驾校排序类型
 */
- (NSString *)getDriverSchoolSortTypeWithChineseSortType:(NSString *)chinese
{
    if ([chinese isEqualToString:driver_school_sort_type_default]) {
        return DriverSchoolSortType_default;
    } else if ([chinese isEqualToString:driver_school_sort_type_price]) {
        return DriverSchoolSortType_price;
    } else if ([chinese isEqualToString:driver_school_sort_type_distance]) {
        return DriverSchoolSortType_distance;
    } else if ([chinese isEqualToString:driver_school_sort_type_sign_up_number]) {
        return DriverSchoolSortType_signnumber;
    } else if ([chinese isEqualToString:driver_school_sort_type_service]) {
        return DriverSchoolSortType_service;
    } else if ([chinese isEqualToString:driver_school_sort_type_car]) {
        return DriverSchoolSortType_car;
    } else if ([chinese isEqualToString:driver_school_sort_type_environment]) {
        return DriverSchoolSortType_environment;
    }
    return @"";
}
@end
