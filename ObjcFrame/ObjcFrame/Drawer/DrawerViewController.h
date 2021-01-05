//
//  DrawerViewController.h
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

@interface DrawerViewController : BaseViewController
@property (assign, nonatomic) DrawerType type;              // 抽屉类型
@end

NS_ASSUME_NONNULL_END
