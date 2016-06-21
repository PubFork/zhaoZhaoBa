//
//  XYDownloadNetTool.m
//  zhaoZhaoBa
//
//  Created by apple on 16/6/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYDownloadNetTool.h"

static NSInteger download_speed_view_width = 117;


//保存视频的 文件夹
static NSString * documents_video_path = @"video";

static NSString * archiver_key = @"archiverkey";



@implementation XYDownloadModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [[XYDownloadNetTool getDownloadDic] setValue:self forKey:self.httpUrl];
    [self autoEncodeWithCoder:aCoder];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if ([super init]) {
        [self autoDecode:aDecoder];
    }
    return self;
}


#pragma mark -----------------------------------------------------------
#pragma mark - Setting


- (void)setHttpUrl:(NSString *)httpUrl
{
    _httpUrl = httpUrl.copy;
    
    self.localURL = [XYDownloadNetTool getDownloadURLWith:httpUrl];
    self.fialLocalURL = [XYDownloadNetTool getFialDownloadURLWith:httpUrl];
    
}

- (void)setDownloadSpeed:(NSString *)downloadSpeed
{
    _downloadTask = downloadSpeed.copy;
    
    NSArray * array = [downloadSpeed componentsSeparatedByString:@"/"];
    
    NSString * str1 = array.firstObject;
    NSString * str2 = array.lastObject;
    
    str1 = [str1 stringByReplacingOccurrencesOfString:@"M" withString:@""];
    str2 = [str2 stringByReplacingOccurrencesOfString:@"M" withString:@""];
    
    self.speed = str1.floatValue / str2.floatValue;
    
    NSLog(@" self.speed  % f = str1.floatValue  %f / str2.floatValue %f;  ", self.speed , str1.floatValue , str2.floatValue);


    dispatch_async(dispatch_get_main_queue(), ^{
        self.label.text = downloadSpeed;
        NSLog(@"%@ --- %@",self,self.label);
        
        if (!isnan(self.speed)) {
            self.speedViewWidth.constant = (int)(self.speed * download_speed_view_width);
            NSLog(@"self.speed * download_speed_view_width = %d",(int)(self.speed * download_speed_view_width));
        }
        
        NSLog(@" self.speedViewWidth.constant = %f",self.speedViewWidth.constant);
    });
}

- (void)setIsFinish:(BOOL)isFinish
{
    _isFinish = isFinish;
    
    if (isFinish) {
        [self finish];
    }
}

#pragma mark -----------------------------------------------------------
#pragma mark - Method

- (void)save
{
    NSLog(@" %@  -- %@",[[XYDownloadNetTool getDownloadDic] valueForKey:self.httpUrl],[[[XYDownloadNetTool getDownloadDic] valueForKey:self.httpUrl] label]);
    
    [[XYDownloadNetTool getDownloadDic] setValue:self forKey:self.httpUrl];
    
    NSLog(@" %@  -- %@",[[XYDownloadNetTool getDownloadDic] valueForKey:self.httpUrl],[[[XYDownloadNetTool getDownloadDic] valueForKey:self.httpUrl] label]);

}

+ (XYDownloadModel *)createDownLoadModeWithDic:(NSDictionary *)dic
{
    XYDownloadModel * model = [[XYDownloadModel alloc] init];
    model.httpUrl = dic[video_ev_videourl];
    [model save];
    return model;
}

+ (XYDownloadModel *)createDownLoadModeWithUrl:(NSString *)url
{
    XYDownloadModel * model = [[XYDownloadModel alloc] init];
    model.httpUrl = url;
    [model save];
    return model;
}





//暂停 图片切换为 下载
- (void)suspend
{
    [self.downloadTask suspend];
    self.type = DownloadModelType_Suspent;
    self.imageView.image = [self getImageWithType:0];
}

//开始下载 图片换为 暂停
- (void)download
{
    WeakSelf(weakSelf);
    [XYDownloadNetTool downloadFileURL:self.httpUrl speed:^(NSString *download) {
        
    } finish:^{
        [weakSelf finish];
    }];
    
    self.type = DownloadModelType_Download;
    self.imageView.image = [self getImageWithType:1];
}

//完成 图片切换为 播放
- (void)finish
{
    self.isFinish = YES;
    self.type = DownloadModelType_Finish;
    self.imageView.image = [self getImageWithType:2];
}


