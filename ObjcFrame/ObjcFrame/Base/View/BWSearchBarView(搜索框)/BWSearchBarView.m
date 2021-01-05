//
//  BWSearchBarView.m
//  MengTianXia
//
//  Created by zl on 2019/8/14.
//  Copyright © 2019 qttx. All rights reserved.
//

#import "BWSearchBarView.h"

@interface BWSearchBarView () <UITextFieldDelegate>
@property (strong, nonatomic) UIView *searchView;
@property (strong, nonatomic) UIImageView *searchImage;
@end

@implementation BWSearchBarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.searchView = [[UIView alloc] init];
        self.searchView.backgroundColor = BWColor(244, 244, 244);
        
        self.searchImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_bar_icon"]];
        self.searchImage.contentMode = UIViewContentModeScaleAspectFit;
        
        self.searchField = [[UITextField alloc] init];
        self.searchField.font = [UIFont systemFontOfSize:14];
        self.searchField.textColor = TEXT_BLACK_COLOR;
        self.searchField.tintColor = TEXT_GRAY_COLOR;
        self.searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.searchField.returnKeyType = UIReturnKeySearch;
        self.searchField.delegate = self;
        [self.searchField addTarget:self action:@selector(searchTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        [self.searchView addSubview:self.searchImage];
        [self.searchView addSubview:self.searchField];
        [self addSubview:self.searchView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.searchView.frame = CGRectMake(0, 0, self.width, self.height);
    self.searchView.layer.cornerRadius = self.height * 0.5;
    self.searchView.layer.masksToBounds = YES;
    
    self.searchImage.frame = CGRectMake(10, 0, 15, 15);
    self.searchField.frame = CGRectMake(CGRectGetMaxX(self.searchImage.frame) + 10, 0, self.width - self.searchImage.width - 20, self.searchView.height);
    self.searchImage.centerY = self.searchField.centerY;
}

- (void)setPlaceholderString:(NSString *)placeholderString {
    self.searchField.placeholder = placeholderString;
}

- (void)setSearchString:(NSString *)searchString {
    self.searchField.text = searchString;
}


#pragma mark - UITextFieldDelegate

/// 开始搜索
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(searchBarView:beginSearchWithSearchTextField:)]) {
        [self.delegate searchBarView:self beginSearchWithSearchTextField:textField];
    }
}

/// 结束搜索
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(searchBarView:endSearchWithSearchTextField:)]) {
        [self.delegate searchBarView:self endSearchWithSearchTextField:textField];
    }
}

/// 搜索关键字改变
- (void)searchTextFieldDidChange:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(searchBarView:searchTextFieldDidChange:)]) {
        [self.delegate searchBarView:self searchTextFieldDidChange:textField.text];
    }
}

/// 点击搜索按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(searchBarView:didClickReturnKeyboardWithKeyword:)]) {
        [self.delegate searchBarView:self didClickReturnKeyboardWithKeyword:textField.text];
        [textField resignFirstResponder];
    }
    return YES;
}

@end
