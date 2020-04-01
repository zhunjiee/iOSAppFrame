//
//  NetworkAPI.m
//  MengTianXia
//
//  Created by zl on 2019/8/10.
//  Copyright © 2019 qttx. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

/* -------- 登录注册 -------- */

+ (void)registerWithPhoneNumber:(NSString *)phone securityCode:(NSString *)seccode password:(NSString *)password success:(SuccessBlock)success failure:(FailureBlock)failure {
    if (BWStringIsEmpty(phone)) {
        failure(CustomErrorCode, @"请输入手机号");
        return;
    }
    if (BWStringIsEmpty(seccode)) {
        failure(CustomErrorCode, @"请输入验证码");
        return;
    }
    if (BWStringIsEmpty(password)) {
        failure(CustomErrorCode, @"请输入密码");
        return;
    }
    
    [MBProgressHUD showLoadingView];
    NSDictionary *params = @{
                             @"username" : phone,
                             @"code" : seccode,
                             @"password" : password
                             };
    [HttpRequest.sharedInstance postWithURLString:API_Register parameters:params success:^(id  _Nullable responseObject) {
        success(responseObject);
        [MBProgressHUD hideHUD];
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
        [MBProgressHUD showError:errorText];
    }];
}

+ (void)loginWithPhoneNumber:(NSString *)phone password:(NSString *)password success:(SuccessBlock)success failure:(FailureBlock)failure {
    if (BWStringIsEmpty(phone)) {
        failure(CustomErrorCode, @"请输入手机号");
        return;
    }
    if (BWStringIsEmpty(password)) {
        failure(CustomErrorCode, @"请输入密码");
        return;
    }
    
    [MBProgressHUD showLoadingView];
    NSDictionary *params = @{
                             @"username" : phone,
                             @"password" : password
                             };
    [HttpRequest.sharedInstance postWithURLString:API_Login parameters:params success:^(id  _Nullable responseObject) {
        success(responseObject);
        [MBProgressHUD hideHUD];
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
        [MBProgressHUD showError:errorText];
    }];
}

+ (void)logoutAndSuccess:(SuccessBlock)success failure:(FailureBlock)failure {
    [MBProgressHUD showLoadingMessage:@"正在退出登录..."];
    [HttpRequest.sharedInstance postWithURLString:API_Logout parameters:nil success:^(id  _Nullable responseObject) {
        success(responseObject);
        [MBProgressHUD hideHUD];
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
        [MBProgressHUD showError:errorText];
    }];
}

+ (void)getUserInfoAndSuccess:(SuccessBlock)success failure:(FailureBlock)failure {
    [MBProgressHUD showLoadingView];
    [HttpRequest.sharedInstance getWithURLString:API_GetUserInfo parameters:nil success:^(id  _Nullable responseObject) {
        success(responseObject);
        [MBProgressHUD hideHUD];
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
        [MBProgressHUD showError:errorText];
    }];
}


/* -------- 首页 -------- */

+ (void)getHotKeywordsWithPageNumber:(NSInteger)pageNo pageSize:(NSInteger)pageSize type:(NSString *)type success:(SuccessBlock)success failure:(FailureBlock)failure {
    NSDictionary *params = @{
        @"pageNo" : [NSNumber numberWithInteger:pageNo],
        @"pageSize" : [NSNumber numberWithInteger:pageSize],
        @"type" : type
    };
    [HttpRequest.sharedInstance getWithURLString:API_HotKeywords parameters:params success:^(id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
    }];
}

+ (void)getHotThemeAndSuccess:(SuccessBlock)success failure:(FailureBlock)failure {
    [MBProgressHUD showLoadingView];
    [HttpRequest.sharedInstance getWithURLString:API_HotTheme parameters:nil success:^(id  _Nullable responseObject) {
        success(responseObject);
        [MBProgressHUD hideHUD];
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
        [MBProgressHUD showError:errorText];
    }];
}

