//
//  XYAddCommunityUpdatePictureView.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYAddActionImageView.h"



typedef void(^clickAddImageViewBlock)();
typedef void(^clickImageViewBlock)(UIImageView * view);


@interface XYAddCommunityUpdatePictureView : UIView
@property (nonatomic, strong)XYAddActionImageView * addImageView;


@property (nonatomic, copy)clickAddImageViewBlock clickAddImageViewBlock;
- (void)clickAddImageViewWithBlock:(clickAddImageViewBlock)block;


@property (nonatomic, copy)clickImageViewBlock clickImageViewBlock;
- (void)clickImageViewWithBlock:(clickImageViewBlock)block;



- (void)addImageViewWithImage:(UIImage *)image;
- (void)removeImageWithImageView:(UIImageView *)imageView;

@end
