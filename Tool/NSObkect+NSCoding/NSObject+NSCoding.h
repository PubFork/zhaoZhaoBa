//
//  LinerViewController.h
//  LvCheng
//
//  Created by 中科创奇 on 15/4/26.
//  Copyright (c) 2015年 中科创奇. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (NSCoding)

- (void)autoEncodeWithCoder: (NSCoder *)coder;
- (void)autoDecode:(NSCoder *)coder;
- (NSDictionary *)properties;

@end
