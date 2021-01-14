//
//  BWScrollTitleView.h
//  MengTianXia
//
//  Created by zl on 2019/8/19.
//  Copyright © 2019 qttx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BWTitleScrollView;

NS_ASSUME_NONNULL_BEGIN

@protocol BWTitleScrollViewDelegate <NSObject>

/**
 点击了哪个按钮

 @param index 按钮索引
 */
@optional
- (void)bw_titleScrollView:(BWTitleScrollView *)titleScrollView clickTitleButtonWithIndex:(NSInteger)index;

@end

@interface BWTitleScrollView : UIView
@property (weak, nonatomic) id<BWTitleScrollViewDelegate> delegate;
@property (strong, nonatomic) UIScrollView *titleScrollView;        // 标题滚动视图
@property (assign, nonatomic) BOOL showBottomSeparatedLine;    // 是否显示底部分割线, 默认显示
@property (assign, nonatomic) BOOL showTitleIndicatorView;    // 是否显示底部分指示器, 默认显示
@property (nonatomic, strong) UIButton *selectedButton;     // 被选中的标题按钮
@property (strong, nonatomic) UIColor *buttonNormalColor;   // 按钮正常颜色
@property (strong, nonatomic) UIColor *buttonSelectedColor;     // 按钮选中颜色
@property (strong, nonatomic) UIColor *indecatorColor;      // 指示器颜色
@property (assign, nonatomic) CGFloat indecatorWidth;       // 指示器宽度
@property (assign, nonatomic) BOOL changeTextColor;         // 是否改变文字颜色, 默认为YES


/**
 创建控件的方法

 @param frame frame
 @param titleArray 标题数组, 必传]
 @param count 屏幕显示的最大个数, 用以计算每个按钮的宽度, 传0使用默认宽度87
 @return 标题控件
 */
+ (BWTitleScrollView *)titleScrollViewWithFrame:(CGRect)frame delegate:(id<BWTitleScrollViewDelegate>)delegate titleStringArray:(NSArray *)titleArray showCount:(NSInteger)count;

/**
 选中按钮

 @param index 按钮索引
 */
- (void)selectTitleButtonWithIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
