//
//  NetworkAPI.h
//  MengTianXia
//
//  Created by zl on 2019/8/10.
//  Copyright © 2019 qttx. All rights reserved.
// 项目的网络请求接口统一放在此处

#import <Foundation/Foundation.h>
#import "HttpRequest.h"
#import "NetworkHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager : NSObject

/* -------- 登录注册 -------- */

/**
 注册
 
 @param phone 电话号码
 @param seccode 验证码
 @param password 密码
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)registerWithPhoneNumber:(NSString *)phone securityCode:(NSString *)seccode password:(NSString *)password success:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 登录

 @param phone 电话号码
 @param password 密码
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)loginWithPhoneNumber:(NSString *)phone password:(NSString *)password success:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 退出登录
 
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)logoutAndSuccess:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 获取用户的信息
 
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getUserInfoAndSuccess:(SuccessBlock)success failure:(FailureBlock)failure;


/* -------- 首页 -------- */

/// 搜索功能-热门搜索关键词
/// @param pageNo yema
/// @param pageSize 单页数量
/// @param type 类型: 1-新房 2-二手房
/// @param success 成功回调
/// @param failure 失败回调
+ (void)getHotKeywordsWithPageNumber:(NSInteger)pageNo pageSize:(NSInteger)pageSize type:(NSString *)type success:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 首页热门主题
 
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getHotThemeAndSuccess:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 首页好房推荐
 
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getRecommendHouseDataAndSuccess:(SuccessBlock)success failure:(FailureBlock)failure;


/* -------- 新房 -------- */

/**
 条件筛选楼盘列表

 @param pageNo 页码
 @param pageSize 每页条数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getNewHouseResidenceListWithPageNumber:(NSUInteger)pageNo pageSize:(NSUInteger)pageSize name:(NSString *)name province:(NSString *)province city:(NSString *)city town:(NSString *)town tradeArea:(NSString *)tradeArea roomNum: (NSString *)roomNum totalPrice:(NSString *)totalPrice unitPrice:(NSString *)unitPrice latitude:(NSString *)latitude longitude:(NSString *)longitude distance:(NSString *)distance orderBy:(NSString *)orderBy filterDict:(NSDictionary *)filterDict success:(SuccessBlock)success failure:(FailureBlock)failure;

/// 获取楼盘筛选的筛选条件字段
/// @param success 成功回调
/// @param failure 失败回调
+ (void)getAllResidenceFilterDictListAndSuccess:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 楼盘详情

 @param resId 楼盘ID
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getNewHouseResidenceDetailWithID:(NSString *)resId success:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 楼盘动态列表

 @param pageNo 页码
 @param pageSize 每页数量
 @param propertyId 楼盘ID
 @param newsType 动态类型 3-战报，4-项目动态
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getPropertyNewsListWithPageNumber:(NSInteger)pageNo pageSize:(NSInteger)pageSize propertyId:(NSString *)propertyId newsType:(NSString *)newsType success:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 获取楼盘动态详情

 @param Id 楼盘动态id
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getPropertyNewsDetailWithNewsId:(NSString *)Id success:(SuccessBlock)success failure:(FailureBlock)failure;


/**
 获取楼盘动态数量

 @param propertyId 楼盘ID
 @param newsType 动态类型 3-战报，4-项目动态
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getPropertyNewsCountWithPropertyId:(NSString *)propertyId newsType:(NSString *)newsType success:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 发布找房需求

 @param intentId 需求主键，存在主键则修改，不存在新增
 @param room 卧室数量, 多选用逗号隔开
 @param priceMin 首付最小价格
 @param priceMax 首付最高价格
 @param intentionType 1购房意向2卖房委托3租房意向
 @param city 所在城市名称
 @param town 区县拼接字符串ID
 @param position 意向位置，商圈ID拼接字符串
 @param userTel 用户手机号
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)publishSearchHouseIntentionWithIntentId:(NSString *)intentId roomCount:(NSString *)room minPrice:(NSInteger)priceMin maxPrice:(NSInteger)priceMax intentionType:(NSString *)intentionType cityName:(NSString *)city towns:(NSString *)town position:(NSString *)position userTelphoneNumber:(NSString *)userTel success:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 获取用户的找房需求ID

 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getUserSearchHouseIntentionAndSuccess:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 根据用户找房需求推荐楼盘

 @param Id 意向ID
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)searchHouseIntentionRecommendWithId:(NSString *)Id success:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 获取楼盘户型数量

 @param residenceId 楼盘ID
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getResidencceHouseLayoutCountWithId:(NSString *)residenceId success:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 优选顾问列表

 @param pageNo 当前页
 @param pageSize 当前页展示数量
 @param username 用户账号
 @param nickname 昵称
 @param phone 手机号
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getPreferredConsultListWithPageNumber:(NSInteger)pageNo pageSize:(NSInteger)pageSize username:(NSString *)username nickname:(NSString *)nickname phone:(NSString *)phone success:(SuccessBlock)success failure:(FailureBlock)failure;

/**
  优选顾问列表数量

  @param username 用户账号
  @param nickname 昵称
  @param phone 手机号
  @param success 成功回调
  @param failure 失败回调
  */