+ (void)getRecommendHouseDataAndSuccess:(SuccessBlock)success failure:(FailureBlock)failure {
    [HttpRequest.sharedInstance getWithURLString:API_RecommendResidence parameters:nil success:^(id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
    }];
}

/* -------- 新房 -------- */

+ (void)getNewHouseResidenceListWithPageNumber:(NSUInteger)pageNo pageSize:(NSUInteger)pageSize name:(NSString *)name province:(NSString *)province city:(NSString *)city town:(NSString *)town tradeArea:(NSString *)tradeArea roomNum: (NSString *)roomNum totalPrice:(NSString *)totalPrice unitPrice:(NSString *)unitPrice latitude:(NSString *)latitude longitude:(NSString *)longitude distance:(NSString *)distance orderBy:(NSString *)orderBy filterDict:(NSDictionary *)filterDict success:(SuccessBlock)success failure:(FailureBlock)failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:filterDict];
    [params setObject:[NSNumber numberWithUnsignedInteger:pageNo] forKey:@"pageNo"];
    [params setObject:[NSNumber numberWithUnsignedInteger:pageSize] forKey:@"pageSize"];
    [params setObject:BWCheckString(name) forKey:@"name"];
    [params setObject:BWCheckString(province) forKey:@"province"];
    [params setObject:BWCheckString(city) forKey:@"city"];
    [params setObject:BWCheckString(town) forKey:@"town"];
    [params setObject:BWCheckString(tradeArea) forKey:@"tradeArea"];
    [params setObject:BWCheckString(roomNum) forKey:@"roomNum"];
    [params setObject:BWCheckString(totalPrice) forKey:@"totalPrice"];
    [params setObject:BWCheckString(unitPrice) forKey:@"uintPrice"];
    [params setObject:BWCheckString(latitude) forKey:@"latitude"];
    [params setObject:BWCheckString(longitude) forKey:@"longitude"];
    [params setObject:BWCheckString(distance) forKey:@"distance"];
    [params setObject:BWCheckString(orderBy) forKey:@"orderBy"];
    
    [HttpRequest.sharedInstance getWithURLString:API_ResidenceList parameters:params success:^(id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
    }];
}

+ (void)getAllResidenceFilterDictListAndSuccess:(SuccessBlock)success failure:(FailureBlock)failure {
    [MBProgressHUD showLoadingView];
    [HttpRequest.sharedInstance getWithURLString:API_ResidenceFilterDictList parameters:nil success:^(id  _Nullable responseObject) {
        success(responseObject);
        [MBProgressHUD hideHUD];
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
        [MBProgressHUD showError:errorText];
    }];
}

+ (void)getNewHouseResidenceDetailWithID:(NSString *)resId success:(SuccessBlock)success failure:(FailureBlock)failure {
    [MBProgressHUD showLoadingView];
    NSDictionary *params = @{
                             @"id" : resId,
                             };
    
    [HttpRequest.sharedInstance getWithURLString:API_ResidenceDetail parameters:params success:^(id  _Nullable responseObject) {
        success(responseObject);
        [MBProgressHUD hideHUD];
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
        [MBProgressHUD showError:errorText];
    }];
}

+ (void)getPropertyNewsListWithPageNumber:(NSInteger)pageNo pageSize:(NSInteger)pageSize propertyId:(NSString *)propertyId newsType:(NSString *)newsType success:(SuccessBlock)success failure:(FailureBlock)failure {
    NSDictionary *params = @{
                             @"pageNo" : [NSNumber numberWithInteger:pageNo],
                             @"pageSize" : [NSNumber numberWithInteger:pageSize],
                             @"propertyId" : propertyId,
                             @"newsType" : newsType,
                             };
    
    [HttpRequest.sharedInstance getWithURLString:API_PropertyNews parameters:params success:^(id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
    }];
}

