//
//  XYUpdateNetTool.m
//  zhaoZhaoBa
//
//  Created by apple on 16/6/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYUpdateNetTool.h"

@implementation XYUpdateNetTool


+ (void)uploadWithImageData:(NSData *)imageData
                    success:(void(^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))success
                    failure:(void(^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure
{
    [[self.class getDefaultManager] POST:@"" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:success failure:failure];
    
}

@end
