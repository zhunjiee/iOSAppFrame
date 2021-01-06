//
//  DrawerViewController.h
//  ObjcFrame
//
//  Created by Houge on 2021/1/5.
//  Copyright © 2021 ZHUNJIEE. All rights reserved.
//

#import "BaseViewController.h"
#import "MainViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DrawerViewController : BaseViewController
@property (assign, nonatomic) DrawerType type;              // 抽屉类型
@property (copy, nonatomic) NSString *leftNavImageName;     // 导航栏左侧按钮图片
@property (copy, nonatomic) NSString *rightNavImageName;    // 导航栏右侧按钮图片
@property (assign, nonatomic) BOOL scaleEffect;             // 是否缩放效果
@end

NS_ASSUME_NONNULL_END
