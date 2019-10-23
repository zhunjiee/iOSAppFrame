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

#pragma mark - 显示基本信息

+ (void)show:(NSString *)text icon:(NSString *)iconName view:(UIView *)view {
    if (view == nil) {
        if ([[UIApplication sharedApplication] keyWindow] != nil) {
            view = [[UIApplication sharedApplication] keyWindow];
        } else {
            view = [[UIApplication sharedApplication].windows lastObject];
        }
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
    UIImage *image = [[UIImage imageNamed:[NSString stringWithFormat:@"Resource.bundle/%@", iconName]] imageWithRenderingMode:renderMode];
    image = image == nil ? [[UIImage imageNamed:iconName] imageWithRenderingMode:renderMode] : image;
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    // 指定时间之后消失
    dispatch_main_async_safe(^{
        [hud hideAnimated:YES afterDelay:[BWLoadingStyleManager sharedInstance].hudShowTime];
    });
}


#pragma mark - 在指定的view上显示hud

+ (void)showSuccess:(NSString *)success onView:(UIView *)view {
    [self show:success icon:@"success" view:view];
}

+ (void)showError:(NSString *)error onView:(UIView *)view {
    [self show:error icon:@"error" view:view];
}

+ (void)showWarning:(NSString *)warning onView:(UIView *)view {
    [self show:warning icon:@"warning" view:view];
}

+ (void)showText:(NSString *)text onView:(UIView *)view {
    [self show:text icon:nil view:view];
}

+ (void)showMessageWithImageName:(NSString *)imageName message:(NSString *)message toView:(UIView *)view {
    [self show:message icon:imageName view:view];
}

#pragma mark - 显示带旋转菊花的hud

+ (void)showLoadingMessage:(NSString *)message onView:(UIView *)view {
    if (view == nil) {
        if ([[UIApplication sharedApplication] keyWindow] != nil) {
            view = [[UIApplication sharedApplication] keyWindow];
        } else {
            view = [[UIApplication sharedApplication].windows lastObject];
        }
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

+ (void)showLoadingOnView:(UIView *)view {
    [self showLoadingMessage:@"" onView:view];
}


#pragma mark - 在window上显示hud

+ (void)showSuccess:(NSString *)success {
    [self show:success icon:@"success" view:nil];
}

+ (void)showError:(NSString *)error {
    [self show:error icon:@"error" view:nil];
}

+ (void)showWarning:(NSString *)warning {
    [self show:warning icon:@"warning" view:nil];
}

+ (void)showText:(NSString *)text {
    [self show:text icon:nil view:nil];
}

+ (void)showMessageWithImageName:(NSString *)imageName message:(NSString *)message {
    [self show:message icon:imageName view:nil];
}

// 显示 转圈菊花 + 文字
+ (void)showLoadingMessage:(NSString *)message {
    [self showLoadingMessage:message onView:nil];
}

// 只显示菊花
+ (void)showLoadingView {
    [self showLoadingOnView:nil];
}


#pragma mark - 隐藏方法

+ (void)hideHUDForView:(UIView *)view{
    if (view == nil) {
        if ([[UIApplication sharedApplication] keyWindow] != nil) {
            view = [[UIApplication sharedApplication] keyWindow];
        } else {
            view = [[UIApplication sharedApplication].windows lastObject];
        }
    }
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD {
    [self hideHUDForView:nil];
}

@end
