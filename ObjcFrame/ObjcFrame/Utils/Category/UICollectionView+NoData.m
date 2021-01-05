//
//  UICollectionView+NoData.m
//  ProjectShortVideo
//
//  Created by Houge on 2020/7/22.
//  Copyright © 2020 QTTX. All rights reserved.
//

#import "UICollectionView+NoData.h"

@implementation UICollectionView (NoData)

- (void)showNoDataViewWithType:(NoDataType)type {
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    UIImageView *showImageView = [[UIImageView alloc] init];
    showImageView.contentMode = UIViewContentModeScaleAspectFill;
    [backgroundView addSubview:showImageView];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.font = [UIFont systemFontOfSize:15.0f];
    tipLabel.textColor = [UIColor colorWithRed:138/255.0 green:138/255.0 blue:138/255.0 alpha:1.0];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [backgroundView addSubview:tipLabel];
    
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
        make.centerX.mas_equalTo(backgroundView.mas_centerX);
        make.centerY.mas_equalTo(backgroundView.mas_centerY).mas_offset(-20);
    }];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(backgroundView.mas_centerX);
        make.top.mas_equalTo(showImageView.mas_bottom).mas_offset(10);
    }];
    
    self.backgroundView = backgroundView;
}

- (void)showNoDataView {
    [self showNoDataViewWithType:NoDataTypeDefault];
}

- (void)hideNoDataView {
    UIView *bgcView = [[UIView alloc] initWithFrame:self.bounds];
    bgcView.backgroundColor = [UIColor whiteColor];
    self.backgroundView = bgcView;
}

@end
