//
//  UIImage+Circle.h
//  MengTianXia
//
//  Created by 侯宝伟 on 2019/5/15.
//  Copyright © 2019 ZHUNJIEE. All rights reserved.
//
// 图片剪裁圆角

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Circle)

/**
 剪裁圆形图片

 @return 剪裁完的图片
 */
- (UIImage *)circleImage;


/**
 剪裁带有圆角的图片,也可剪裁成圆形的图片,取决于 radius

 @param radius 圆角大小
 @return 剪裁好的图片
 */
- (UIImage *)clipImageWithCornerRadius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END
