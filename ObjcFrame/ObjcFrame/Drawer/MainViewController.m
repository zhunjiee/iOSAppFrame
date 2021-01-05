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
    
    if (self.type == DrawerTypeLeft) {
        NSString *leftImageName = BWStringIsEmpty(self.leftNavImageName) ? @"mine_nav_icon" : self.leftNavImageName;
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(menuBtnDidClick:) normalImage:leftImageName selImage:@""];
    } else if (self.type == DrawerTypeRight) {
        NSString *rightImageName = BWStringIsEmpty(self.rightNavImageName) ? @"message_nav_icon" : self.rightNavImageName;
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(messageBtnDidClick:) normalImage:rightImageName selImage:@""];
    } else {
        NSString *leftImageName = BWStringIsEmpty(self.leftNavImageName) ? @"mine_nav_icon" : self.leftNavImageName;
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(menuBtnDidClick:) normalImage:leftImageName selImage:@""];
        NSString *rightImageName = BWStringIsEmpty(self.rightNavImageName) ? @"message_nav_icon" : self.rightNavImageName;
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(messageBtnDidClick:) normalImage:rightImageName selImage:@""];
    }
    
}

#pragma mark - 事件监听
- (void)menuBtnDidClick:(UIButton *)button {
    if (self.mainVcMenuNavBtnClickBlock) {
        self.mainVcMenuNavBtnClickBlock(button);
    }
}

- (void)messageBtnDidClick:(UIButton *)button {
    if (self.mainVcMessageNavBtnClickBlock) {
        self.mainVcMessageNavBtnClickBlock(button);
    }
}

@end
