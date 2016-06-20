//
//  XYDownloadNetTool.m
//  zhaoZhaoBa
//
//  Created by apple on 16/6/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYDownloadNetTool.h"

@implementation XYDownloadNetTool

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
{
    
    NSURL * downloadURL = [XYDownloadNetTool getVideoURLWithUrl:aUrl];
    if (downloadURL) {
        finish ? finish(downloadURL.absoluteString) : 0;
        return nil;
    }
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    NSData * data = [XYDownloadNetTool getVideoDataURLWithUrl:aUrl];
    
    if (data) {
        return [XYDownloadNetTool downloadFileData:data url:aUrl speed:speed finish:finish];
    }
    
    
    NSURL *URL = [NSURL URLWithString:[aUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];

    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSString * download = [XYDownloadNetTool getDownloadSpeedWithProgress:downloadProgress];
        speed ? speed(download) : 0;
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        return [XYDownloadNetTool getDownloadURLWith:aUrl];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
        
        if ([filePath.description isEqualToString:@"(null)"] || !filePath) {
            return ;
        }
        finish ? finish(filePath.absoluteString) : 0;

    }];
    //开始
    [downloadTask resume];
    
    return downloadTask;

}



/**
 *  下载未完成的文件
 *
 *  @param aUrl   网络地址
 *  @param speed  进度回调
 *  @param finish 完成
 *
 *  @return  NSURLSessionDownloadTask
 */
+ (NSURLSessionDownloadTask *)downloadFileData:(NSData *)data
                                           url:(NSString *)url
                                         speed:(void(^)(NSString *))speed
                                        finish:(void(^)(NSString * filePath))finish
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithResumeData:data progress:^(NSProgress * _Nonnull downloadProgress) {
        NSString * download = [XYDownloadNetTool getDownloadSpeedWithProgress:downloadProgress];
        speed ? speed(download) : 0;
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [XYDownloadNetTool getDownloadURLWith:url];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if ([filePath.description isEqualToString:@"(null)"] || !filePath) {
            return ;
        }
        finish ? finish(filePath.absoluteString) : 0;
    }];
    
       //开始
    [downloadTask resume];
    

    return downloadTask;
}




/**
 *  暂停
 *
 *  @param downloadTask downloadTask description
 */
+ (void)suspendWithDownloadTask:(NSURLSessionDownloadTask *)downloadTask url:(NSString *)url
{
    [XYDownloadNetTool saveDownloadDataWithURL:url downloadTask:downloadTask];
    [downloadTask suspend];
}


/**
 *  根据下载地址 检查本地
 *
 *  @param url 下载地址
 *
 *  @return 本地地址
 */
+ (NSURL *)getVideoURLWithUrl:(NSString *)url
{
    NSURL * URL = [XYDownloadNetTool getDownloadURLWith:url];
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
   
    if ([fileManager fileExistsAtPath:[XYDownloadNetTool getPathWithURL:URL]]) {
        return URL;
    }
    return nil;
}





////////////////////////////////// 没下载完的 ////////////////////////////////////////

/**
 *  获取没下载完的 视频
 *
 *  @param url
 *
 *  @return
 */
+ (NSData *)getVideoDataURLWithUrl:(NSString *)url
{
    NSURL * URL = [XYDownloadNetTool getFialDownloadURLWith:url];
    return [NSData dataWithContentsOfURL:URL];
}

//存 下载一半的 数据
+ (void)saveDownloadDataWithURL:(NSString *)url downloadTask:(NSURLSessionDownloadTask *)downloadTask
{
    [downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        NSURL * URL = [XYDownloadNetTool getFialDownloadURLWith:url];
        BOOL success = [resumeData writeToFile:[XYDownloadNetTool getPathWithURL:URL] atomically:YES];
        NSLog(@" success--- %d",success);
    }];
}




#pragma mark -------------------------------------------------------
#pragma mark Inner Method

+ (NSString *)getDownloadSpeedWithProgress:(NSProgress *)downloadProgress
{
    return [NSString stringWithFormat:@"%.2fM/%.2fM",downloadProgress.completedUnitCount / 1000000.0,downloadProgress.totalUnitCount / 1000000.0];
}

//获取 完成 视频地址
+ (NSURL *)getDownloadURLWith:(NSString *)url
{
    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSURL * newURL = [documentsDirectoryURL URLByAppendingPathComponent:[XYDownloadNetTool getStringWithUrl:url]];
   
    return newURL;
}


//获取 未完成 视频地址
+ (NSURL *)getFialDownloadURLWith:(NSString *)url
{
    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSURL * newURL = [documentsDirectoryURL URLByAppendingPathComponent:[[XYDownloadNetTool getStringWithUrl:url] stringByAppendingString:@".data"]];
    
    return newURL;
}


/**
 *  删除 地址中的特殊字符
 */
+ (NSString *)getStringWithUrl:(NSString *)url
{
    return [url componentsSeparatedByString:@"/"].lastObject;
}

//反UTF8，然后去掉 file://
+ (NSString *)getPathWithURL:(NSURL *)URL
{
    NSString * newUrl = [URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [newUrl stringByReplacingOccurrencesOfString:@"file://" withString:@""];
}



@end
