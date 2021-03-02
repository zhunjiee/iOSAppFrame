//
//  DWUserDefaults.h
//  Unicorn
//
//  Created by Marshall Yang on 2018/1/8.
//  Copyright © 2018年 Marshall Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface BWUserDefaults : NSObject

#pragma mark - 用户相关

/// 登录状态：yes登录，no登出
+ (BOOL)userLoginState;
+ (void)saveUserLoginState:(BOOL)state;

/// 保存token
+ (NSString *)userToken;
+ (void)saveUserToken:(NSString *)token;

/// uid
+ (NSString *)userId;
+ (void)saveUserId:(NSString *)userId;

/// 昵称
+ (NSString *)userNickName;
+ (void)saveUserNickname:(NSString *)nickname;

/// 用户名
+ (NSString *)userName;
+ (void)saveUserName:(NSString *)userName;

/// 手机号码
+ (NSString *)userPhoneNumber;
+ (void)saveUserPhoneNumber:(NSString *)phoneNumber;

/// 密码
+ (NSString *)userPassword;
+ (void)saveUserPassword:(NSString *)password;

/// 用户所在城市
+ (NSString *)userCityName;
+ (void)saveUserCityName:(NSString *)city;

/// 用户当前经纬度
+ (CLLocationCoordinate2D)userLocation;
+ (void)saveUserLocation:(CLLocationCoordinate2D)location;

#pragma mark - 司机相关


@end
