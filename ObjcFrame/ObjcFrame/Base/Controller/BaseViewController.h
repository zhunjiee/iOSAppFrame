//
//  BaseViewController.h
//  MengTianXIa
//
//  Created by zl on 2019/8/9.
//  Copyright © 2019 qttx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HideNavigationBarProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
@property (strong, nonatomic) UIView *noDataView;

/// 退出当前控制器
- (void)popViewController;

/// 暂无数据
- (void)showNoDataView;

/// 不同类型的暂无数据
/// @param type 暂无数据类型
- (void)showNoDataViewWithType:(NoDataType)type;

/// 隐藏暂无数据视图
- (void)hideNoDataView;
@end

NS_ASSUME_NONNULL_END
