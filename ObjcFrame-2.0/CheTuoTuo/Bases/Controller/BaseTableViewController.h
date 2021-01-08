//
//  BaseTableViewController.h
//  MengTianXIa
//
//  Created by zl on 2019/8/9.
//  Copyright © 2019 qttx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewController : UITableViewController
@property (assign, nonatomic) CGFloat sectionCornerRadius;

/// 退出当前控制器
- (void)popViewController;
@end

NS_ASSUME_NONNULL_END
