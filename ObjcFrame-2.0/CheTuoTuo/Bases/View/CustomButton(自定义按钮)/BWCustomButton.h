//
//  BWCustomButton.h
//  MengTianXia
//
//  Created by zl on 2019/8/24.
//  Copyright © 2019 qttx. All rights reserved.
//
// 自定义按钮,可自定义图片与文字的位置

#import <UIKit/UIKit.h>

/// 图片和文字的相对位置
typedef NS_ENUM(NSInteger, SCCustomButtonImagePosition) {
    SCCustomButtonImagePositionTop,     // 图片在文字顶部
    SCCustomButtonImagePositionLeft,    // 图片在文字左侧
    SCCustomButtonImagePositionBottom,  // 图片在文字底部
    SCCustomButtonImagePositionRight    // 图片在文字右侧
};


/**
 自定义按钮，可控制图片文字间距
 
 使用方法：
 @code
 BWCustomButton *button = [[BWCustomButton alloc] initWithFrame:CGRectMake(50, 50, 50, 30)];
 button.imagePosition = SCCustomButtonImagePositionLeft;  // 图文布局方式
 button.interTitleImageSpacing = 5;                       // 图文间距
 button.imageCornerRadius = 15;                           // 图片圆角半径
 button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;  // 内容对齐方式
 [self addSubview:button];
 @endcode
 */

NS_ASSUME_NONNULL_BEGIN

@interface BWCustomButton : UIButton
@property (assign, nonatomic) CGFloat interTitleImageSpacing;  ///< 图片文字间距
@property (assign, nonatomic) SCCustomButtonImagePosition imagePosition;     ///< 图片和文字的相对位置
@property (assign, nonatomic) CGFloat imageCornerRadius;                     ///< 图片圆角半径
@end

NS_ASSUME_NONNULL_END
