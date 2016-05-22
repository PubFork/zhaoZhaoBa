//
//  Keys.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#ifndef Keys_h
#define Keys_h


#pragma mark -------------------------------------------------------
#pragma mark UM
/**
 *  UM Key
 */
static NSString * um_key = @"572dab9d67e58edab0001ebf";

static NSString * shareSina_AppName = @"@找找吧";






#pragma mark -------------------------------------------------------
#pragma mark 本地


/**
 *  定位的城市名字
 */
static NSString * kLocationCityName_Key = @"kLocationCityName_Key";

/**
 *  纬度
 */
static NSString * kLocation_latitude = @"latitude";


/**
 *  经度
 */
static NSString * kLocation_longitude = @"longitude";


//////////////////////////////////我的 VC////////////////////////////////////////

/**
 *  图片地址
 */
static NSString * my_vc_custom_imageUrl = @"my_vc_custom_imageUrl"; //图片
/**
 *  名称
 */
static NSString * my_vc_custom_title    = @"my_vc_custom_title"; //名称
/**
 *  提示
 */
static NSString * my_vc_custom_prompt   = @"my_vc_custom_prompt"; //提示


/**
 *  分享 cell 上面的图片
 */
static NSString * my_shareGetMoney_vc_shareCell_image = @"my_shareGetMoney_vc_shareCell_image";

/**
 *  分享 cell 上面的文字
 */
static NSString * my_shareGetMoney_vc_shareCell_title = @"my_shareGetMoney_vc_shareCell_title";



#pragma mark -------------------------------------------------------
#pragma mark 网络数据 key

//////////////////////////////////轮播图////////////////////////////////////////

/**
 *  轮播图  图片地址
 */
static NSString * carousePicture_imageUrl = @"imgurl";

/**
 *  轮播图  链接地址
 */
static NSString * carousePicture_link = @"link";


//////////////////////////////////驾校 ////////////////////////////////////////

/**
 *  驾校名字
 */
static NSString * driverSchool_schoolname = @"schoolname";


////////////////////////////////// 必知晓 ////////////////////////////////////////

/**
 *  必知晓 ID
 */
static NSString * mustKown_mk_id = @"mk_id";




/**
 *  必知晓 标题
 */
static NSString * mustKown_mk_Title = @"mk_Title";

/**
 *  必知晓 图片
 */
static NSString * mustKnow_mk_img   = @"mk_img";



/**
 *  必知晓 发布时间
 */
static NSString * mustKnow_mk_time   = @"mk_time";

/**
 *  必知晓 内容
 */
static NSString * mustKnow_mk_content   = @"mk_content";

////////////////////////////////// 报名 ////////////////////////////////////////

/**
 *  车型 id
 */
static NSString * sign_up_ct_id = @"ct_id";

/**
 *  车型 名称
 */
static NSString * sign_up_ct_title = @"ct_title";

#endif /* Keys_h */
