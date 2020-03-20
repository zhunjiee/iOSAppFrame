//
//  BaseNavigationController.m
//  MengTianXIa
//
//  Created by zl on 2019/8/9.
//  Copyright © 2019 qttx. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController

+ (void)initialize {
    UINavigationBar *bar = [UINavigationBar appearance];
    // 去除导航栏的毛玻璃效果
    bar.translucent = NO;
    [bar setBackgroundImage:[UIImage new]  forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    // 隐藏导航栏底部分割线
    [bar setShadowImage:[UIImage new]];
    // 设置标题文字
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
    [bar setTitleTextAttributes:attrs];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置手势代理,开启向右滑返回功能
    self.interactivePopGestureRecognizer.delegate = self;
}


/**
 重写push方法实现页面跳转后的各种设置
 
 @param viewController 目的控制器
 @param animated 是否a带有动画效果
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 子页面隐藏底部TabBar按钮
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 自定义子页面的返回按钮样式
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"nav_back_btn_n"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"nav_back_btn_n"] forState:UIControlStateHighlighted];
        //        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        //        [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //        [backBtn setTitleColor:MYColor(251, 32, 37) forState:UIControlStateHighlighted];
        //        backBtn.backgroundColor = [UIColor redColor];
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 0, 10, 30);
        [backBtn sizeToFit];
        [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)goBack {
    [self popViewControllerAnimated:YES];
}

#pragma mark - UIGestureRecognizerDelegate
// 启用手势返回
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.childViewControllers.count > 1;
}
@end
