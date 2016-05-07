//
//  XYShareTool.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYShareTool.h"
#import "UMSocial.h"

@implementation XYShareTool


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
                                         faile:(void(^)(NSString * errorMessage))faile
{
    
    [UMSocialData defaultData].extConfig.wechatSessionData.title = title;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession]
                                                        content:content
                                                          image:image
                                                       location:nil
                                                    urlResource:nil
                                            presentedController:viewController
                                                     completion:^(UMSocialResponseEntity *response){
                                                         if (response.responseCode == UMSResponseCodeSuccess) {
                                                             [kShowLabel setText:@"分享成功"];
                                                             success ? success() : 0;
                                                         } else {
//                                                             [MBProgressHUD showError:@"分享失败"];
                                                             faile ? faile(response.message) : 0;
                                                         }
                                                     }];

}

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
                                          faile:(void(^)(NSString * errorMessage))faile
{
    
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = title;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline]
                                                        content:content
                                                          image:image
                                                       location:nil
                                                    urlResource:nil
                                            presentedController:viewController
                                                     completion:^(UMSocialResponseEntity *response){
                                                         if (response.responseCode == UMSResponseCodeSuccess) {
                                                             [kShowLabel setText:@"分享成功"];
                                                             success ? success() : 0;
                                                         } else {
                                                             //                                                             [MBProgressHUD showError:@"分享失败"];
                                                             faile ? faile(response.message) : 0;
                                                         }
                                                     }];
}


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
                              faile:(void(^)(NSString * errorMessage))faile
{
    [UMSocialData defaultData].extConfig.qqData.title = title;
    [UMSocialData defaultData].extConfig.qqData.url = url;
    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ]
                                                        content:content
                                                          image:image
                                                       location:nil
                                                    urlResource:nil
                                            presentedController:viewController
                                                     completion:^(UMSocialResponseEntity *response){
                                                         if (response.responseCode == UMSResponseCodeSuccess) {
                                                             [kShowLabel setText:@"分享成功"];
                                                             success ? success() : 0;
                                                         } else {
                                                             //                                                             [MBProgressHUD showError:@"分享失败"];
                                                             faile ? faile(response.message) : 0;
                                                         }
                                                     }];

}


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
                                faile:(void(^)(NSString * errorMessage))faile
{
    
    content = [NSString stringWithFormat:@"%@%@ %@",content,url,shareSina_AppName];
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina]
                                                        content:content
                                                          image:image
                                                       location:nil
                                                    urlResource:nil
                                            presentedController:viewController
                                                     completion:^(UMSocialResponseEntity *response){
                                                         if (response.responseCode == UMSResponseCodeSuccess) {
                                                             [kShowLabel setText:@"分享成功"];
                                                             success ? success() : 0;
                                                         } else {
                                                             //                                                             [MBProgressHUD showError:@"分享失败"];
                                                             faile ? faile(response.message) : 0;
                                                         }
                                                     }];
}



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
                                  faile:(void(^)(NSString * errorMessage))faile
{
    [UMSocialData defaultData].extConfig.renrenData.appName = shareSina_AppName;
    [UMSocialData defaultData].extConfig.renrenData.url = url;
    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToRenren]
                                                        content:content
                                                          image:image
                                                       location:nil
                                                    urlResource:nil
                                            presentedController:viewController
                                                     completion:^(UMSocialResponseEntity *response){
                                                         if (response.responseCode == UMSResponseCodeSuccess) {
                                                             [kShowLabel setText:@"分享成功"];
                                                             success ? success() : 0;
                                                         } else {
                                                             //                                                             [MBProgressHUD showError:@"分享失败"];
                                                             faile ? faile(response.message) : 0;
                                                         }
                                                     }];

}


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
                                 faile:(void(^)(NSString * errorMessage))faile
{
    [UMSocialData defaultData].extConfig.emailData.title = title;
    content = [content stringByAppendingString:[NSString stringWithFormat:@"/n %@",url]];
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToEmail]
                                                        content:content
                                                          image:image
                                                       location:nil
                                                    urlResource:nil
                                            presentedController:viewController
                                                     completion:^(UMSocialResponseEntity *response){
                                                         if (response.responseCode == UMSResponseCodeSuccess) {
                                                             [kShowLabel setText:@"分享成功"];
                                                             success ? success() : 0;
                                                         } else {
                                                             //                                                             [MBProgressHUD showError:@"分享失败"];
                                                             faile ? faile(response.message) : 0;
                                                         }
                                                     }];
}


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
                               faile:(void(^)(NSString * errorMessage))faile
{
    
    content = [content stringByAppendingString:[NSString stringWithFormat:@"/n %@",url]];
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSms]
                                                        content:content
                                                          image:image
                                                       location:nil
                                                    urlResource:nil
                                            presentedController:viewController
                                                     completion:^(UMSocialResponseEntity *response){
                                                         if (response.responseCode == UMSResponseCodeSuccess) {
                                                             [kShowLabel setText:@"分享成功"];
                                                             success ? success() : 0;
                                                         } else {
                                                             //                                                             [MBProgressHUD showError:@"分享失败"];
                                                             faile ? faile(response.message) : 0;
                                                         }
                                                     }];
}
@end
