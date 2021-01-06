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
}

- (void)setType:(DrawerType)type {
    _type = type;
    
    if (type == DrawerTypeLeft) {
        NSString *leftImageName = BWStringIsEmpty(self.leftNavImageName) ? @"mine_nav_icon" : self.leftNavImageName;
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(menuBtnDidClick:) normalImage:leftImageName selImage:@""];
    } else if (type == DrawerTypeRight) {
        NSString *rightImageName = BWStringIsEmpty(self.rightNavImageName) ? @"message_nav_icon" : self.rightNavImageName;
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(messageBtnDidClick:) normalImage:rightImageName selImage:@""];
    } else {
        NSString *leftImageName = BWStringIsEmpty(self.leftNavImageName) ? @"mine_nav_icon" : self.leftNavImageName;
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(menuBtnDidClick:) normalImage:leftImageName selImage:@""];
        NSString *rightImageName = BWStringIsEmpty(self.rightNavImageName) ? @"message_nav_icon" : self.rightNavImageName;
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(messageBtnDidClick:) normalImage:rightImageName selImage:@""];
    }
}

- (void)setLeftNavImageName:(NSString *)leftNavImageName {
    _leftNavImageName = leftNavImageName;

    NSString *leftImageName = BWStringIsEmpty(leftNavImageName) ? @"mine_nav_icon" : leftNavImageName;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(menuBtnDidClick:) normalImage:leftImageName selImage:@""];
}

- (void)setRightNavImageName:(NSString *)rightNavImageName {
    _rightNavImageName = rightNavImageName;

    if (!BWStringIsEmpty(rightNavImageName)) {
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(messageBtnDidClick:) normalImage:rightNavImageName selImage:@""];
    }
}

#pragma mark - 事件监听
- (void)menuBtnDidClick:(UIButton *)button {
    if (self.type != DrawerTypeRight) {
        if (self.mainVcMenuNavBtnClickBlock) {
            self.mainVcMenuNavBtnClickBlock(button);
        }
    }
}

- (void)messageBtnDidClick:(UIButton *)button {
    if (self.type != DrawerTypeLeft) {
        if (self.mainVcMessageNavBtnClickBlock) {
            self.mainVcMessageNavBtnClickBlock(button);
        }
    }
}

@end
