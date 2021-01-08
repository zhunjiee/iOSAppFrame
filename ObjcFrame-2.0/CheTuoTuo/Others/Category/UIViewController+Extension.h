//
//  UIViewController+TabBarAndNavHeight.h
//  MengTianXia
//
//  Created by 侯宝伟 on 2019/3/1.
//  Copyright © 2019 zhunjiee. All rights reserved.
//
// 获取 状态栏/导航栏 等的高度

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Extension)

/// 获取状态栏的高度
- (float)getStatusbarHeight;
/// 获取导航栏的高度
- (float)getNavigationbarHeight;
/// 获取TabBar的高度
- (float)getTabbarHeight;


/// 获取当前控制器
+ (UIViewController *)getCurrentViewController;

@end

NS_ASSUME_NONNULL_END
