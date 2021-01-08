//
//  CALayer+Extension.m
//  MengTianXia
//
//  Created by zl on 2019/8/14.
//  Copyright © 2019 qttx. All rights reserved.
//

#import "CALayer+Extension.h"

@implementation CALayer (Extension)

/**
 为了兼容在storyboard中设置的KVC颜色生效
 
 使用方法: layer.borderColorFromUIColor

 @param color UIColor
 */
- (void)setBorderColorFromUIColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}


/// 设置阴影颜色
/// @param color UIColor
- (void)setShadowColorFromUIColor:(UIColor *)color {
    self.shadowColor = color.CGColor;
}

/// 设置背景颜色
/// @param color UIColor
- (void)setBackgroundColorFromUIColor:(UIColor *)color {
    self.backgroundColor = color.CGColor;
}

@end
