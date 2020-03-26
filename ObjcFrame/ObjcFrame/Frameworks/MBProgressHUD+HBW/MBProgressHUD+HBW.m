//
//  MBProgressHUD+BWLoading.m
//  BWLoading
//
//  Created by BaoWei Hou on 16/04/2018.
//  Copyright © 2018 BaoWei Hou. All rights reserved.
//

#import "MBProgressHUD+HBW.h"
#import "BWLoadingStyleManager.h"

//来自于SDWebImage，保证任务在主线程执行
#ifndef dispatch_queue_async_safe
#define dispatch_queue_async_safe(queue, block)\
if (dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL) == dispatch_queue_get_label(queue)) {\
    block();\
} else {\
    dispatch_async(queue, block);\
}
#endif

#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block) dispatch_queue_async_safe(dispatch_get_main_queue(), block)
#endif

@implementation MBProgressHUD (HBW)

#pragma mark - 在指定的view上显示hud
/// 成功
+ (void)showSuccess:(NSString *)success onView:(UIView *)view {
    [self show:success icon:@"Resource.bundle/success" view:view];
}

/// 错误
+ (void)showError:(NSString *)error onView:(UIView *)view {
    [self show:error icon:@"Resource.bundle/error" view:view];
}

/// 警告
+ (void)showWarning:(NSString *)warning onView:(UIView *)view {
    [self show:warning icon:@"Resource.bundle/warning" view:view];
}

/// 纯文本
+ (void)showText:(NSString *)text onView:(UIView *)view {
    [self show:text icon:nil view:view];
}

/// 自定义图片
+ (void)showMessageWithImageName:(NSString *)imageName message:(NSString *)message onView:(UIView *)view {
    [self show:message icon:imageName view:view];
}

/// 菊花 + 文字
+ (void)showLoadingMessage:(NSString *)message onView:(UIView *)view  {
    [self showLoading:message onView:view];
}

/// 只显示菊花
+ (void)showLoadingOnView:(UIView *)view {
    [self showLoading:@"" onView:view];
}


#pragma mark - 在window上显示hud

+ (void)showSuccess:(NSString *)success {
    [self show:success icon:@"Resource.bundle/success" view:nil];
}

+ (void)showError:(NSString *)error {
    [self show:error icon:@"Resource.bundle/error" view:nil];
}

+ (void)showWarning:(NSString *)warning {
    [self show:warning icon:@"Resource.bundle/warning" view:nil];
}

+ (void)showText:(NSString *)text {
    [self show:text icon:nil view:nil];
}

+ (void)showMessageWithImageName:(NSString *)imageName message:(NSString *)message {
    [self show:message icon:imageName view:nil];
}

// 显示 转圈菊花 + 文字
+ (void)showLoadingMessage:(NSString *)message {
    UIView *view = [self getWindowView];
    [self showLoading:message onView:view];
}

// 只显示菊花
+ (void)showLoading {
    UIView *view = [self getWindowView];
    [self showLoading:@"" onView:view];
}

#pragma mark - 隐藏方法

+ (void)hideHUDForView:(UIView *)view{
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD {
    UIView *view = [self getWindowView];
    [self hideHUDForView:view];
}


#pragma mark - 显示基本信息

+ (void)show:(NSString *)text icon:(NSString *)iconName view:(UIView *)view {
    if (view == nil) {
        view = [self getWindowView];
    }
    //在显示新的之前需要隐藏掉旧的，否则会导致多个loading页面重叠
    [self hideHUDForView:view animated:YES];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.bezelView.layer.cornerRadius = 8.0;
    UIImageRenderingMode renderMode = UIImageRenderingModeAlwaysTemplate;
    
    if ([BWLoadingStyleManager sharedInstance].hudStyle == LightBackgroundStyle) {
        //灰白色背景+icon和背景同色
        renderMode = UIImageRenderingModeAlwaysTemplate;
        hud.bezelView.style = MBProgressHUDBackgroundStyleBlur; //单色背景
    }
    else if ([BWLoadingStyleManager sharedInstance].hudStyle == DimBackgroundStyle) {
        //老版本样式，带透明度的黑色背景+白色icon
        renderMode = UIImageRenderingModeAlwaysOriginal;
        hud.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1.0]; //黑色背景
        hud.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];// 整个view背景
        hud.contentColor = [UIColor whiteColor];
    }
    hud.label.text = text;
    UIImage *image = [[UIImage imageNamed:iconName] imageWithRenderingMode:renderMode];
    image = image == nil ? [[UIImage imageNamed:iconName] imageWithRenderingMode:renderMode] : image;
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    // 指定时间之后消失
    dispatch_main_async_safe(^{
        [hud hideAnimated:YES afterDelay:[BWLoadingStyleManager sharedInstance].hudShowTime];
    });
}


#pragma mark - 显示带旋转菊花的hud

+ (void)showLoading:(NSString *)message onView:(UIView *)view {
    if (view == nil) {
        view = [self getWindowView];
    }
    //在显示新的之前需要隐藏掉旧的，否则会导致多个loading页面重叠
    [self hideHUDForView:view animated:YES];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.bezelView.layer.cornerRadius = 8.0;
    hud.label.text = message;
    hud.removeFromSuperViewOnHide = YES;
    
    if ([BWLoadingStyleManager sharedInstance].hudStyle == LightBackgroundStyle) {
        //灰白色背景
        hud.bezelView.style = MBProgressHUDBackgroundStyleBlur; //单色背景
    }
    else if ([BWLoadingStyleManager sharedInstance].hudStyle == DimBackgroundStyle) {
        //老版本样式，带透明度的黑色背景
        hud.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1.0]; //黑色背景
        hud.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];// 整个view背景
        hud.contentColor = [UIColor whiteColor];
    }
}

/// 获取window视图
+  (UIView *)getWindowView {
    UIView *view;
    if ([[UIApplication sharedApplication] keyWindow] != nil) {
        view = [[UIApplication sharedApplication] keyWindow];
    } else {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    return view;
}

@end
