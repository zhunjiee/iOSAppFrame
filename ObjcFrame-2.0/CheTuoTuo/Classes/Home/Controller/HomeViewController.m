//
//  HomeViewController.m
//  MengTianXIa
//
//  Created by zl on 2019/8/9.
//  Copyright © 2019 qttx. All rights reserved.
//

#import "HomeViewController.h"
#import "MessageViewController.h"

@interface HomeViewController () <UINavigationControllerDelegate>

@end

@implementation HomeViewController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self setupNavigationBar];
}

- (void)initView {
    self.view.backgroundColor = [UIColor orangeColor];
}

- (void)setupNavigationBar {
    self.navigationItem.title = @"车拖拖";

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

@end
