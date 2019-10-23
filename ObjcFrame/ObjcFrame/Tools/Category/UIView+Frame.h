//
//  UIView+Frame.h
//  MengTianXia
//
//  Created by 侯宝伟 on 2019/3/1.
//  Copyright © 2019 zhunjiee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Frame)
@property(nonatomic, assign) CGFloat x;
@property(nonatomic, assign) CGFloat y;
@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) CGFloat height;

@property(nonatomic, assign) CGFloat centerX;
@property(nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

/** 控件上部边线的位置(minY的位置) */
@property (nonatomic, assign) CGFloat top;
/** 控件底部边线的位置(maxY的位置) */
@property (nonatomic, assign) CGFloat bottom;
/** 控件左部边线的位置(minX的位置) */
@property (nonatomic, assign) CGFloat left;
/** 控件右部边线的位置(maxX的位置) */
@property (nonatomic, assign) CGFloat right;

@end

NS_ASSUME_NONNULL_END
