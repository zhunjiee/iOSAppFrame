//
//  MJExtensionConfig.m
//  YouyouDache
//
//  Created by zl on 2019/6/11.
//  Copyright © 2019 杨允恩. All rights reserved.
//

#import "MJExtensionConfig.h"
#import <MJExtension.h>

@implementation MJExtensionConfig

+ (void)load {
    // MJExtension 统一设置模型中的属性名和字典中的key不相同的问题
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID" : @"id",
                 @"NewPassword" : @"newPassword",
                 @"Description" : @"description",
                 };
    }];
}

@end