+ (void)getPropertyNewsDetailWithNewsId:(NSString *)Id success:(SuccessBlock)success failure:(FailureBlock)failure {
    [MBProgressHUD showLoadingView];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@", API_PropertyNews, Id];
    [HttpRequest.sharedInstance getWithURLString:urlString parameters:nil success:^(id  _Nullable responseObject) {
        success(responseObject);
        [MBProgressHUD hideHUD];
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
        [MBProgressHUD showError:errorText];
    }];
}

+ (void)getPropertyNewsCountWithPropertyId:(NSString *)propertyId newsType:(NSString *)newsType success:(SuccessBlock)success failure:(FailureBlock)failure {
    NSDictionary *params = @{
                             @"propertyId" : propertyId,
                             @"newsType" : newsType,
                             };
    [HttpRequest.sharedInstance getWithURLString:API_PropertyNewsCount parameters:params success:^(id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
    }];
}

+ (void)publishSearchHouseIntentionWithIntentId:(NSString *)intentId roomCount:(NSString *)room minPrice:(NSInteger)priceMin maxPrice:(NSInteger)priceMax intentionType:(NSString *)intentionType cityName:(NSString *)city towns:(NSString *)town position:(NSString *)position userTelphoneNumber:(NSString *)userTel success:(SuccessBlock)success failure:(FailureBlock)failure {
    if (BWStringIsEmpty(room)) {
        [MBProgressHUD showText:@"请选择户型"];
        return;
    }
    if (BWStringIsEmpty(userTel)) {
        [MBProgressHUD showText:@"请输入联系方式"];
        return;
    }
    [MBProgressHUD showLoadingView];
    NSDictionary *params = @{
                             @"id" : BWCheckString(intentId),
                             @"room" : room,
                             @"priceMin" : [NSNumber numberWithFloat:priceMin],
                             @"priceMax" : [NSNumber numberWithFloat:priceMax],
                             @"intentionType" : intentionType,
                             @"city" : city,
                             @"town" : town,
                             @"pos" : position,
                             @"userTel" : userTel,
                             };
    
    [HttpRequest.sharedInstance postWithURLString:API_Intention parameters:params success:^(id  _Nullable responseObject) {
        success(responseObject);
        [MBProgressHUD hideHUD];
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
        [MBProgressHUD showError:errorText];
    }];
}

+ (void)getUserSearchHouseIntentionAndSuccess:(SuccessBlock)success failure:(FailureBlock)failure {
    [MBProgressHUD showLoadingView];
    [HttpRequest.sharedInstance getWithURLString:API_Intention parameters:nil success:^(id  _Nullable responseObject) {
        success(responseObject);
        [MBProgressHUD hideHUD];
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
        [MBProgressHUD showError:errorText];
    }];
}

+ (void)searchHouseIntentionRecommendWithId:(NSString *)Id success:(SuccessBlock)success failure:(FailureBlock)failure {
    [MBProgressHUD showLoadingView];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@", API_Intention, Id];
    [HttpRequest.sharedInstance getWithURLString:urlString parameters:nil success:^(id  _Nullable responseObject) {
        success(responseObject);
        [MBProgressHUD hideHUD];
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
        [MBProgressHUD showError:errorText];
    }];
}

+ (void)getResidencceHouseLayoutCountWithId:(NSString *)residenceId success:(SuccessBlock)success failure:(FailureBlock)failure {
    NSDictionary *params = @{
                             @"residenceId" : residenceId,
                             };
    [HttpRequest.sharedInstance getWithURLString:API_HouseLayoutCount parameters:params success:^(id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
    }];
}

