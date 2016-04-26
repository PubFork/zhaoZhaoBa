//
//  DispatchQueueManager.h
//  zhaoZhaoBa
//
//  Created by apple on 16/4/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef DispatchQueueManager_h
#define DispatchQueueManager_h

@interface DispatchQueueManager : NSObject

extern dispatch_queue_t getDefaultGlobalQueue();

@end
#endif