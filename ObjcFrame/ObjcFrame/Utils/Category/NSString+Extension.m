//
//  NSString+Extension.m
//  ObjcFrame
//
//  Created by Houge on 2021/1/5.
//  Copyright © 2021 ZHUNJIEE. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
/// 是否是空字符串
- (BOOL)isEmpty {
    if (self == nil ||
        self == NULL ||
        [self isEqual:NULL] ||
        [self isEqual:@"NULL"] ||
        [self isEqual:[NSNull null]] ||
        [self isEqualToString:@"<null>"] ||
        [self isEqualToString:@"(null)"] ||
        [self isKindOfClass:[NSNull class]] ||
        [[self class] isSubclassOfClass:[NSNull class]] ||
        [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
            return YES;
         } else {
             return NO;
         }
}
@end
