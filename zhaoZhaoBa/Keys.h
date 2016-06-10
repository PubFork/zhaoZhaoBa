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


#pragma mark -------------------------------------------------------
#pragma mark 驾校列表类型

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


#pragma mark -------------------------------------------------------
#pragma mark 驾校 & 教练 排序

////////////////////////////////// 驾校 & 教练 排序 ////////////////////////////////////////

/**
 *  驾校列表 升序
 */
static NSString * DrvierSchoolSortRule_asc = @"asc";

/**
 *  驾校列表 降序
 */
static NSString * DrvierSchoolSortRule_desc = @"desc";


#pragma mark -------------------------------------------------------
#pragma mark 教练列表 类型

////////////////////////////////// 教练列表 类型 ////////////////////////////////////////


/**
 *  默认
 */
static NSString * coach_list_chinese_type_default = @"好评";

/**
 *  点赞次数
 */
static NSString * coach_list_chinese_type_praisenumber = @"点赞次数";

/**
 *  最近教练
 */
static NSString * coach_list_chinese_type_distance = @"最近教练";




/**
 *  默认
 */
static NSString * coach_list_type_default = @"star";

/**
 *  点赞次数
 */
static NSString * coach_list_type_praisenumber = @"praisenumber";

/**
 *  距离
 */
static NSString * coach_list_type_distance = @"distance";


#pragma mark -------------------------------------------------------
#pragma mark 我的 VC

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


#pragma mark -------------------------------------------------------
#pragma mark 用户数据
////////////////////////////////// 用户数据 ////////////////////////////////////////

static NSString * user_info_userID = @"";


#pragma mark -------------------------------------------------------
#pragma mark 轮播图

//////////////////////////////////轮播图////////////////////////////////////////

/**
 *  轮播图  图片地址
 */
static NSString * carousePicture_imageUrl = @"pl_img";

/**
 *  轮播图  链接地址
 */
static NSString * carousePicture_link = @"pl_link";


#pragma mark -------------------------------------------------------
#pragma mark 驾校

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


/**
 *  图片列表
 */
static NSString * driverSchool_detail_imglist = @"imglist";

/**
 *  最后交易时间
 */
static NSString * driverSchool_detail_lastordertime = @"lastordertime";

/**
 *  报名人数(半年交易人数？)
 */
static NSString * driverSchool_detail_transnumber = @"transnumber";
/**
 *  总交易额
 */

static NSString * driverSchool_detail_transamount = @"transamount";


/**
 *  优惠价
 */
static NSString * driverSchool_detail_discountprice = @"discountprice";

/**
 *  评论
 */
static NSString * driverSchool_detail_comment = @"comment";

/**
 *  教练列表
 */
static NSString * driverSchool_detail_coachlist = @"coachlist";


/**
 *  驾校 简介
 */
static NSString * driverSchool_detail_profile = @"profile";

/**
 *  驾校 特色
 */
static NSString * driverSchool_detail_characteristic = @"characteristic";

/**
 *  驾校 说明
 */
static NSString * driverSchool_detail_explain = @"explain";


#pragma mark -------------------------------------------------------
#pragma mark 必知晓

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


#pragma mark -------------------------------------------------------
#pragma mark 新手上路
////////////////////////////////// 新手上路 ////////////////////////////////////////

/**
 *  id
 */
static NSString * novice_of_road_nr_id = @"nr_id";

/**
 *  标题
 */
static NSString * novice_of_road_nr_Title = @"nr_Title";

/**
 *  图片
 */
static NSString * novice_of_road_nr_img = @"nr_img";

/**
 *  内容
 */
static NSString * novice_of_road_nr_content = @"nr_content";

/**
 *  时间
 */
static NSString * novice_of_road_nr_time = @"nr_time";


#pragma mark -------------------------------------------------------
#pragma mark 车展

////////////////////////////////// 车展 ////////////////////////////////////////

/**
 *  车展ID
 */
static NSString * car_show_typeid = @"typeid";

/**
 *  车展 图片
 */
static NSString * car_show_logo = @"logo";

