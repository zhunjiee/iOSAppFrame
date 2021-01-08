//
//  UIButton+Utils.h
//  ychat
//
//  Created by 孙俊 on 2017/12/3.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Utils)

+ (UIButton *)buttonWithBackgroundImage:(NSString *)imageName taget:(id)taget action:(SEL)action;

+ (UIButton *)buttonWithImage:(NSString *)imageName taget:(id)taget action:(SEL)action;

+ (UIButton *)buttonWithTitle:(NSString *)title taget:(id)taget action:(SEL)action font:(UIFont *)titleFont titleColor:(UIColor *)titleColor;

@end