+ (void)getPreferredConsultListWithPageNumber:(NSInteger)pageNo pageSize:(NSInteger)pageSize username:(NSString *)username nickname:(NSString *)nickname phone:(NSString *)phone success:(SuccessBlock)success failure:(FailureBlock)failure {
    NSDictionary *params = @{
                             @"pageNo" : [NSNumber numberWithInteger:pageNo],
                             @"pageSize" : [NSNumber numberWithInteger:pageSize],
                             @"username" : username,
                             @"nickname" : nickname,
                             @"phone" : phone,
                             };
    [HttpRequest.sharedInstance getWithURLString:API_PerferredConsult parameters:params success:^(id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
    }];
}

+ (void)getPreferredConsultListCountWithUsername:(NSString *)username nickname:(NSString *)nickname phone:(NSString *)phone success:(SuccessBlock)success failure:(FailureBlock)failure {
    NSDictionary *params = @{
                             @"username" : username,
                             @"nickname" : nickname,
                             @"phone" : phone,
                             };
    [HttpRequest.sharedInstance getWithURLString:API_PerferredConsultCount parameters:params success:^(id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
    }];
}

+ (void)getAssumeLikeAndSuccess:(SuccessBlock)success failure:(FailureBlock)failure {
    [HttpRequest.sharedInstance getWithURLString:API_AssumeLike parameters:nil success:^(id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
    }];
}


/* -------- 房贷计算器 -------- */

+ (void)calculateEqualPrincipalWithPrincial:(NSString *)princial years:(NSString *)years rate:(NSString *)rate success:(SuccessBlock)success failure:(FailureBlock)failure {
    if (BWStringIsEmpty(princial)) {
        [MBProgressHUD showText:@"请输入贷款金额"];
        return;
    }
    if (BWStringIsEmpty(years)) {
        [MBProgressHUD showText:@"请选择贷款年限"];
        return;
    }
    if (BWStringIsEmpty(rate)) {
        [MBProgressHUD showText:@"请选择贷款利率"];
        return;
    }
    
    [MBProgressHUD showLoadingView];
    NSDictionary *params = @{
                             @"principal" : [NSNumber numberWithFloat:[princial floatValue]],
                             @"years" : [NSNumber numberWithInteger:[years integerValue]],
                             @"rate" : [NSNumber numberWithFloat:[rate floatValue]],
                             };

    [HttpRequest.sharedInstance getWithURLString:API_CalculateEqualPrincipal parameters:params success:^(id  _Nullable responseObject) {
        success(responseObject);
        [MBProgressHUD hideHUD];
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
        [MBProgressHUD showError:errorText];
    }];
}

+ (void)calculateEqualPrincipalAndInterestWithPrincial:(NSString *)princial years:(NSString *)years rate:(NSString *)rate success:(SuccessBlock)success failure:(FailureBlock)failure {
    if (BWStringIsEmpty(princial)) {
        [MBProgressHUD showText:@"请输入贷款金额"];
        return;
    }
    if (BWStringIsEmpty(years)) {
        [MBProgressHUD showText:@"请选择贷款年限"];
        return;
    }
    if (BWStringIsEmpty(rate)) {
        [MBProgressHUD showText:@"请选择贷款利率"];
        return;
    }
    
    [MBProgressHUD showLoadingView];
    NSDictionary *params = @{
                             @"principal" : [NSNumber numberWithFloat:[princial floatValue]],
                             @"years" : [NSNumber numberWithInteger:[years integerValue]],
                             @"rate" : [NSNumber numberWithFloat:[rate floatValue]],
                             };
    
    [HttpRequest.sharedInstance getWithURLString:API_CalculateEqualPrincipalAndInterest parameters:params success:^(id  _Nullable responseObject) {
        success(responseObject);
        [MBProgressHUD hideHUD];
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
        [MBProgressHUD showError:errorText];
    }];
}

