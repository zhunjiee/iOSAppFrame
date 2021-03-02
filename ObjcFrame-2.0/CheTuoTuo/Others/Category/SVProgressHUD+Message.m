//
//  SVProgressHUD+Message.m
//  ProjectShortVideo
//
//  Created by Houge on 2020/6/4.
//  Copyright © 2020 QTTX. All rights reserved.
//

#import "SVProgressHUD+Message.h"

@implementation SVProgressHUD (Message)

+ (void)showMessage:(NSString *)message {
    [self showImage:nil status:message];
}

@end
