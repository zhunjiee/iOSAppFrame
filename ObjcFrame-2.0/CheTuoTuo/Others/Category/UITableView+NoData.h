//
//  UITableView+NoData.h
//  ProjectShortVideo
//
//  Created by Houge on 2020/7/22.
//  Copyright © 2020 QTTX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, NoDataType) {
    NoDataTypeDefault,  // 暂无数据
    NoDataTypeNetwork,  // 没有网络
    NoDataTypeContent,  // 没有内容
    NoDataTypeTask,     // 暂无任务
};

@interface UITableView (NoData)

/// 暂无数据
- (void)showNoDataView;

/// 不同类型的暂无数据
/// @param type 暂无数据类型
- (void)showNoDataViewWithType:(NoDataType)type;

/// 隐藏暂无数据视图
- (void)hideNoDataView;

@end

NS_ASSUME_NONNULL_END
