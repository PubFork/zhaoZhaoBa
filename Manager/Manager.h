//
//  Manager.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Manager : NSObject

+ (Manager *)shareManager;

- (void)createAlertOnceSureWithMessage:(NSString *)message title:(NSString *)title;

/**
 *  转换 为 String
 */
- (NSString *)getStringWithObj:(id)obj;

/**
 *  添加  人已报名
 *
 */
- (NSString *)getStringAddNumberWithObj:(id)obj;

/**
 *  添加  km
 *
 */
- (NSString *)getStringAddKMWithObj:(id)obj;

/**
 *  添加  元
 *
 */
- (NSString *)getStringAddYuanWithObj:(id)obj;

/**
 *  添加 XX年教龄
 *
 */
- (NSString *)getStringAddXXYearWithObj:(id)obj;



/**
 *  获取驾校排序类型
 */
- (NSString *)getDriverSchoolSortTypeWithChineseSortType:(NSString *)chinese;

/**
 *  获取教练排序类型
 */
- (NSString *)getCoachSortTypeWithChineseSortType:(NSString *)chinese;
@end
