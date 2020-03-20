//
//  HomeViewController.m
//  MengTianXIa
//
//  Created by zl on 2019/8/9.
//  Copyright © 2019 qttx. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    self.view.backgroundColor = [UIColor orangeColor];
    [self createTestView];
}

- (void)createTestView {
    UIView *test = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    test.backgroundColor = [UIColor redColor];
    [self.view addSubview:test];
}

@end
