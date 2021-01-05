//
//  UICollectionView+NoData.h
//  ProjectShortVideo
//
//  Created by Houge on 2020/7/22.
//  Copyright © 2020 QTTX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableView+NoData.h"

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (NoData)

/// 暂无数据
- (void)showNoDataView;

/// 不同类型的暂无数据
/// @param type 暂无数据类型
- (void)showNoDataViewWithType:(NoDataType)type;

/// 隐藏暂无数据视图
- (void)hideNoDataView;

@end

NS_ASSUME_NONNULL_END