+ (void)calculateEqualPrincipalForCombinationWithYearsCommercial:(NSString *)yearsCommercial principalCommercial:(NSString *)principalCommercial rateCommercial:(NSString *)rateCommercial yearsAccumulation:(NSString *)yearsAccumulation principalAccumulation:(NSString *)principalAccumulation rateAccumulation:(NSString *)rateAccumulation success:(SuccessBlock)success failure:(FailureBlock)failure {
    if (BWStringIsEmpty(principalAccumulation)) {
        [MBProgressHUD showText:@"请输入公积金金额"];
        return;
    }
    if (BWStringIsEmpty(yearsAccumulation)) {
        [MBProgressHUD showText:@"请选择公积金年限"];
        return;
    }
    if (BWStringIsEmpty(rateAccumulation)) {
        [MBProgressHUD showText:@"请选择公积金利率"];
        return;
    }
    if (BWStringIsEmpty(principalCommercial)) {
        [MBProgressHUD showText:@"请输入商贷金额"];
        return;
    }
    if (BWStringIsEmpty(yearsCommercial)) {
        [MBProgressHUD showText:@"请选择商贷年限"];
        return;
    }
    if (BWStringIsEmpty(rateCommercial)) {
        [MBProgressHUD showText:@"请选择商贷利率"];
        return;
    }
    
    NSDictionary *params = @{
                             @"principalAccumulation" : principalAccumulation,      // 公积金贷款总额
                             @"yearsAccumulation" : yearsAccumulation,      // 商贷贷款期限（年）
                             @"rateAccumulation" : rateAccumulation,        // 公积金贷款利率
                             
                             @"principalCommercial" : principalCommercial,      // 商业贷款总额
                             @"yearsCommercial" : yearsCommercial,      // 商贷贷款期限（年）
                             @"rateCommercial" : rateCommercial,        // 商业贷款利率
                             };
    
    [HttpRequest.sharedInstance getWithURLString:API_CalculateEqualPrincipalForCombination parameters:params success:^(id  _Nullable responseObject) {
        success(responseObject);
        [MBProgressHUD hideHUD];
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
        [MBProgressHUD showError:errorText];
    }];
}

+ (void)calculateEqualPrincipalAndInterestForCombinationWithYearsCommercial:(NSString *)yearsCommercial principalCommercial:(NSString *)principalCommercial rateCommercial:(NSString *)rateCommercial yearsAccumulation:(NSString *)yearsAccumulation principalAccumulation:(NSString *)principalAccumulation rateAccumulation:(NSString *)rateAccumulation success:(SuccessBlock)success failure:(FailureBlock)failure {
    if (BWStringIsEmpty(principalAccumulation)) {
        [MBProgressHUD showText:@"请输入公积金金额"];
        return;
    }
    if (BWStringIsEmpty(yearsAccumulation)) {
        [MBProgressHUD showText:@"请选择公积金年限"];
        return;
    }
    if (BWStringIsEmpty(rateAccumulation)) {
        [MBProgressHUD showText:@"请选择公积金利率"];
        return;
    }
    if (BWStringIsEmpty(principalCommercial)) {
        [MBProgressHUD showText:@"请输入商贷金额"];
        return;
    }
    if (BWStringIsEmpty(yearsCommercial)) {
        [MBProgressHUD showText:@"请选择商贷年限"];
        return;
    }
    if (BWStringIsEmpty(rateCommercial)) {
        [MBProgressHUD showText:@"请选择商贷利率"];
        return;
    }
    
    [MBProgressHUD showLoadingView];
    NSDictionary *params = @{
                             @"principalAccumulation" : principalAccumulation,      // 公积金贷款总额
                             @"yearsAccumulation" : yearsAccumulation,      // 商贷贷款期限（年）
                             @"rateAccumulation" : rateAccumulation,        // 公积金贷款利率

                             @"principalCommercial" : principalCommercial,      // 商业贷款总额
                             @"yearsCommercial" : yearsCommercial,      // 商贷贷款期限（年）
                             @"rateCommercial" : rateCommercial,        // 商业贷款利率
                             
                             };
    
    [HttpRequest.sharedInstance getWithURLString:API_CalculateEqualPrincipalAndInterestForCombination parameters:params success:^(id  _Nullable responseObject) {
        success(responseObject);
        [MBProgressHUD hideHUD];
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
        [MBProgressHUD showError:errorText];
    }];
}


