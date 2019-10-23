//
//  MBProgressHUD+BWLoading.h
//  BWLoading
//
//  Created by BaoWei Hou on 16/04/2018.
//  Copyright © 2018 BaoWei Hou. All rights reserved.
//  对MBProgressHUD的一个简单封装，主要是满足常用的显示成功、出错、失败，loading加载提示，与及长文本提示信息

#import <MBProgressHUD.h>

// 统一显示时长
#define kHudShowTime 1.5

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (BWLoading)

#pragma mark - 在指定的view上显示hud
+ (void)showSuccess:(NSString *)success onView:(UIView *)view;
+ (void)showError:(NSString *)error onView:(UIView *)view;
+ (void)showWarning:(NSString *)warning onView:(UIView *)view;
+ (void)showText:(NSString *)text onView:(UIView *)view;
+ (void)showMessageWithImageName:(NSString *)imageName message:(NSString *)message toView:(UIView *)view;
+ (void)showLoadingMessage:(NSString *)message onView:(UIView *)view;       // 显示 转圈菊花 + 文字
+ (void)showLoadingOnView:(UIView *)view;      // 只显示菊花


#pragma mark - 在window上显示hud
+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;
+ (void)showWarning:(NSString *)warning;
+ (void)showText:(NSString *)text;
+ (void)showMessageWithImageName:(NSString *)imageName message:(NSString *)message;
+ (void)showLoadingMessage:(NSString *)message;       // 显示 转圈菊花 + 文字
+ (void)showLoadingView;      // 只显示菊花


#pragma mark - 隐藏方法
// 隐藏特定view上的hud
+ (void)hideHUDForView:(UIView *)view;

// 隐藏window上的hud
+ (void)hideHUD;

@end

NS_ASSUME_NONNULL_END
