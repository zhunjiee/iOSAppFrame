//
//  RightImageButton.m
//  MengTianXia
//
//  Created by zl on 2019/8/14.
//  Copyright © 2019 qttx. All rights reserved.
//

#import "RightImageButton.h"

@implementation RightImageButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self exchangeImagAndTitlePosition];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self exchangeImagAndTitlePosition];
    }
    return self;
}

/**
 交换图片和标题位置
 */
- (void)exchangeImagAndTitlePosition {
    self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;        // 省略号在结尾
    self.imagePosition = SCCustomButtonImagePositionRight;      // 图片在右侧
    self.interTitleImageSpacing = 2;
}

@end
