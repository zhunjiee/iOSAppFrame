//
//  UIImage+Extension.h
//  ProjectShortVideo
//
//  Created by Houge on 2020/4/2.
//  Copyright © 2020 QTTX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Create)

#pragma mark - 生成图片

/// 根据颜色生成size为(1, 1)的纯色图片, 适用于平铺场景
/// @param color 指定颜色
+ (UIImage *)createImageWithColor:(UIColor *)color;

/// 根据颜色生成指定大小的图片
/// @param color 指定颜色
/// @param size 指定尺寸
+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
