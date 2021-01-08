//
//  UIView+Extension.h
//  ObjcFrame
//
//  Created by Houge on 2020/3/30.
//  Copyright © 2020 ZHUNJIEE. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Extension)

/// 获取当前显示的控制器
- (UIViewController *)getCurrentViewController;

/// 添加背景渐变色
- (void)insertGradientLayer;

@end

NS_ASSUME_NONNULL_END
