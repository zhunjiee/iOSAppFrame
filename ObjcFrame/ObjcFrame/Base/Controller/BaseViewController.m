//
//  BaseViewController.m
//  MengTianXIa
//
//  Created by zl on 2019/8/9.
//  Copyright © 2019 qttx. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (strong, nonatomic) UIView *noDataView;
@property (strong, nonatomic) UIImageView *noDataImageView;
@property (strong, nonatomic) UILabel *noDataTipLabel;
@end

@implementation BaseViewController
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView {
    self.view.backgroundColor = BW_WHITE_COLOR;
    
    // view 不被导航栏遮挡
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // 不自动调整scrollView子视图的内边距, scrollView会被导航栏挡住
    //    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self monitoredNetworkStatus];
}

#pragma mark - 事件监听
- (void)popViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 无数据提示
/// 不同类型的暂无数据视图
- (void)showNoDataViewWithType:(NoDataType)type {
    NSArray *imageArray = @[
        @"no_data",
        @"no_wifi",
        @"no_content",
        @"no_task",
    ];
    NSArray *textArray = @[
        @"暂无数据",
        @"没有网络",
        @"暂无内容",
        @"暂无任务",
    ];
    if (![self.noDataView isDescendantOfView:self.view]) {
        [self.view addSubview:self.noDataView];
    }
    self.noDataImageView.image = [UIImage imageNamed:imageArray[type]];
    self.noDataTipLabel.text = textArray[type];
}

/// 隐藏无数据视图
- (void)hideNoDataView {
    if ([self.noDataView isDescendantOfView:self.view]) {
        [self.noDataView removeFromSuperview];
    }
}

/// 显示没有数据的视图
- (void)showNoDataView {
    [self showNoDataViewWithType:NoDataTypeDefault];
}

#pragma mark - 监测网络环境
- (void)monitoredNetworkStatus {
    [[HttpRequest sharedInstance] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 显示无网络视图
        if (status == AFNetworkReachabilityStatusNotReachable) {
            [self showNoDataViewWithType:NoDataTypeNetwork];
        } else if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
            [self hideNoDataView];
        }
    }];
}


#pragma mark - 懒加载
- (UIView *)noDataView {
    if (!_noDataView) {
        _noDataView = [[UIView alloc] initWithFrame:self.view.bounds];
        _noDataView.backgroundColor = [UIColor whiteColor];
    }
    return _noDataView;
}

- (UIImageView *)noDataImageView {
    if (!_noDataImageView) {
        _noDataImageView = [[UIImageView alloc] init];
        _noDataImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.noDataView addSubview:_noDataImageView];
        [_noDataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(60);
            make.centerX.equalTo(self.noDataView.mas_centerX);
            make.centerY.equalTo(self.noDataView.mas_centerY).mas_offset(-20);
        }];
    }
    return _noDataImageView;
}

- (UILabel *)noDataTipLabel {
    if (!_noDataTipLabel) {
        _noDataTipLabel = [[UILabel alloc] init];
        _noDataTipLabel.font = [UIFont systemFontOfSize:15.0f];
        _noDataTipLabel.textColor = [UIColor colorWithRed:138/255.0 green:138/255.0 blue:138/255.0 alpha:1.0];
        _noDataTipLabel.textAlignment = NSTextAlignmentCenter;
        [self.noDataView addSubview:_noDataTipLabel];
        [_noDataTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.noDataView.mas_centerX);
            make.top.equalTo(self.noDataImageView.mas_bottom).mas_offset(10);
        }];
    }
    return _noDataTipLabel;
}

@end
