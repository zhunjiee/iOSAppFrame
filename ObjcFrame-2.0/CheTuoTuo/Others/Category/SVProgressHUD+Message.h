//
//  SVProgressHUD+Message.h
//  ProjectShortVideo
//
//  Created by Houge on 2020/6/4.
//  Copyright © 2020 QTTX. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface SVProgressHUD (Message)

/// 显示文字信息,不带图片
+ (void)showMessage:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
