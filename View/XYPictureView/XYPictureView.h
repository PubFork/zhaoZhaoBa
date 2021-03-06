//
//  XYPictureView.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYAddActionImageView.h"


typedef void(^ClickImageBlock)(NSArray * imagesArray, NSInteger index);

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
    /**
     *  社区
     */
    XYPictureViewType_Community     = 0x21,
};


static NSInteger xYPictureView_BaseTag = 2312532;

@interface XYPictureView : UIView

/**
 *  赋值
 *
 *  @param type
 */
- (void)setImagesArray:(NSArray *)imagesArray type:(XYPictureViewType)type;

@property (nonatomic, strong)NSArray * allArray;
//别直接给这两个赋值
@property (nonatomic, assign)XYPictureViewType type;
@property (nonatomic, copy)NSArray * imagesArray;



@property (nonatomic, copy)ClickImageBlock clickImageBlock;
- (void)clickImageWithBlock:(ClickImageBlock)clickImageBlock;
@end