- (void)clickImageView
{
    switch (self.type) {
        case DownloadModelType_None: {
            [self download];
            
            break;
        }
        case DownloadModelType_Download: {
            [self suspend];
            break;
        }
        case DownloadModelType_Suspent: {
            [self download];
            break;
        }
        case DownloadModelType_Finish: {
            break;
        }
    }
}


// 0 => 下载  1 => 暂停  2 => 播放
- (UIImage *)getImageWithType:(NSInteger)type
{
    static UIImage * downloadImage = nil;
    static UIImage * suspendImage = nil;
    static UIImage * playImage = nil;

    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downloadImage = kImage(@"下载");
        suspendImage = kImage(@"暂停");
        playImage = kImage(@"播放");
    });
    
    switch (type) {
        case 0: return downloadImage;
        case 1: return suspendImage;
        case 2: return playImage;
    }
    return kDefaultImage;
}

@end

@implementation XYDownloadNetTool


+ (NSMutableDictionary *)getDownloadDic
{
    static NSMutableDictionary * downloadDic = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downloadDic = [XYDownloadNetTool getDownloadDicWithDisk];
        NSLog(@"downloadDic ==> %@",downloadDic);
        if (!downloadDic) {
            downloadDic = @{}.mutableCopy;
        }
    });
    return downloadDic;
}


+ (XYDownloadModel *)getDownloadModelWithDic:(NSDictionary *)dic
{
    NSString * key = dic[video_ev_videourl];
    if ([key isKindOfClass:NSString.class]) {
        return [XYDownloadNetTool getDownloadDic][key];
    }
    return nil;
}
+ (XYDownloadModel *)getDownloadModelWithKey:(NSString *)key
{
    return [XYDownloadNetTool getDownloadDic][key];
}

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
{
    
    NSMutableDictionary * downloadDic = [XYDownloadNetTool getDownloadDic];
    
    XYDownloadModel * model = downloadDic[aUrl];
    if (!model) {
        model = [XYDownloadModel createDownLoadModeWithUrl:aUrl];
    } else {
        if (model.isFinish) {
            finish ? finish() : 0;
            return nil;
        }
    }
    
    
    
    NSData * data = [NSData dataWithContentsOfURL:model.fialLocalURL];
    if (data) {
        return [XYDownloadNetTool downloadFileData:data url:aUrl speed:speed finish:finish];
    }

    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    
    [manager setTaskDidCompleteBlock:^(NSURLSession * _Nonnull session, NSURLSessionTask * _Nonnull task, NSError * _Nullable error) {
        // **** 下载出错，缓存已经下载的数据到指定的缓存文件中
        NSData *resumeData = error.userInfo[NSURLSessionDownloadTaskResumeData];
        if (resumeData.length > 0) {
            NSURL * URL = [XYDownloadNetTool getFialDownloadURLWith:aUrl];
            BOOL success = [resumeData writeToFile:[XYDownloadNetTool getPathWithURL:URL] atomically:YES];
            NSLog(@"all  success--- %d",success);
        }
    }];
    

    NSURL *URL = [NSURL URLWithString:[aUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];

    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSString * download = [XYDownloadNetTool getDownloadSpeedWithProgress:downloadProgress];
        speed ? speed(download) : 0;
        model.downloadSpeed = download;
        model.speed = downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        return model.localURL;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
        
        if ([filePath.description isEqualToString:@"(null)"] || !filePath) {
            return ;
        }
        finish ? finish(filePath.absoluteString) : 0;
        model.isFinish = YES;
        [XYDownloadNetTool saveToDiskOfDownloadDic];
    }];
    //开始
    [downloadTask resume];
    
    
    
    
    model.downloadTask = downloadTask;
    model.httpUrl = aUrl;
    
    
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
    
    NSMutableDictionary * downloadDic = [XYDownloadNetTool getDownloadDic];
    
    XYDownloadModel * model = downloadDic[url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    [manager setTaskDidCompleteBlock:^(NSURLSession * _Nonnull session, NSURLSessionTask * _Nonnull task, NSError * _Nullable error) {
        // **** 下载出错，缓存已经下载的数据到指定的缓存文件中
        NSData *resumeData = error.userInfo[NSURLSessionDownloadTaskResumeData];
        if (resumeData.length > 0) {
            NSURL * URL = [XYDownloadNetTool getFialDownloadURLWith:url];
            BOOL success = [resumeData writeToFile:[XYDownloadNetTool getPathWithURL:URL] atomically:YES];
            NSLog(@"fail success--- %d",success);
        }
    }];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithResumeData:data progress:^(NSProgress * _Nonnull downloadProgress) {
        NSString * download = [XYDownloadNetTool getDownloadSpeedWithProgress:downloadProgress];
        speed ? speed(download) : 0;
        model.downloadSpeed = download;
        model.speed = downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return model.localURL;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if ([filePath.description isEqualToString:@"(null)"] || !filePath) {
            return ;
        }
        finish ? finish(filePath.absoluteString) : 0;
        model.isFinish = YES;
        [XYDownloadNetTool saveToDiskOfDownloadDic];
    }];
    
       //开始
    [downloadTask resume];
    

    return downloadTask;
}