/**
 *  车展 名字
 */
static NSString * car_show_typename = @"typename";

/**
 *  车展型号  列表 key
 */
static NSString * car_show_list_key = @"carlist";

/**
 *  车展 型号 ID
 */
static NSString * car_show_type_list_ID = @"carid";

/**
 *  车展型号 图片
 */
static NSString * car_show_type_list_carimg = @"carimg";

/**
 *  车展 型号 名字
 */
static NSString * car_show_type_list_cartitle = @"cartitle";

/**
 *  车展 型号 价格区间
 */
static NSString * car_show_type_list_pricerange = @"pricerange";



#pragma mark -------------------------------------------------------
#pragma mark 报名

////////////////////////////////// 报名 ////////////////////////////////////////

/**
 *  车型 id
 */
static NSString * sign_up_ct_id = @"ct_id";

/**
 *  车型 名称
 */
static NSString * sign_up_ct_title = @"ct_title";



#pragma mark -------------------------------------------------------
#pragma mark 教练

////////////////////////////////// 教练 ////////////////////////////////////////


/**
 *  教练 ID
 */
static NSString * coach_c_id = @"c_id";

/**
 *  驾龄
 */
static NSString * coach_c_driving = @"c_driving";

/**
 *  通过率
 */
static NSString * coach_passrate = @"passrate";

/**
 *  教练的驾校ID
 */
static NSString * coach_c_dsid = @"c_dsid";

/**
 *  教练 图片
 */
static NSString * coach_c_img = @"c_img";

/**
 *  教练 姓名
 */
static NSString * coach_c_name = @"c_name";

/**
 *  电话
 */
static NSString * coach_c_phone = @"c_phone";

/**
 *  简介
 */
static NSString * coach_c_profile = @"c_profile";

/**
 *  教练 历史
 */
static NSString * coach_c_praiseNubmer = @"c_praiseNubmer";

/**
 *  教练 类型
 */
static NSString * coach_c_type = @"c_type";

/**
 *  教练 喜欢
 */
static NSString * coach_like = @"like";

/**
 *  教练 不喜欢
 */
static NSString * coach_unlike = @"unlike";



#pragma mark -------------------------------------------------------
#pragma mark 商城
////////////////////////////////// 商城 ////////////////////////////////////////

/**
 *  简介
 */
static NSString * shopping_sm_brief = @"sm_brief";

/**
 *  商城 ID
 */
static NSString * shopping_sm_id = @"sm_id";

/**
 *  商城 图片
 */
static NSString * shopping_sm_img = @"sm_img";

/**
 *  商城 价格
 */
static NSString * shopping_sm_price = @"sm_price";

/**
 *  商城 标题
 */
static NSString * shopping_sm_title = @"sm_title";



#pragma mark -------------------------------------------------------
#pragma mark 社区汇
////////////////////////////////// 社区汇 ////////////////////////////////////////

/**
 *  社区id
 */
static NSString * community_communityid = @"communityid";

/**
 *  发布内容
 */
static NSString * community_content = @"content";

/**
 *  发布时间
 */
static NSString * community_time = @"time";

/**
 *  用户头像
 */
static NSString * community_userimg = @"userimg";

/**
 *  用户名字
 */
static NSString * community_username = @"username";

/**
 *  点赞数
 */
static NSString * community_praise_number = @"star";

/**
 *  回复人数
 */
static NSString * community_replynumber = @"replynumber";

#pragma mark -------------------------------------------------------
#pragma mark 评论

////////////////////////////////// 评论 ////////////////////////////////////////

/**
 *  评论id
 */
static NSString * comment_pdid = @"pdid";

/**
 *  评论时间
 */
static NSString * comment_time = @"time";

/**
 *  评论内容
 */
static NSString * comment_content = @"content";

/**
 *  评论 点赞数
 */
static NSString * comment_praisepoint = @"praisepoint";

/**
 *  评论 用户名字
 */
static NSString * comment_username = @"username";

/**
 *  评论 用户头像
 */
static NSString * comment_userimg = @"userimg";







#endif /* Keys_h */
