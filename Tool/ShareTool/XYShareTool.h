//
//  XYShareTool.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYShareTool : NSObject

/**
 *  分享到 微信好友
 *
 *  @param viewController 控制器 用它来进行模态
 *  @param url            分享的链接  若有
 *  @param title          标题
 *  @param content        内容
 *  @param image          图片
 *  @param success        成功
 *  @param faile          失败 返回失败原因;
 */
+ (void)shareToWeChatSessionWithViewController:(UIViewController *)viewController
                                           url:(NSString *)url
                                         title:(NSString *)title
                                       content:(NSString *)content
                                         image:(UIImage *)image
                                       success:(void(^)())success
                                         faile:(void(^)(NSString * errorMessage))faile;

/**
 *  分享到 微信朋友圈
 *
 *  @param viewController 控制器 用它来进行模态
 *  @param url            分享的链接  若有
 *  @param title          标题
 *  @param content        内容
 *  @param image          图片
 *  @param success        成功
 *  @param faile          失败 返回失败原因;
 */
+ (void)shareToWeChatTimelineWithViewController:(UIViewController *)viewController
                                            url:(NSString *)url
                                          title:(NSString *)title
                                        content:(NSString *)content
                                          image:(UIImage *)image
                                        success:(void(^)())success
                                          faile:(void(^)(NSString * errorMessage))faile;


/**
 *  分享到 QQ
 *
 *  @param viewController 控制器 用它来进行模态
 *  @param url            分享的链接  若有
 *  @param title          标题
 *  @param content        内容
 *  @param image          图片
 *  @param success        成功
 *  @param faile          失败 返回失败原因;
 */
+ (void)shareToQQWithViewController:(UIViewController *)viewController
                                url:(NSString *)url
                              title:(NSString *)title
                            content:(NSString *)content
                              image:(UIImage *)image
                            success:(void(^)())success
                              faile:(void(^)(NSString * errorMessage))faile;


/**
 *  分享到 新浪微博
 *
 *  @param viewController 控制器 用它来进行模态
 *  @param url            分享的链接  若有
 *  @param title          标题
 *  @param content        内容
 *  @param image          图片
 *  @param success        成功
 *  @param faile          失败 返回失败原因;
 */
+ (void)shareToSinaWithViewController:(UIViewController *)viewController
                                  url:(NSString *)url
                                title:(NSString *)title
                              content:(NSString *)content
                                image:(UIImage *)image
                              success:(void(^)())success
                                faile:(void(^)(NSString * errorMessage))faile;

/**
 *  分享到 人人网
 *
 *  @param viewController 控制器 用它来进行模态
 *  @param url            分享的链接  若有
 *  @param title          标题
 *  @param content        内容
 *  @param image          图片
 *  @param success        成功
 *  @param faile          失败 返回失败原因;
 */
+ (void)shareToRenrenWithViewController:(UIViewController *)viewController
                                    url:(NSString *)url
                                  title:(NSString *)title
                                content:(NSString *)content
                                  image:(UIImage *)image
                                success:(void(^)())success
                                  faile:(void(^)(NSString * errorMessage))faile;


/**
 *  分享到 邮箱
 *
 *  @param viewController 控制器 用它来进行模态
 *  @param url            分享的链接  若有
 *  @param title          标题
 *  @param content        内容
 *  @param image          图片
 *  @param success        成功
 *  @param faile          失败 返回失败原因;
 */
+ (void)shareToEmailWithViewController:(UIViewController *)viewController
                                   url:(NSString *)url
                                 title:(NSString *)title
                               content:(NSString *)content
                                 image:(UIImage *)image
                               success:(void(^)())success
                                 faile:(void(^)(NSString * errorMessage))faile;

/**
 *  分享到 短信
 *
 *  @param viewController 控制器 用它来进行模态
 *  @param url            分享的链接  若有
 *  @param title          标题
 *  @param content        内容
 *  @param image          图片
 *  @param success        成功
 *  @param faile          失败 返回失败原因;
 */
+ (void)shareToSmsWithViewController:(UIViewController *)viewController
                                 url:(NSString *)url
                               title:(NSString *)title
                             content:(NSString *)content
                               image:(UIImage *)image
                             success:(void(^)())success
                               faile:(void(^)(NSString * errorMessage))faile;

@end
