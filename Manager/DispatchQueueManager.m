//
//  DispatchQueueManager.m
//  zhaoZhaoBa
//
//  Created by apple on 16/4/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DispatchQueueManager.h"

@implementation DispatchQueueManager
dispatch_queue_t getDefaultGlobalQueue()
{
    return dispatch_get_global_queue(0, 0);
}
@end
