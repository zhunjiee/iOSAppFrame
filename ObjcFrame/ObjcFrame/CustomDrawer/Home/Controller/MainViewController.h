//
//  MainViewController.h
//  ObjcFrame
//
//  Created by Houge on 2021/1/5.
//  Copyright © 2021 ZHUNJIEE. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DrawerType) {
    DrawerTypeDefault,  // 左右都显示
    DrawerTypeLeft,     // 只显示左边
    DrawerTypeRight,    // 只显示右边
};

@interface MainViewController : BaseViewController
@property (assign, nonatomic) DrawerType type;
@property (copy, nonatomic) NSString *leftNavImageName;
@property (copy, nonatomic) NSString *rightNavImageName;

@property (copy, nonatomic) void (^mainVcMenuNavBtnClickBlock)(UIButton *button);     // 点击左侧导航按钮
@property (copy, nonatomic) void (^mainVcMessageNavBtnClickBlock)(UIButton *button);  // 点击右侧导航按钮

@end

NS_ASSUME_NONNULL_END
