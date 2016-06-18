//
//  XYUpdateNetTool.h
//  zhaoZhaoBa
//
//  Created by apple on 16/6/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYNetTool.h"
NS_ASSUME_NONNULL_BEGIN

@interface XYUpdateNetTool : XYNetTool

+ (void)uploadWithImageData:(NSData *)imageData
                    success:(void(^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))success
                    failure:(void(^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;
@end
NS_ASSUME_NONNULL_END