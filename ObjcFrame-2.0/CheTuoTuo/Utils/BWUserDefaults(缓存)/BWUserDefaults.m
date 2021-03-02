//
//  DWUserDefaults.m
//  Unicorn
//
//  Created by Marshall Yang on 2018/1/8.
//  Copyright © 2018年 Marshall Yang. All rights reserved.
//

#import "BWUserDefaults.h"

#define UserDefaults [NSUserDefaults standardUserDefaults]

@implementation BWUserDefaults

#pragma mark - 用户相关

/// 登录状态
+ (BOOL)userLoginState {
    if ([UserDefaults objectForKey:UserLoginState] == nil) {
        [UserDefaults setObject:@"0" forKey:UserLoginState];
        [UserDefaults synchronize];
        return NO;
    }
    NSString *state = [UserDefaults objectForKey:UserLoginState];
    if ([state isEqualToString: @"1"]) {
        return YES;
    }
    return NO;
}
+ (void)saveUserLoginState:(BOOL)state {
    if (state) {
        //登录
        [UserDefaults setObject:@"1" forKey:UserLoginState];
    } else {
        //退出登录
        [UserDefaults setObject:@"0" forKey:UserLoginState];
        //清空token
        [UserDefaults setObject:nil forKey:UserToken];
        //清空用户信息
        [UserDefaults setObject:nil forKey:Username];
        [UserDefaults setObject:nil forKey:UserNickname];
        [UserDefaults setObject:nil forKey:UserPhoneNumber];
        [UserDefaults setObject:nil forKey:UserCityName];
        [UserDefaults setObject:nil forKey:UserLocation];
    }
    [UserDefaults synchronize];
}

/// token
+ (NSString *)userToken {
    NSString *token = [UserDefaults objectForKey:UserToken];
    return BWCheckString(token);
}
+ (void)saveUserToken:(NSString *)token {
    [UserDefaults setObject:token forKey:UserToken];
    [UserDefaults synchronize];
}

/// uid
+ (NSString *)userId {
    NSString *userId = [UserDefaults objectForKey:UserID];
    return BWCheckString(userId);
}
+ (void)saveUserId:(NSString *)userId {
    [UserDefaults setObject:BWCheckString(userId) forKey:UserID];
    [UserDefaults synchronize];
}

/// 昵称
+ (NSString *)userNickName {
    NSString *nickname = [UserDefaults objectForKey:UserNickname];
    return BWCheckString(nickname);
}
+ (void)saveUserNickname:(NSString *)nickname {
    [UserDefaults setObject:BWCheckString(nickname) forKey:UserNickname];
    [UserDefaults synchronize];
}

/// 用户名
+ (NSString *)userName {
    NSString *username = [UserDefaults objectForKey:Username];
    return BWCheckString(username);
}
+ (void)saveUserName:(NSString *)userName {
    [UserDefaults setObject:BWCheckString(userName) forKey:Username];
    [UserDefaults synchronize];
}

/// 手机号
+ (NSString *)userPhoneNumber {
    NSString *phoneNumber = [UserDefaults objectForKey:UserPhoneNumber];
    return BWCheckString(phoneNumber);
}
+ (void)saveUserPhoneNumber:(NSString *)phoneNumber {
    [UserDefaults setObject:BWCheckString(phoneNumber) forKey:UserPhoneNumber];
    [UserDefaults synchronize];
}

/// 密码
+ (NSString *)userPassword {
    NSString *password = [UserDefaults objectForKey:UserPassword];
    return BWCheckString(password);
}
+ (void)saveUserPassword:(NSString *)password {
    [UserDefaults setObject:BWCheckString(password) forKey:UserPassword];
    [UserDefaults synchronize];
}

/// 用户所在城市
+ (NSString *)userCityName {
    NSString *cityName = [UserDefaults objectForKey:UserCityName];
    return BWCheckString(cityName);
}
+ (void)saveUserCityName:(NSString *)city {
    [UserDefaults setObject:BWCheckString(city) forKey:UserCityName];
    [UserDefaults synchronize];
}

/// 用户当前经纬度
+ (CLLocationCoordinate2D)userLocation {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userDefaults objectForKey:UserLocation];
    double lat = [dict[@"lat"] doubleValue];
    double lng = [dict[@"lng"] doubleValue];
    return CLLocationCoordinate2DMake(lat, lng);
}
+ (void)saveUserLocation:(CLLocationCoordinate2D)location {
    NSDictionary *dict = @{
        @"lat" : @(location.latitude),
        @"lng" : @(location.longitude),
    };
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:dict forKey:UserLocation];
    [userDefaults synchronize];
}


#pragma mark - 司机相关

@end
