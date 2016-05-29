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



//////////////////////////////////驾校列表类型////////////////////////////////////////


/**
 *  默认
 */
static NSString * driver_school_sort_type_default = @"默认排序";

/**
 *  价格
 */
static NSString * driver_school_sort_type_price = @"价格";

/**
 *  距离
 */
static NSString * driver_school_sort_type_distance = @"距离";

/**
 *  报名人数
 */
static NSString * driver_school_sort_type_sign_up_number = @"报名人数";

/**
 *  服务
 */
static NSString * driver_school_sort_type_service = @"服务";

/**
 *  车辆
 */
static NSString * driver_school_sort_type_car = @"车辆";

/**
 *  环境
 */
static NSString * driver_school_sort_type_environment = @"环境";





/**
 *  默认
 */
static NSString * DriverSchoolSortType_default = @"default";

/**
 *  推荐
 */
static NSString * DriverSchoolSortType_recommend = @"recommend";

/**
 *  价格
 */
static NSString * DriverSchoolSortType_price = @"price";

/**
 *  距离
 */
static NSString * DriverSchoolSortType_distance = @"distance";

/**
 *  报名人数
 */
static NSString * DriverSchoolSortType_signnumber = @"signnumber";


/**
 *  服务
 */
static NSString * DriverSchoolSortType_service = @"";

/**
 *  车辆
 */
static NSString * DriverSchoolSortType_car = @"";

/**
 *  环境
 */
static NSString * DriverSchoolSortType_environment = @"";

////////////////////////////////// 驾校 排序 ////////////////////////////////////////

/**
 *  驾校列表 升序
 */
static NSString * DrvierSchoolSortRule_asc = @"asc";

/**
 *  驾校列表 降序
 */
static NSString * DrvierSchoolSortRule_desc = @"desc";





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
static NSString * carousePicture_imageUrl = @"pl_img";

/**
 *  轮播图  链接地址
 */
static NSString * carousePicture_link = @"pl_link";


//////////////////////////////////驾校 ////////////////////////////////////////

/**
 *  星级
 */
static NSString * driverScholl_school_str = @"schoolstar";

/**
 *  驾校 id
 */
static NSString * driverSchool_school_id = @"schoolid";

/**
 *  驾校 费用
 */
static NSString * driverSchool_school_fee = @"fee";


/**
 *  驾校 距离
 */
static NSString * driverSchool_school_distance = @"distance";

/**
 *  驾校 报名人数
 */
static NSString * driverSchool_school_number = @"number";

/**
 *  驾校名字
 */
static NSString * driverSchool_schoolname = @"schoolname";

/**
 *  驾校 logo
 */
static NSString * driverSchool_school_logo = @"schoollogo";


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
