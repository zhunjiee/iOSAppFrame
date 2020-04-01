//
//  MyTabBarController.swift
//  swift-APP框架搭建
//
//  Created by zl on 2019/5/30.
//  Copyright © 2019 ZHUNJIEE. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTabBarItemAttributes()
        setUpAllChildViewController()
    }
    
    
    /// 创建全部的子控制器
    func setUpAllChildViewController() {
        let homeVC = HomeViewController()
        setUpOneChildViewController(viewController: homeVC, imageName: "btn_home_normal", selImageName: "btn_home_selected", title: "首页")
        
        let newsVC = NewsViewController()
        setUpOneChildViewController(viewController: newsVC, imageName: "btn_column_normal", selImageName: "btn_column_selected", title: "新闻资讯")
        
        let messageVC = MessageViewController()
        setUpOneChildViewController(viewController: messageVC, imageName: "btn_follow_normal", selImageName: "btn_follow_selected", title: "消息")
        
        let memberVC = MemberViewController()
        setUpOneChildViewController(viewController: memberVC, imageName: "btn_user_normal", selImageName: "btn_user_selected", title: "会员中心")
    }
    
    /// 创建单个子控制器
    ///
    /// - Parameters:
    ///   - viewController: 子控制器
    ///   - imageName: tabbar正常显示图片
    ///   - selImageName: tabbar选中显示图片
    ///   - title: tabbar标题
    func setUpOneChildViewController(viewController: UIViewController, imageName: String, selImageName: String, title:String) {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.selectedImage = UIImage(named: selImageName)?.withRenderingMode(.alwaysOriginal)
        let navController = BaseNavigationController(rootViewController: viewController)
        addChild(navController)
    }

}

// MARK: 设置UI界面
extension BaseTabBarController {
    /// 设置tabbar样式
    fileprivate func setUpTabBarItemAttributes() {
        let tabBar = UITabBar.appearance()
        // 取消毛玻璃效果
        tabBar.isTranslucent = false
        // 去除分割线
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        
        // 设置文字颜色
        let item = UITabBarItem.appearance()
        // 设置正常颜色
        var normalAttrs = [NSAttributedString.Key : Any]()
        normalAttrs[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 12)
        normalAttrs[NSAttributedString.Key.foregroundColor] = BWColor(208, 208, 208)
        item.setTitleTextAttributes(normalAttrs, for: .normal)
        // 设置选中颜色
        var selAttrs = [NSAttributedString.Key : Any]()
        selAttrs[NSAttributedString.Key.foregroundColor] = UIColor.orange
        item.setTitleTextAttributes(selAttrs, for: .selected)
    }
}
