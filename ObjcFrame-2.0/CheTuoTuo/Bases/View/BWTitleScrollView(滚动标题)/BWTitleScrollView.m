//
//  BWScrollTitleView.m
//  MengTianXia
//
//  Created by zl on 2019/8/19.
//  Copyright © 2019 qttx. All rights reserved.
//

#import "BWTitleScrollView.h"

@interface BWTitleScrollView ()
@property (strong, nonatomic) UIView *titleView;        // 存放所有按钮的视图
@property (strong, nonatomic) NSArray *titleArray;   // 标题数组,必传
@property (strong, nonatomic) NSMutableArray *titleButtonArray;     // 标题按钮数组, 用于外部获取对应的按钮
@property (strong, nonatomic) UIView *separateLine;     // 底部分割线
@property (nonatomic, strong) UIView *titleIndicatorView;       // 按钮底部指示器
@property (assign, nonatomic) CGFloat titleButtonWidth;        // 每个按钮的宽度
@end

@implementation BWTitleScrollView

#pragma mark - 初始化

+ (BWTitleScrollView *)titleScrollViewWithFrame:(CGRect)frame delegate:(id<BWTitleScrollViewDelegate>)delegate titleStringArray:(NSArray *)titleArray showCount:(NSInteger)count {
    BWTitleScrollView *titleView = [[BWTitleScrollView alloc] initWithFrame:frame];
    if (count == 0) {
        titleView.titleButtonWidth = 87;
    } else {
        titleView.titleButtonWidth = frame.size.width / count;
    }
    
    titleView.titleArray = titleArray;
    titleView.delegate = delegate;
    
    return titleView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.changeTextColor = YES;
        [self createViewWithFrame:frame];
    }
    return self;
}

- (void)createViewWithFrame:(CGRect)frame {
    self.backgroundColor = [UIColor whiteColor];
    self.titleButtonArray = [NSMutableArray array];
    // 最底部分割线
    UIView *separateLine = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 0.5, frame.size.width, 0.5)];
    separateLine.backgroundColor = LINE_GRAY_COLOR;
    [self addSubview:separateLine];
    self.separateLine = separateLine;
}

- (void)setTitleArray:(NSMutableArray *)titleArray {
    [self setupTitleViewWithTitleArray:titleArray];
}

/**
 添加标题视图
 */
- (void)setupTitleViewWithTitleArray:(NSMutableArray *)array {
    UIScrollView *titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    titleScrollView.showsVerticalScrollIndicator = NO;
    titleScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:titleScrollView];
    self.titleScrollView = titleScrollView;
    
    NSInteger count = array.count;
    titleScrollView.contentSize = CGSizeMake(self.titleButtonWidth * count, 0);
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.titleButtonWidth * count, self.height)];
    [titleScrollView addSubview:titleView];
    self.titleView = titleView;
    
    // 创建标题按钮
    for (int i = 0; i < count; i++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.frame = CGRectMake(self.titleButtonWidth * i, 0, self.titleButtonWidth, self.height);
        titleButton.tag = i;
        [titleButton setTitle:array[i] forState:UIControlStateNormal];
        [titleButton setTitleColor:TEXT_BLACK_COLOR forState:UIControlStateNormal];
        if (self.changeTextColor) {
            [titleButton setTitleColor:THEME_COLOR forState:UIControlStateSelected];
        }
        [titleButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [titleView addSubview:titleButton];
        [titleButton addTarget:self action:@selector(titleButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleButtonArray addObject:titleButton];
    }
    
    // 创建标题按钮底部指示器
    UIView *titleIndicatorView = [[UIView alloc] init];
    UIButton *firstTitleButton = titleView.subviews.firstObject;
    // 设置指示器颜色
    titleIndicatorView.backgroundColor = THEME_COLOR;
    titleIndicatorView.height = 3;
    titleIndicatorView.width = [firstTitleButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]}].width;
    titleIndicatorView.centerX = firstTitleButton.centerX;
    titleIndicatorView.y = firstTitleButton.height - titleIndicatorView.height - 2;
    [titleView addSubview:titleIndicatorView];
    self.titleIndicatorView = titleIndicatorView;
    
    // 默认选中第一行
    firstTitleButton.selected = YES;
    self.selectedButton = firstTitleButton;
}

- (void)selectTitleButtonWithIndex:(NSInteger)index {
    UIButton *titleButton = self.titleButtonArray[index];
    [self dealTitleButtonClick:titleButton];
}


#pragma mark - 监听方法

- (void)titleButtonDidClick:(UIButton *)titleButton {
    [self dealTitleButtonClick:titleButton];
    
    if ([self.delegate respondsToSelector:@selector(bw_titleScrollView:clickTitleButtonWithIndex:)]) {
        [self.delegate bw_titleScrollView:self clickTitleButtonWithIndex:titleButton.tag];
    }
}

- (void)dealTitleButtonClick:(UIButton *)titleButton {
    // 设置被选中按钮
    self.selectedButton.selected = NO;
    titleButton.selected = YES;
    self.selectedButton = titleButton;
    
    // 指示器跟随移动
    [UIView animateWithDuration:0.25 animations:^{
        self.titleIndicatorView.centerX = titleButton.centerX;
    }];
    
    // 判断标题滚动视图是否要自动滚动
    if (self.selectedButton.x + titleButton.width > self.width) {
        CGFloat offsetX = self.selectedButton.x + titleButton.width - self.width;
        [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        
    }else{
        [self.titleScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}


#pragma mark - Setter方法

- (void)setShowBottomSeparatedLine:(BOOL)showBottomSeparatedLine {
    _showBottomSeparatedLine = showBottomSeparatedLine;
    
    if (showBottomSeparatedLine) {
        self.separateLine.hidden = NO;
    } else {
        self.separateLine.hidden = YES;
    }
}
- (void)setShowTitleIndicatorView:(BOOL)showTitleIndicatorView {
    _showTitleIndicatorView = showTitleIndicatorView;
    
    if (showTitleIndicatorView) {
        self.titleIndicatorView.hidden = NO;
    } else {
        self.titleIndicatorView.hidden = YES;
    }
}

- (void)setButtonNormalColor:(UIColor *)buttonNormalColor {
    _buttonNormalColor = buttonNormalColor;
    
    for (UIButton *button in self.titleButtonArray) {
        [button setTitleColor:buttonNormalColor forState:UIControlStateNormal];
    }
}
- (void)setButtonSelectedColor:(UIColor *)buttonSelectedColor {
    _buttonSelectedColor = buttonSelectedColor;
    
    for (UIButton *button in self.titleButtonArray) {
        [button setTitleColor:buttonSelectedColor forState:UIControlStateSelected];
    }
}

- (void)setIndecatorColor:(UIColor *)indecatorColor {
    _indecatorColor = indecatorColor;
    
    self.titleIndicatorView.backgroundColor = indecatorColor;
}

- (void)setIndecatorWidth:(CGFloat)indecatorWidth {
    _indecatorWidth = indecatorWidth;
    
    self.titleIndicatorView.width = indecatorWidth;
    self.titleIndicatorView.centerX = self.selectedButton.centerX;
}

- (void)setChangeTextColor:(BOOL)changeTextColor {
    _changeTextColor = changeTextColor;
    
    for (UIButton *titleButton in self.titleButtonArray) {
        [titleButton setTitleColor:TEXT_BLACK_COLOR forState:UIControlStateSelected];
    }
}

@end
