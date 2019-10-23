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

 @param color UIColor
 */
- (void)setBorderColorFromUIColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}

- (void)setShadowColorFromUIColor:(UIColor *)color {
    self.shadowColor = color.CGColor;
}

@end
