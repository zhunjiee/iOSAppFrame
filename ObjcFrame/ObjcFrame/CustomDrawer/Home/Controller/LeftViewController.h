//
//  LeftViewController.h
//  ObjcFrame
//
//  Created by Houge on 2021/1/5.
//  Copyright © 2021 ZHUNJIEE. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LeftViewController : BaseTableViewController
@property (copy, nonatomic) void (^leftMenuViewClickBlock)(NSInteger index);     // 点击菜单视图cell
@end

NS_ASSUME_NONNULL_END
