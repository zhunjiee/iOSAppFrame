//
//  BaseViewController.m
//  MengTianXIa
//
//  Created by zl on 2019/8/9.
//  Copyright © 2019 qttx. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

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
    
    [self hideNoDataView];
}

- (void)popViewController {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)showNoDataViewWithType:(NoDataType)type {
    UIView *noDataView = [[UIView alloc] initWithFrame:self.view.bounds];
    
    UIImageView *showImageView = [[UIImageView alloc] init];
    showImageView.contentMode = UIViewContentModeScaleAspectFill;
    [noDataView addSubview:showImageView];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.font = [UIFont systemFontOfSize:15.0f];
    tipLabel.textColor = [UIColor colorWithRed:138/255.0 green:138/255.0 blue:138/255.0 alpha:1.0];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [noDataView addSubview:tipLabel];
    
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
    showImageView.image = [UIImage imageNamed:imageArray[type]];
    tipLabel.text = textArray[type];
    
    [showImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(60);
        make.centerX.mas_equalTo(noDataView.mas_centerX);
        make.centerY.mas_equalTo(noDataView.mas_centerY).mas_offset(-20);
    }];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(noDataView.mas_centerX);
        make.top.mas_equalTo(showImageView.mas_bottom).mas_offset(10);
    }];
    self.noDataView = noDataView;
    [self.view addSubview:noDataView];
}

- (void)showNoDataView {
    [self showNoDataViewWithType:NoDataTypeDefault];
}

- (void)hideNoDataView {
    [self.noDataView removeFromSuperview];
}

@end