+ (void)getPreferredConsultListCountWithUsername:(NSString *)username nickname:(NSString *)nickname phone:(NSString *)phone success:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 猜你喜欢

 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getAssumeLikeAndSuccess:(SuccessBlock)success failure:(FailureBlock)failure;


/* -------- 房贷计算器 -------- */

/**
 等额本金:商业贷款/公积金贷款

 @param princial 贷款总额
 @param years 贷款期限（年）
 @param rate 贷款利率
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)calculateEqualPrincipalWithPrincial:(NSString *)princial years:(NSString *)years rate:(NSString *)rate success:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 等额本息:商业贷款/公积金贷款
 
 @param princial 贷款总额
 @param years 贷款期限（年）
 @param rate 贷款利率
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)calculateEqualPrincipalAndInterestWithPrincial:(NSString *)princial years:(NSString *)years rate:(NSString *)rate success:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 等额本金:组合贷款
 
 @param yearsCommercial 商贷贷款期限（年）
 @param principalCommercial 商业贷款总额
 @param rateCommercial 商业贷款利率
 @yearsAccumulation 公积金贷贷款期限（年）
 @param principalAccumulation 公积金贷款总额
 @param rateAccumulation 公积金贷款利率
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)calculateEqualPrincipalForCombinationWithYearsCommercial:(NSString *)yearsCommercial principalCommercial:(NSString *)principalCommercial rateCommercial:(NSString *)rateCommercial yearsAccumulation:(NSString *)yearsAccumulation principalAccumulation:(NSString *)principalAccumulation rateAccumulation:(NSString *)rateAccumulation success:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 等额本息:组合贷款
 
 @param yearsCommercial 商贷贷款期限（年）
 @param principalCommercial 商业贷款总额
 @param rateCommercial 商业贷款利率
 @yearsAccumulation 公积金贷贷款期限（年）
 @param principalAccumulation 公积金贷款总额
 @param rateAccumulation 公积金贷款利率
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)calculateEqualPrincipalAndInterestForCombinationWithYearsCommercial:(NSString *)yearsCommercial principalCommercial:(NSString *)principalCommercial rateCommercial:(NSString *)rateCommercial yearsAccumulation:(NSString *)yearsAccumulation principalAccumulation:(NSString *)principalAccumulation rateAccumulation:(NSString *)rateAccumulation success:(SuccessBlock)success failure:(FailureBlock)failure;

/* -------- 个人中心 -------- */

