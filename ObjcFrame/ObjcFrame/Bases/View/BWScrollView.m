//
//  BWScrollView.m
//  PaoTuiYu
//
//  Created by Houge on 2020/11/9.
//

#import "BWScrollView.h"

@implementation BWScrollView

/// 点击空白处退出键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

@end
