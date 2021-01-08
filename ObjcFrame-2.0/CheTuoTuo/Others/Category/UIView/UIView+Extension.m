//
//  UIView+Extension.m
//  ObjcFrame
//
//  Created by Houge on 2020/3/30.
//  Copyright © 2020 ZHUNJIEE. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

#pragma mark - 当前控制器

/// 获取当前显示的控制器
- (UIViewController *)getCurrentViewController {
    UIResponder *next = self.nextResponder;
    do {
        //判断响应者是否为视图控制器
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
    } while (next != nil);
    
    return nil;
}

/// 添加背景渐变色
- (void)insertGradientLayer {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    gradientLayer.colors = @[
        (__bridge id)BWColor(1, 244, 109).CGColor,
        (__bridge id)BWColor(15, 195, 97).CGColor,
    ];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0.0, 0.0);
    gradientLayer.endPoint = CGPointMake(1.0, 1.0);
    [self.layer insertSublayer:gradientLayer atIndex:0];
}

@end