/**
 我的关注
 
 @param pageNo 页码
 @param pageSize 每页数量
 @param type 关注类型       1-新房 2二手房 3-租房 4-小区
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getMyAttentionWithPageNumber:(NSUInteger)pageNo pageSize:(NSUInteger)pageSize attentionType:(NSUInteger)type success:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 获取我的关注数量

 @param type 类型     1-新房 2二手房 3-租房 4-小区
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getMyAttentionNumberWithType:(NSUInteger)type success:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 添加关注

 @param type 关注对象类型: 1-新房 2二手房 3-租房 4-小区
 @param objId 关注对象ID
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)addAttentionWithType:(NSInteger)type objectId:(NSString *)objId success:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 取消关注

 @param type 关注对象类型: 1-新房 2二手房 3-租房 4-小区
 @param objId 关注对象ID
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)deleteAttentionWithType:(NSInteger)type objectId:(NSString *)objId success:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 判断是否关注    0未关注 1-已关注

 @param type 关注对象类型: 1-新房 2二手房 3-租房 4-小区
 @param objId 关注对象ID
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getAttentionStatusType:(NSInteger)type objectId:(NSString *)objId success:(SuccessBlock)success failure:(FailureBlock)failure;

/// 获取用户楼盘的订阅状态
/// @param success 成功回调
/// @param failure 失败回调
+ (void)getSubscribeStatusAndSuccess:(SuccessBlock)success failure:(FailureBlock)failure;

/// 订阅或者取消订阅
/// @param phoneNum 电话号码
/// @param state 订阅状态（1订阅,2取消订阅）
/// @param success 成功回调
/// @param failure 失败回调
+ (void)subscribeResicendeWithPhoneNumber:(NSString *)phoneNum state:(NSInteger)state success:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 浏览记录

 @param pageNo 页码
 @param pageSize 每页数量
 @param type 类型-1:新房；2-二手房
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getBrowseHistoryWithPageNumber:(NSUInteger)pageNo pageSize:(NSUInteger)pageSize historyType:(NSUInteger)type success:(SuccessBlock)success failure:(FailureBlock)failure;


/* -------- 查询接口 -------- */

/**
 根据上级地区Code查询地区列表

 @param pCode 上级地区code
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getAreaListDataWithParentCode:(NSString *)pCode success:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 根据上级地区Code查询地区列表,获取下级所有数据
 
 @param pCode 上级地区code
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getAllAreaListDataWithParentCode:(NSString *)pCode success:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 根据主键获取地区列表

 @param ID 地区ID
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getAreaListDataWithAreaID:(NSString *)ID success:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 数据字典查询
 后面拼接要查询的dictType, 即可查询相关数据
例如: 查询 房间卧室数量 传入 ROOM_NUM
 
 @param dictType 字典类型关键字
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getDictWithDictType:(NSString *)dictType success:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 获取区域新房数量
 
 @param cityCode 城市编码
 @param salesStatus 是否在售 0-否，1-是
 @param openTime 新开盘 0-否，1-是
 @param roomNum 房型(室数目)
 @param minTotalPrice 最低总价
 @param maxTotalPrice 最高总价
 @param priceRange 价格区间
 @param ownership 权属类型(多选之间用英文逗号隔开)
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getAreaNewHouseNumWithCityCode:(NSString *)cityCode salesStatus:(NSString *)salesStatus openTime:(NSString *)openTime roomNum:(NSString *)roomNum minTotalPrice:(NSString *)minTotalPrice maxTotalPrice:(NSString *)maxTotalPrice priceRange:(NSString *)priceRange ownership:(NSString *)ownership success:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 获取区域新房列表
 
 @param cityCode 城市编码
 @param salesStatus 是否在售 0-否，1-是
 @param openTime 新开盘 0-否，1-是
 @param roomNum 房型(室数目)
 @param minTotalPrice 最低总价
 @param maxTotalPrice 最高总价
 @param priceRange 价格区间
 @param ownership 权属类型(多选之间用英文逗号隔开)
 @param success 成功回调
 @param failure 失败回调
 */
//+ (void)getAreaNewHouseNumWithCityCode:(NSString *)cityCode salesStatus:(NSString *)salesStatus openTime:(NSString *)openTime roomNum:(NSString *)roomNum minTotalPrice:(NSString *)minTotalPrice maxTotalPrice:(NSString *)maxTotalPrice priceRange:(NSString *)priceRange ownership:(NSString *)ownership success:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 获取地图找房筛选条件
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getHouseByMapDictListWithSuccess:(SuccessBlock)success failure:(FailureBlock)failure;

@end

NS_ASSUME_NONNULL_END
