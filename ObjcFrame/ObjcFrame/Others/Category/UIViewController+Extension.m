//
//  UIViewController+TabBarAndNavHeight.m
//  MengTianXia
//
//  Created by 侯宝伟 on 2019/3/1.
//  Copyright © 2019 zhunjiee. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)

- (float)getStatusbarHeight {
    //状态栏高度
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}

- (float)getNavigationbarHeight {
    //导航栏高度+状态栏高度
    return self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
}

- (float)getTabbarHeight {
    //Tabbar高度
    return self.tabBarController.tabBar.bounds.size.height;
}

+ (UIViewController *)getCurrentViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

@end