/* -------- 个人中心 -------- */

+ (void)getMyAttentionWithPageNumber:(NSUInteger)pageNo pageSize:(NSUInteger)pageSize attentionType:(NSUInteger)type success:(SuccessBlock)success failure:(FailureBlock)failure; {
    [MBProgressHUD showLoadingView];
    NSDictionary *params = @{
                             @"pageNo" : [NSNumber numberWithUnsignedInteger:pageNo],
                             @"pageSize" : [NSNumber numberWithUnsignedInteger:pageSize],
                             @"type" : [NSNumber numberWithUnsignedInteger:type],
                             };
    [HttpRequest.sharedInstance getWithURLString:API_MyAttention parameters:params success:^(id  _Nullable responseObject) {
        success(responseObject);
        [MBProgressHUD hideHUD];
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
        [MBProgressHUD showError:errorText];
    }];
}

+ (void)getMyAttentionNumberWithType:(NSUInteger)type success:(SuccessBlock)success failure:(FailureBlock)failure {
    [MBProgressHUD showLoadingView];
    NSDictionary *params = @{
                             @"type" : [NSNumber numberWithUnsignedInteger:type],
                             };
    [HttpRequest.sharedInstance getWithURLString:API_MyAttentionNum parameters:params success:^(id  _Nullable responseObject) {
        success(responseObject);
        [MBProgressHUD hideHUD];
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
        [MBProgressHUD showError:errorText];
    }];
}

+ (void)addAttentionWithType:(NSInteger)type objectId:(NSString *)objId success:(SuccessBlock)success failure:(FailureBlock)failure {
    [MBProgressHUD showLoadingView];
    NSDictionary *params = @{
                             @"type" : [NSNumber numberWithInteger:type],
                             @"objectId" : objId,
                             };
    [HttpRequest.sharedInstance postWithURLString:API_AddAttention parameters:params success:^(id  _Nullable responseObject) {
        success(responseObject);
        [MBProgressHUD hideHUD];
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
        [MBProgressHUD showError:errorText];
    }];
}

+ (void)deleteAttentionWithType:(NSInteger)type objectId:(NSString *)objId success:(SuccessBlock)success failure:(FailureBlock)failure {
    [MBProgressHUD showLoadingView];
    NSDictionary *params = @{
                             @"type" : [NSNumber numberWithInteger:type],
                             @"objectId" : objId,
                             };
    [HttpRequest.sharedInstance getWithURLString:API_DeleteAttention parameters:params success:^(id  _Nullable responseObject) {
        success(responseObject);
        [MBProgressHUD hideHUD];
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
        [MBProgressHUD showError:errorText];
    }];
}

+ (void)getAttentionStatusType:(NSInteger)type objectId:(NSString *)objId success:(SuccessBlock)success failure:(FailureBlock)failure {
    NSDictionary *params = @{
                             @"type" : [NSNumber numberWithInteger:type],
                             @"objectId" : objId,
                             };
    [HttpRequest.sharedInstance getWithURLString:API_IsAttention parameters:params success:^(id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
    }];
}

+ (void)getSubscribeStatusAndSuccess:(SuccessBlock)success failure:(FailureBlock)failure {
    [HttpRequest.sharedInstance getWithURLString:API_GetSubscribeState parameters:nil success:^(id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
    }];
}

+ (void)subscribeResicendeWithPhoneNumber:(NSString *)phoneNum state:(NSInteger)state success:(SuccessBlock)success failure:(FailureBlock)failure {
    [MBProgressHUD showLoadingView];
    NSDictionary *params = @{
                             @"phoneNum" : phoneNum,
                             @"state" : [NSNumber numberWithInteger:state],
                             };
    [HttpRequest.sharedInstance postWithURLString:API_Subscrice parameters:params success:^(id  _Nullable responseObject) {
        success(responseObject);
        [MBProgressHUD hideHUD];
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
        [MBProgressHUD showError:errorText];
    }];
}

