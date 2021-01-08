//
//  AppDelegate.h
//  CheTuoTuo
//
//  Created by Houge on 2021/1/6.
//

#import <UIKit/UIKit.h>

/// 框架类型
typedef NS_ENUM(NSUInteger, FrameType) {
    FrameTypeTabBar,    // 普通TabBar类型
    FrameTypeViewDeck,  // 侧边菜单覆盖
    FrameTypeMMDrawer,  // 侧边菜单切主页跟随移动
};

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

