//
//  XYDownloadNetTool.h
//  zhaoZhaoBa
//
//  Created by apple on 16/6/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYNetTool.h"
#import "NSObject+NSCoding.h"

@interface XYDownloadModel : NSObject <NSCoding>

@property (nonatomic, strong)NSURLSessionDownloadTask * downloadTask;

@property (nonatomic, copy)NSString * downloadSpeed;

@property (nonatomic, strong)NSURL * localURL;
@property (nonatomic, strong)NSURL * fialLocalURL;

@property (nonatomic, copy)NSString * httpUrl;

@property (nonatomic, assign)BOOL isFinish;

@end


@interface XYDownloadNetTool : XYNetTool


+ (NSMutableDictionary *)getDownloadDic;



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
                                       finish:(void(^)())finish;

/**
 *  暂停
 *
 *  @param downloadTask
 */
+ (void)suspendWithDownloadTask:(NSURLSessionDownloadTask *)downloadTask url:(NSString *)url;





//////////////////////////////////// 本地URL 文件不一定存在 //////////////////////////////////////

//获取 完成 视频地址
+ (NSURL *)getDownloadURLWith:(NSString *)url;

//获取 未完成 视频地址
+ (NSURL *)getFialDownloadURLWith:(NSString *)url;




//////////////////////////////////// 对下载队列的操作 //////////////////////////////////////

+ (void)saveToDiskOfDownloadDic;


@end
