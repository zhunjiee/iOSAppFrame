//
//  BaseTableViewController.m
//  MengTianXIa
//
//  Created by zl on 2019/8/9.
//  Copyright © 2019 qttx. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    self.tableView.backgroundColor =  BACKGROUND_COLOR;
    self.tableView.showsVerticalScrollIndicator = NO;
}

@end
