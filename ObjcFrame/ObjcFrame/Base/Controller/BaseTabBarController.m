//
//  BaseTabBarController.m
//  MengTianXIa
//
//  Created by zl on 2019/8/9.
//  Copyright © 2019 qttx. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "HomeViewController.h"
#import "NewsViewController.h"
#import "MessageViewController.h"
#import "MemberViewController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTabBarItemAttributes];
    [self setupAllChildViewController];
}

/**
 设置所有item的属性
 */
- (void)setupTabBarItemAttributes {
    UITabBar *tabBar = [UITabBar appearance];
    // 解决ios12.1 tabBar 中的图标及文字在pop时出现位置偏移动画的bug
    // 顺便去除 tabBar 的毛玻璃效果，将背景色设置为白色
    [tabBar setTranslucent:NO];
    // 去除分割线
    [tabBar setShadowImage:[UIImage new]];
    [tabBar setBackgroundImage:[UIImage new]];
    // 设置背景色
    [tabBar setBarTintColor:[UIColor redColor]];
    
    // 通过appearance统一设置TabBar控制器的文字
    UITabBarItem *item = [UITabBarItem appearance];
    
    // 正常状态颜色
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    
    // 选中状态颜色
    NSMutableDictionary *selAttrs = [NSMutableDictionary dictionary];
    selAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:selAttrs forState:UIControlStateSelected];
}

/**
 *  设置所有子控制器
 */
- (void)setupAllChildViewController {
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    [self setUpOneChildViewController:homeVC withImage:@"tabbar_news_btn_n" selImage:@"tabbar_news_btn_n" title:@"首页"];
    
    NewsViewController *newsVC = [[NewsViewController alloc] init];
    [self setUpOneChildViewController:newsVC withImage:@"tabbar_news_btn_n" selImage:@"tabbar_news_btn_n" title:@"新闻资讯"];
    
    MessageViewController *messageVC = [[MessageViewController alloc] init];
    [self setUpOneChildViewController:messageVC withImage:@"tabbar_news_btn_n" selImage:@"tabbar_news_btn_n" title:@"消息"];
    
    MemberViewController *memberVC = [[MemberViewController alloc] init];
    [self setUpOneChildViewController:memberVC withImage:@"tabbar_news_btn_n" selImage:@"tabbar_news_btn_n" title:@"会员中心"];
}

/**
 *  设置单个子控制器
 */
- (void)setUpOneChildViewController:(UIViewController *)vc withImage:(NSString *)image selImage:(NSString *)selImage title:(NSString *)title {
    // 设置标题
    vc.tabBarItem.title = title;
    // 显示不被渲染的图片
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 创建导航控制器
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
}

@end
