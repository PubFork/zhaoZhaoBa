//
//  XYDownloadNetTool.h
//  zhaoZhaoBa
//
//  Created by apple on 16/6/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYNetTool.h"

@interface XYDownloadNetTool : XYNetTool




/**
 *  下载文件
 *
 *  @param aUrl   网络地址
 *  @param speed  进度回调
 *  @param finish 完成
 *
 *  @return  NSURLSessionDownloadTask
 */
+ (NSURLSessionDownloadTask *)downloadFileURL:(NSString *)aUrl
                                        speed:(void(^)(NSString * download))speed
                                       finish:(void(^)(NSString * filePath))finish;




/**
 *  暂停
 *
 *  @param downloadTask
 */
+ (void)suspendWithDownloadTask:(NSURLSessionDownloadTask *)downloadTask url:(NSString *)url;


/**
 *  根据下载地址 检查本地
 *
 *  @param url 下载地址
 *
 *  @return 本地地址
 */
+ (NSURL *)getVideoURLWithUrl:(NSString *)url;

/**
 *  获取没下载完的 视频
 *
 *  @param url
 *
 *  @return
 */
+ (NSData *)getVideoDataURLWithUrl:(NSString *)url;
@end
