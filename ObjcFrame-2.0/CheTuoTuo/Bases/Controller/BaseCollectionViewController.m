//
//  BaseCollectionViewController.m
//  ObjcFrame
//
//  Created by zl on 2019/10/23.
//  Copyright © 2019 ZHUNJIEE. All rights reserved.
//

#import "BaseCollectionViewController.h"

@interface BaseCollectionViewController ()

@end

@implementation BaseCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    // view 不被导航栏遮挡
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.collectionView.backgroundColor =  BACKGROUND_COLOR;
    self.collectionView.showsVerticalScrollIndicator = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self monitoredNetworkStatus];
    if (self.clearNavigationBar) {
        // 导航栏透明
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.clearNavigationBar) {
        //  导航栏恢复白色
        [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor] size:CGSizeMake(ScreenWidth, NavBarAndStatusBarHeight)] forBarMetrics:UIBarMetricsDefault];
    }
}

#pragma mark - 事件监听
/// 退出当前控制器
- (void)popViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

/// 不同类型的暂无数据视图
/// @param type 暂无数据类型
- (void)showNoDataViewWithType:(NoDataType)type {
    [self.collectionView showNoDataViewWithType:type];
}

/// 隐藏暂无数据视图
- (void)hideNoDataView {
    [self.collectionView hideNoDataView];
}

/// 显示暂无数据视图-暂无数据
- (void)showNoDataView {
    [self.collectionView showNoDataView];
}

#pragma mark - 监测网络环境
- (void)monitoredNetworkStatus {
    [[HttpRequest sharedInstance] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 显示无网络视图
        if (status == AFNetworkReachabilityStatusNotReachable) {
            [self.collectionView showNoDataViewWithType:NoDataTypeNetwork];
        } else if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
            [self.collectionView hideNoDataView];
        }
    }];
}

@end