+ (void)getBrowseHistoryWithPageNumber:(NSUInteger)pageNo pageSize:(NSUInteger)pageSize historyType:(NSUInteger)type success:(SuccessBlock)success failure:(FailureBlock)failure {
    NSDictionary *params = @{
                             @"pageNo" : [NSNumber numberWithInteger:pageNo],
                             @"pageSize" : [NSNumber numberWithInteger:pageSize],
                             @"type" : [NSNumber numberWithInteger:type],
                             };
    [HttpRequest.sharedInstance getWithURLString:API_BrowseHistory parameters:params success:^(id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
    }];
}

/* -------- 查询接口 -------- */
+ (void)getAreaListDataWithParentCode:(NSString *)pCode success:(SuccessBlock)success failure:(FailureBlock)failure {
    NSDictionary *params = @{
                             @"pCode" : pCode,
                             };
    [HttpRequest.sharedInstance getWithURLString:API_GetAreaList parameters:params success:^(id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
    }];
}

+ (void)getAllAreaListDataWithParentCode:(NSString *)pCode success:(SuccessBlock)success failure:(FailureBlock)failure {
    NSDictionary *params = @{
                             @"pCode" : pCode,
                             };
    [HttpRequest.sharedInstance getWithURLString:API_GetAllAreaList parameters:params success:^(id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
    }];
}

/**
 根据主键获取地区列表
 
 @param ID 地区ID
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getAreaListDataWithAreaID:(NSString *)ID success:(SuccessBlock)success failure:(FailureBlock)failure {
    NSString *api = API_GetAreaList;
    NSString *urlString = [NSString stringWithFormat:@"%@/%@", api, ID];
    [HttpRequest.sharedInstance getWithURLString:urlString parameters:nil success:^(id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
    }];
}

+ (void)getDictWithDictType:(NSString *)dictType success:(SuccessBlock)success failure:(FailureBlock)failure {
    NSDictionary *params = @{
                             @"type" : dictType,
                             };
    [HttpRequest.sharedInstance getWithURLString:API_DictSearch parameters:params success:^(id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
    }];
}

+ (void)getAreaNewHouseNumWithCityCode:(NSString *)cityCode salesStatus:(NSString *)salesStatus openTime:(NSString *)openTime roomNum:(NSString *)roomNum minTotalPrice:(NSString *)minTotalPrice maxTotalPrice:(NSString *)maxTotalPrice priceRange:(NSString *)priceRange ownership:(NSString *)ownership success:(SuccessBlock)success failure:(FailureBlock)failure {
    NSDictionary *params = @{
                             @"city":cityCode,
                             @"salesStatus":salesStatus.length>0?salesStatus:@"",
                             @"openTime":openTime.length>0?openTime:@"",
                             @"roomNum":roomNum.length>0?roomNum:@"",
                             @"minTotalPrice":minTotalPrice.length>0?minTotalPrice:@"",
                             @"maxTotalPrice":maxTotalPrice.length>0?maxTotalPrice:@"",
                             @"priceRange":priceRange.length>0?priceRange:@"",
                             @"ownership":ownership.length>0?ownership:@""
                             };
    [HttpRequest.sharedInstance getWithURLString:API_GetAreaNewHouseCount parameters:params success:^(id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
    }];
}

+ (void)getHouseByMapDictListWithSuccess:(SuccessBlock)success failure:(FailureBlock)failure {
    [HttpRequest.sharedInstance getWithURLString:API_GetHouseByMapDictList parameters:nil success:^(id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSString * _Nullable errorCode, NSString * _Nullable errorText) {
        failure(errorCode, errorText);
    }];
}

@end
