//
//  BWLoadingStyleManager.h
//  BWLoading
//
//  Created by BaoWei Hou on 16/04/2018.
//  Copyright © 2018 BaoWei Hou. All rights reserved.
//  一个配置loading样式的单例

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 hud的样式

 - light_background_style: 白色背景
 - dim_background_style: 黑色背景
 */
typedef NS_ENUM(NSInteger, CustomHudStyle) {
    LightBackgroundStyle = 0,
    DimBackgroundStyle,
};

@interface BWLoadingStyleManager : NSObject

@property(nonatomic, assign) CustomHudStyle hudStyle;
@property(nonatomic, assign) NSTimeInterval hudShowTime;

+(instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
