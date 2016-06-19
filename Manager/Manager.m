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

- (NSString *)getStringAddYuanWithObj:(id)obj
{
    return [NSString stringWithFormat:@"%@元",obj];
}

/**
 *  添加 XX年教龄
 *
 */
- (NSString *)getStringAddXXYearWithObj:(id)obj
{
    return [NSString stringWithFormat:@"%@年教龄",obj];
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

/**
 *  获取教练排序类型
 */
- (NSString *)getCoachSortTypeWithChineseSortType:(NSString *)chinese
{
    if ([chinese isEqualToString:coach_list_chinese_type_default]) {
        return coach_list_type_default;
    } else if ([chinese isEqualToString:coach_list_chinese_type_praisenumber]) {
        return coach_list_type_praisenumber;
    } else if ([chinese isEqualToString:coach_list_chinese_type_distance]) {
        return coach_list_type_distance;
    }
    return @"";
}

- (NSString *)getPraiseKeyWithStyle:(CommunityStyle)style
{
    switch (style) {
        case CommunityStyle_Default:        return community_communityid;     break;
        case CommunityStyle_DriverSchool:   return community_driver_school_id; break;
        case CommunityStyle_Coach:          return community_coach_id;     break;
    }
    return @"";
}


- (NSMutableDictionary *)addCellHeightWithDic:(NSDictionary *)dic key:(NSString *)key width:(NSInteger)width size:(NSInteger)size otherHeight:(NSInteger)otherHeight
{
    NSMutableDictionary * newDic = dic.mutableCopy;
    NSString * string = newDic[key];
    
    NSInteger height = [string boundingRectWithSize:CGSizeMake(width, 222222) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:size]} context:nil].size.height;
    [newDic setValue:@(height + otherHeight) forKey:cell_height_key];
    return newDic;
    
}
- (NSMutableArray *)addCellHrightWithArray:(NSArray *)array key:(NSString *)key width:(NSInteger)width size:(NSInteger)size otherHeight:(NSInteger)otherHeight
{
    NSMutableArray * newArray = @[].mutableCopy;
    for (NSDictionary * dic in array) {
        [newArray addObject:[self addCellHeightWithDic:dic key:key width:width size:size otherHeight:otherHeight]];
    }
    return newArray;
}


/**
 *  判断电话号码
 *
 *  @param mobile
 *
 *  @return 返回判断结果
 */
- (NSString *)valiMobile:(NSString *)mobile {
    if (mobile.length != 11)
    {
        return @"电话号码错误";
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return nil;
        }else{
            return @"电话号码错误";
        }
    }
    return nil;
}

/**
 *  身份证
 */
- (NSString *)idCardWithID:(NSString *)ID
{
//    ID = ID.length ? ID : @"123";
    
    NSString *CM_NUM = @"^(\\d{14}|^\\d{17})(\\d|X|x)$";

    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
    BOOL isMatch1 = [pred1 evaluateWithObject:ID];

    if (isMatch1) {
        return nil;
    }else{
        return @"身份证号码错误";
    }
}




/**
 *  给头像 切圆
 *
 */
+ (YYWebImageManager *)avatarImageManager {
    static YYWebImageManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [[UIApplication sharedApplication].cachesPath stringByAppendingPathComponent:@"weibo.avatar"];
        YYImageCache *cache = [[YYImageCache alloc] initWithPath:path];
        manager = [[YYWebImageManager alloc] initWithCache:cache queue:[YYWebImageManager sharedManager].queue];
        manager.sharedTransformBlock = ^(UIImage *image, NSURL *url) {
            if (!image) return image;
            image = [image imageByResizeToSize:CGSizeMake(100, 100)];
            return [image imageByRoundCornerRadius:100];
        };
    });
    return manager;
}

/**
 *  给图片 切圆角
 *
 */
+ (YYWebImageManager *)avatarImageManagerWithRadius:(CGFloat)radius
{
    static YYWebImageManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [[UIApplication sharedApplication].cachesPath stringByAppendingPathComponent:@"weibo.avatar"];
        YYImageCache *cache = [[YYImageCache alloc] initWithPath:path];
        manager = [[YYWebImageManager alloc] initWithCache:cache queue:[YYWebImageManager sharedManager].queue];
        manager.sharedTransformBlock = ^(UIImage *image, NSURL *url) {
            if (!image) return image;
            return [image getImageWithRadiu:radius];
        };
    });
    return manager;
}

/**
 *  给图片 切圆角
 *
 */
+ (YYWebImageManager *)getImageManagerWithImageViewSize:(CGSize)size
{
    static YYWebImageManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [[UIApplication sharedApplication].cachesPath stringByAppendingPathComponent:@"weibo.avatar"];
        YYImageCache *cache = [[YYImageCache alloc] initWithPath:path];
        manager = [[YYWebImageManager alloc] initWithCache:cache queue:[YYWebImageManager sharedManager].queue];
        manager.sharedTransformBlock = ^(UIImage *image, NSURL *url) {
            if (!image) return image;
            return [image getImageWithImageViewSize:size];
        };
    });
    return manager;
}

+ (void)setImageWithImageUrl:(NSString *)url imageView:(UIImageView *)imageView
{
    [imageView setImageWithURL:[NSURL URLWithString:url]
                   placeholder:kDefaultImage];
}

+ (void)setImageWithImageUrl:(NSString *)url button:(UIButton *)button
{
    [button setImageWithURL:[NSURL URLWithString:url]
                   forState:UIControlStateNormal
                placeholder:kDefaultImage];

}

+ (void)setRadiusImageWithImageUrl:(NSString *)url imageView:(UIImageView *)imageView
{
    [imageView setImageWithURL:[NSURL URLWithString:url]
                   placeholder:kDefaultImage
                       options:kNilOptions
                       manager:[Manager avatarImageManager]
                      progress:nil
                     transform:nil
                    completion:nil];
}
+ (void)setRadiusImageWithImageUrl:(NSString *)url button:(UIButton *)button
{
    [button setImageWithURL:[NSURL URLWithString:url]
                   forState:UIControlStateNormal
                placeholder:kDefaultImage
                    options:kNilOptions
                    manager:[Manager avatarImageManager]
                   progress:nil
                  transform:nil
                 completion:nil];

}

@end
