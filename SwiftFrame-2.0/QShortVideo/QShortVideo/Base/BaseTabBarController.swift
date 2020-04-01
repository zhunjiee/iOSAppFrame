//
//  BaseTabBarController.swift
//  QShortVideo
//
//  Created by Houge on 2020/3/26.
//  Copyright © 2020 QTTX. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTabBarItemAttributes()
        setUpAllChildViewController()
    }
    
    private func setUpAllChildViewController() {
        // 首页不加导航栏
        let homeVC = HomeViewController()
        setupOneChildViewController(homeVC, imageName: "btn_home_normal", selImageName: "btn_home_selected", title: "首页", noNavBar: true)
        let appVC = AppViewController()
        setupOneChildViewController(appVC, imageName: "btn_home_normal", selImageName: "btn_home_selected", title: "应用")
        let addVC = AddViewController()
        setupOneChildViewController(addVC, imageName: "btn_home_normal", selImageName: "btn_home_selected", title: "+")
        let zoneVC = ZoneViewController()
        setupOneChildViewController(zoneVC, imageName: "btn_home_normal", selImageName: "btn_home_selected", title: "社区")
        let mineVC = MineViewController()
        setupOneChildViewController(mineVC, imageName: "btn_home_normal", selImageName: "btn_home_selected", title: "我的")
    }
    
    /// 创建单个子控制器
    ///
    /// - Parameters:
    ///   - viewController: 子控制器
    ///   - imageName: tabbar正常显示图片
    ///   - selImageName: tabbar选中显示图片
    ///   - title: tabbar标题
    private func setupOneChildViewController(_ viewController: UIViewController, imageName: String, selImageName: String, title:String, noNavBar: Bool? = false) {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.selectedImage = UIImage(named: selImageName)?.withRenderingMode(.alwaysOriginal)
        let navController = noNavBar == true ? viewController : BaseNavigationController(rootViewController: viewController)
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
