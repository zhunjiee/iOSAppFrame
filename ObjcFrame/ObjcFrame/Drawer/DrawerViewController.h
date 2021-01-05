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
@property (copy, nonatomic) NSString *leftNavImageName;
@property (copy, nonatomic) NSString *rightNavImageName;
@end

NS_ASSUME_NONNULL_END
