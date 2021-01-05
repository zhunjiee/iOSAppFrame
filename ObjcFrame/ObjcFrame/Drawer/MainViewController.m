//
//  MainViewController.m
//  ObjcFrame
//
//  Created by Houge on 2021/1/5.
//  Copyright © 2021 ZHUNJIEE. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self setupNavigationBar];
}

- (void)setupNavigationBar {
    self.navigationItem.title = @"首页";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(menuBtnDidClick:) normalImage:@"mine_nav_icon" selImage:@""];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(messageBtnDidClick:) normalImage:@"message_nav_icon" selImage:@""];
}

#pragma mark - 事件监听
- (void)menuBtnDidClick:(UIButton *)button {
    if (self.mainVcMenuNavBtnDidClick) {
        self.mainVcMenuNavBtnDidClick(button);
    }
}

- (void)messageBtnDidClick:(UIButton *)button {
    if (self.mainVcMessageNavBtnDidClick) {
        self.mainVcMessageNavBtnDidClick(button);
    }
}

@end
