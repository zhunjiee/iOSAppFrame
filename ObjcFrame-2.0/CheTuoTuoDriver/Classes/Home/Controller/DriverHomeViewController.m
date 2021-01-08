//
//  DriverHomeViewController.m
//  CheTuoTuo
//
//  Created by Houge on 2021/1/7.
//

#import "DriverHomeViewController.h"
#import "MessageViewController.h"

@interface DriverHomeViewController () <UINavigationControllerDelegate>

@end

@implementation DriverHomeViewController
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
}

- (void)setupNavigationBar {
    self.navigationItem.title = @"车拖拖-司机";

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(menuBtnDidClick:) normalImage:@"nav_mine_icon" selImage:@""];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(messageBtnDidClick:) normalImage:@"nav_message_icon" selImage:@""];
    self.navigationController.delegate = self;
}

#pragma mark - 事件监听
/// 点击左侧菜单按钮
- (void)menuBtnDidClick:(UIButton *)button {
    [self.viewDeckVC openSide:IIViewDeckSideLeft animated:YES];
}

/// 点击右侧消息按钮
- (void)messageBtnDidClick:(UIButton *)button {
    MessageViewController *vc = [[MessageViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UINavigationControllerDelegate
/// 不在首页时禁止抽屉效果，避免和左滑返回手势冲突
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (![viewController isKindOfClass:[DriverHomeViewController class]]) {
        // 移除拖拽手势
        self.viewDeckController.panningEnabled = NO;
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([viewController isKindOfClass:[DriverHomeViewController class]]) {
        // 重新添加拖拽手势
        self.viewDeckController.panningEnabled = YES;
    }
}

@end
