//
//  BWSearchBarView.h
//  MengTianXia
//
//  Created by zl on 2019/8/14.
//  Copyright © 2019 qttx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BWSearchBarView;
@protocol BWSearchBarViewDelegate <NSObject>
@optional

/// 开始搜索
- (void)searchBarView:(BWSearchBarView *)searchBarView beginSearchWithSearchTextField:(UITextField *)textField;
/// 结束搜索
- (void)searchBarView:(BWSearchBarView *)searchBarView endSearchWithSearchTextField:(UITextField *)textField;
/// 搜索关键字改变
- (void)searchBarView:(BWSearchBarView *)searchBarView searchTextFieldDidChange:(NSString *)keyword;
/// 点击了搜索按钮
- (void)searchBarView:(BWSearchBarView *)searchBarView didClickReturnKeyboardWithKeyword:(NSString *)keyword;

@end

@interface BWSearchBarView : UIView
@property (weak, nonatomic) id<BWSearchBarViewDelegate> delegate;
@property (strong, nonatomic) UITextField *searchField;
@property (copy, nonatomic) NSString *placeholderString;
@property (copy, nonatomic) NSString *searchString;
@end

NS_ASSUME_NONNULL_END