/**
 *  暂停
 *  会保存到本地
 *  @param downloadTask downloadTask description
 */
+ (void)suspendWithDownloadTask:(NSURLSessionDownloadTask *)downloadTask url:(NSString *)url
{
    [downloadTask suspend];
}






////////////////////////////////// 没下载完的 ////////////////////////////////////////


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

//计算 进度
+ (NSString *)getDownloadSpeedWithProgress:(NSProgress *)downloadProgress
{
    return [NSString stringWithFormat:@"%.2fM/%.2fM",downloadProgress.completedUnitCount / 1000000.0,downloadProgress.totalUnitCount / 1000000.0];
}


//获取 完成 视频地址
+ (NSURL *)getDownloadURLWith:(NSString *)url
{
    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    documentsDirectoryURL = [documentsDirectoryURL URLByAppendingPathComponent:documents_video_path];
    NSURL * newURL = [documentsDirectoryURL URLByAppendingPathComponent:[XYDownloadNetTool getStringWithUrl:url]];
   
    return newURL;
}


//获取 未完成 视频地址
+ (NSURL *)getFialDownloadURLWith:(NSString *)url
{
    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    documentsDirectoryURL = [documentsDirectoryURL URLByAppendingPathComponent:documents_video_path];
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




//////////////////////////////////// 对下载队列的操作 //////////////////////////////////////

+ (void)saveToDiskOfDownloadDic
{
    NSMutableDictionary * dic = [XYDownloadNetTool getDownloadDic];
    
    
    NSMutableDictionary * newDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    
    for (NSString * key in dic.allKeys) {
        XYDownloadModel * model = newDic[key];
        
        NSMutableData *data = [[NSMutableData alloc] init];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [archiver encodeObject:model forKey:archiver_key];
        [archiver finishEncoding];
         
        [newDic setValue:data forKey:key];
    }
    NSLog(@"dic => %@",newDic);
    BOOL success = [newDic writeToFile:[XYDownloadNetTool getDownloadDicPath] atomically:NO];
    
    
    if (success) {
        NSLog(@" download dic save success!!!");
    } else {
        NSLog(@" download dic save fail !!!");
    }
}


+ (NSMutableDictionary *)getDownloadDicWithDisk
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithContentsOfFile:[XYDownloadNetTool getDownloadDicPath]];
    
    for (NSString * key in dic.allKeys) {
        
        NSData * data = dic[key];
        
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        
        XYDownloadModel * model = [unarchiver decodeObjectForKey:archiver_key];
        [unarchiver finishDecoding];
        
        [dic setValue:model forKey:key];
    }
    return dic;
}


/**
 * 获取队列路径
 */
+ (NSString *)getDownloadDicPath
{
    NSString * documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString * directory = [documents stringByAppendingPathComponent:documents_video_path];
    documents = [directory stringByAppendingPathComponent:@"downloadDic.data"];
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:documents]) {
        
        if(![fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil] ) {
            NSLog(@"create directory fail");
            NSLog(@"Error was code: %d - message: %s", errno, strerror(errno));
            return documents;
        }
        NSLog(@"create directory success");
        if (![fileManager createFileAtPath:documents contents:[NSData data] attributes:nil]) {
            NSLog(@"create File Fail");
            NSLog(@"Error was code: %d - message: %s", errno, strerror(errno));
            return documents;
        }
        NSLog(@"create file success");
    }
    
    return documents;
}
@end
