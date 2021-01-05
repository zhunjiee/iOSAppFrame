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
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView {
    self.tableView.backgroundColor =  BACKGROUND_COLOR;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self monitoredNetworkStatus];
}

#pragma mark - 事件监听
- (void)popViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 监测网络环境
- (void)monitoredNetworkStatus {
    [[HttpRequest sharedInstance] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 显示无网络视图
        if (status == AFNetworkReachabilityStatusNotReachable) {
            [self.tableView showNoDataViewWithType:NoDataTypeNetwork];
        } else if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
            [self.tableView hideNoDataView];
        }
    }];
}

@end
