//
//  UIView+CornerAndBorder.h
//  ObjcFrame
//
//  Created by Houge on 2020/3/30.
//  Copyright © 2020 ZHUNJIEE. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, UIBorderSideType) {
    UIBorderSideTypeAll  = 0,
    UIBorderSideTypeTop = 1 << 0,
    UIBorderSideTypeBottom = 1 << 1,
    UIBorderSideTypeLeft = 1 << 2,
    UIBorderSideTypeRight = 1 << 3,
};

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CornerAndBorder)

#pragma mark - corner圆角

/// 剪裁圆角(只能剪裁,不能改变位置和大小)
/// @param corners 需要剪裁的角    可同时取多个值 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
/// @param radii 圆角大小(半径)
- (void)clipRoundedCorners:(UIRectCorner)corners withRadii:(CGSize)radii;

/// 剪裁圆角, 并能改变view的位置及大小
/// @param corners 需要剪裁的角
/// @param radii 剪裁圆角大小
/// @param rect 设置view的位置及大小
- (void)clipRoundedCorners:(UIRectCorner)corners withRadii:(CGSize)radii withRect:(CGRect)rect;


#pragma mark - border边框

/// 只绘制一个边的border 的方法
/// @param color 边框颜色
/// @param borderWidth 边框宽度
/// @param borderType 绘制哪个边框
- (UIView *)borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(UIBorderSideType)borderType;

@end

NS_ASSUME_NONNULL_END
