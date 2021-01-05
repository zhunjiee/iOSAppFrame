//
//  MainViewController.h
//  ObjcFrame
//
//  Created by Houge on 2021/1/5.
//  Copyright © 2021 ZHUNJIEE. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainViewController : BaseViewController
@property (copy, nonatomic) void (^mainVcMenuNavBtnDidClick)(UIButton *button);
@property (copy, nonatomic) void (^mainVcMessageNavBtnDidClick)(UIButton *button);
@end

NS_ASSUME_NONNULL_END
