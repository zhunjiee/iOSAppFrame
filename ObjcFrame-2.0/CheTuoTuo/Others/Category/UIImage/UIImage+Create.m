//
//  UIImage+Extension.m
//  ProjectShortVideo
//
//  Created by Houge on 2020/4/2.
//  Copyright © 2020 QTTX. All rights reserved.
//

#import "UIImage+Create.h"

@implementation UIImage (Create)

+ (UIImage *)createImageWithColor:(UIColor *)color {
    return [self createImageWithColor:color size:CGSizeMake(1.0f, 1.0f)];
}

+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
