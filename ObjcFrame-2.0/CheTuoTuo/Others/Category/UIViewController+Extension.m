//
//  UIViewController+TabBarAndNavHeight.m
//  MengTianXia
//
//  Created by 侯宝伟 on 2019/3/1.
//  Copyright © 2019 zhunjiee. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)
/// 状态栏高度
- (float)getStatusbarHeight {
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}

/// 导航栏高度+状态栏高度
- (float)getNavigationbarHeight {
    return self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
}

/// Tabbar高度
- (float)getTabbarHeight {
    return self.tabBarController.tabBar.bounds.size.height;
}

@end
