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

// 登录状态：yes登录，no登出
+ (BOOL)loginState;
+ (void)saveLoginState:(BOOL)state;

// 保存token
+ (NSString *)getToken;
+ (void)saveToken:(NSString *)token;

// uid
+ (NSString *)userId;
+ (void)saveUserId:(NSString *)userId;

// 昵称
+ (NSString *)userNickName;
+ (void)saveUserNickname:(NSString *)nickname;

// 用户名
+ (NSString *)userName;
+ (void)saveUserName:(NSString *)userName;

// 手机号码
+ (NSString *)userPhoneNumber;
+ (void)saveUserPhoneNumber:(NSString *)phoneNumber;

// 手机号码
+ (NSString *)userPassword;
+ (void)saveUserPassword:(NSString *)password;


/**
 用户位置信息
 */

// 用户所在城市
+ (NSString *)userCityName;
+ (void)saveUserCityName:(NSString *)city;

// 经度
+ (CGFloat)userLocationLongitude;
+ (void)saveUserLocationLongitude:(CGFloat)longitude;

// 纬度
+ (CGFloat)userLocationLatitude;
+ (void)saveUserLocationLatitude:(CGFloat)latitude;
@end
