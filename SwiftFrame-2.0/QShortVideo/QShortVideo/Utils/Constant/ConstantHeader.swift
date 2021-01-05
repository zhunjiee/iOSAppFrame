//
//  PrefixHeader.swift
//  swift-APP框架搭建
//
//  Created by zl on 2019/5/30.
//  Copyright © 2019 ZHUNJIEE. All rights reserved.
//

import UIKit

/// 判断是不是刘海屏
func isBangsScreen() -> Bool {
    var isBangsScreen = false
    if #available(iOS 11.0, *) {
        let window = UIApplication.shared.windows.first
        isBangsScreen = (window?.safeAreaInsets.bottom ?? 0.0) > 0
    }
    return isBangsScreen
}


/// 屏幕尺寸
let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height

// 状态栏的高度
let BWStatusBarHeight = UIApplication.shared.statusBarFrame.size.height
// 导航栏高度
let NavBarHeight: CGFloat = 44.0
// 状态栏和导航栏总高度
let NavBarAndStatusBarHeight: CGFloat = isBangsScreen() ? 88.0 : 64.0
// TabBar高度
let TabBarHeight: CGFloat = isBangsScreen() ? 49.0 + 34.0 : 49.0
// 顶部安全区域远离高度
let TopBarSafeHeight: CGFloat = isBangsScreen() ? 44.0 : 0.0
// 底部安全区域远离高度
let BottomSafeHeight: CGFloat = isBangsScreen() ? 34.0 : 0.0
// iPhoneX的状态栏高度差值
let TopBarDifHeight: CGFloat = isBangsScreen() ? 24.0 : 0.0
// 导航条和Tabbar总高度
let NavAndTabHeight = NavBarAndStatusBarHeight + TabBarHeight
// 控制器View区域去除导航栏和底部TbaBar后的高度
let ControllerViewHeight: CGFloat = ScreenHeight - NavAndTabHeight
// 控制器View区域去除导航栏后的高度
let ControllerViewNoNavBarHeight: CGFloat = ScreenHeight - NavBarAndStatusBarHeight

/// 颜色相关
func BWColor(_ r: Int, _ g: Int, _ b: Int) -> UIColor {
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
}
func BWAlphaColor(_ r: Int, _ g: Int, _ b: Int, _ a: Float) -> UIColor {
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(a / 1.0))
}

// 黑色字体
let BlackTextColor = BWColor(51, 51, 51)
// 灰色字体
let GrayTextColor = BWColor(153, 153, 153)


