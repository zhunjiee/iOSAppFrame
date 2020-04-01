//
//  BWLoadingStyleManager.m
//  BWLoading
//
//  Created by BaoWei Hou on 16/04/2018.
//  Copyright © 2018 BaoWei Hou. All rights reserved.
//

#import "BWLoadingStyleManager.h"

@implementation BWLoadingStyleManager
static id _instance = nil;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+(instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
        [_instance defaultStyle];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone{
    return _instance;
}

-(id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

// hud的默认样式
- (void)defaultStyle {
    self.hudStyle = DimBackgroundStyle;
    self.hudShowTime = 2.0;
}

@end
