//
//  UIButton+Utils.m
//  ychat
//
//  Created by 孙俊 on 2017/12/3.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import "UIButton+Utils.h"

@implementation UIButton (Utils)

+ (UIButton *)buttonWithBackgroundImage:(NSString *)imageName taget:(id)taget action:(SEL)action{
    UIButton * button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)buttonWithImage:(NSString *)imageName taget:(id)taget action:(SEL)action {
    UIButton * button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)buttonWithTitle:(NSString *)title taget:(id)taget action:(SEL)action font:(UIFont *)titleFont titleColor:(UIColor *)titleColor {
    UIButton * button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = titleFont;
    [button addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}
@end
