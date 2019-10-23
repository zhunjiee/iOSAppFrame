//
//  NetworkHeader.h
//  MengTianXia
//
//  Created by zl on 2019/8/10.
//  Copyright © 2019 qttx. All rights reserved.
//

#ifndef NetworkHeader_h
#define NetworkHeader_h

// 正式上线地址
//#define API_Base_Url @"http://47.104.185.110:8080"
// 开发测试地址
#define API_Base_Url @"https://lumeng.qdunzi.com/api"
//#define API_Base_Url @"http://192.168.254.52:8080/api"

/* -------- 登录注册 -------- */
// 注册
#define API_Register @"/api/user/pub/register"
// 登录
#define API_Login @"/api/user/pub/login"
// 退出登录
#define API_Logout @"/api/user/pub/logout"
// 获取用户信息
#define API_GetUserInfo @"/api/user/getUserInfo"


/* -------- 首页 -------- */
// 搜索热门关键词
#define API_HotKeywords @"/api/hotkeyWords"
// 首页热门主题
#define API_HotTheme @"/api/hotthemeConf"
// 首页好房推荐 - 新房
#define API_RecommendResidence @"/api/index/getRecommendResidence"
// 首页好房推荐 - 二手房/租房
#define API_RecommendHouse @"/api/index/getRecommendHouse"


/* -------- 新房 -------- */
// 全部楼盘/ 条件筛选楼盘信息
#define API_ResidenceList @"/api/residence/residenceList"
// 筛选条件
#define API_ResidenceFilterDictList @"/api/residence/allResidenceDictList"
// 楼盘详情
#define API_ResidenceDetail @"/api/residence/getResidenceForApp"
// post: 发布找房需求
// get:获取用户的找房需求的信息
// api/{id}: 根据找房需求查看楼盘
#define API_Intention @"/api/intention"
// 户型数量
#define API_HouseLayoutCount @"/api/houseLayout/listSize"
// 楼盘动态
#define API_PropertyNews @"/api/propertyNews"
// 楼盘动态列表
#define API_PropertyNewsCount @"/api/propertyNews/listSize"
// 猜你喜欢
#define API_AssumeLike @"/api/residence/assumeLike"
// 优选顾问
#define API_PerferredConsult @"/api/sysUser/preferredConsultantList"
// 优选顾问数量
#define API_PerferredConsultCount @"/api/sysUser/preferredConsultantListCount"
// 地图找房 获取对应市的新房房源
#define API_GetAreaNewHouseCount @"/api/getResidenceByMap/showAreaResidence"
// 地图找房 获取新房地图找房查询条件
#define API_GetHouseByMapDictList @"/api/getResidenceByMap/getHouseByMapDictList"


/* -------- 房贷计算器 -------- */
// 等额本金:商业贷款/公积金贷款
#define API_CalculateEqualPrincipal @"/api/loanCalculator/calculateEqualPrincipal"
// 等额本息:商业贷款/公积金贷款
#define API_CalculateEqualPrincipalAndInterest @"/api/loanCalculator/calculateEqualPrincipalAndInterest"
// 等额本金:组合贷款
#define API_CalculateEqualPrincipalForCombination @"/api/loanCalculator/calculateEqualPrincipalForCombination"
// 等额本息:组合贷款
#define API_CalculateEqualPrincipalAndInterestForCombination @"/api/loanCalculator/calculateEqualPrincipalAndInterestForCombination"


/* -------- 个人中心 -------- */
// 我的关注列表
#define API_MyAttention @"/api/myAttention/list"
// 我的关注数量
#define API_MyAttentionNum @"/api/myAttention/listSize"
// 添加关注
#define API_AddAttention @"/api/myAttention"
// 取消关注
#define API_DeleteAttention @"/api/myAttention/remove"
// 是否关注
#define API_IsAttention @"/api/myAttention/ifInMyAttention"
// 获取楼盘订阅状态
#define API_GetSubscribeState @"/api/subscribe/getSubscribeState"
// 订阅/取消订阅
#define API_Subscrice @"/api/subscribe"
// 浏览记录
#define API_BrowseHistory @"/api/borwseRecord"


/* -------- 查询接口 -------- */
// 获取地区列表
#define API_GetAreaList @"/api/area"
// 一次查询获取全部数据,不必再分级查询
#define API_GetAllAreaList @"/api/area/smallProgramArea"
// 字典操作
#define API_DictSearch @"/api/dict/getDictListByName"


#endif /* NetworkHeader_h */
