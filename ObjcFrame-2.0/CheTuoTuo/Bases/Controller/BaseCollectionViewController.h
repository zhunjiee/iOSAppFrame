//
//  BaseCollectionViewController.h
//  ObjcFrame
//
//  Created by zl on 2019/10/23.
//  Copyright © 2019 ZHUNJIEE. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseCollectionViewController : UICollectionViewController
@property (assign, nonatomic) BOOL clearNavigationBar;      // 导航栏透明

/// 退出当前控制器
- (void)popViewController;

/// 不同类型的暂无数据视图
/// @param type 暂无数据类型
- (void)showNoDataViewWithType:(NoDataType)type;

/// 隐藏暂无数据视图
- (void)hideNoDataView;

/// 显示暂无数据视图-暂无数据
- (void)showNoDataView;

@end

NS_ASSUME_NONNULL_END
