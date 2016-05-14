//
//  XYPictureView.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYAddActionImageView.h"



/**
 *  图片控件类型
 */
typedef NS_ENUM(NSInteger, XYPictureViewType) {
    /**
     *  驾校详情
     */
    XYPictureViewType_DriverSchool  = 0x01,
    /**
     *  新手上路
     */
    XYPictureViewType_NewDriver     = 0x11,
};


static NSInteger xYPictureView_BaseTag = 2312532;

@interface XYPictureView : UIView

/**
 *  赋值
 *
 *  @param type
 */
- (void)setImagesArray:(NSArray *)imagesArray type:(XYPictureViewType)type;

//别直接给这两个赋值
@property (nonatomic, assign)XYPictureViewType type;
@property (nonatomic, copy)NSArray * imagesArray;
@end
