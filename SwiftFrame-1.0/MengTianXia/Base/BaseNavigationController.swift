//
//  MyNavigationController.swift
//  swift-APP框架搭建
//
//  Created by zl on 2019/5/30.
//  Copyright © 2019 ZHUNJIEE. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        
        // 启用左滑返回手势
        interactivePopGestureRecognizer?.delegate = self
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 {
            // 跳转后隐藏底部tabbar
            viewController.hidesBottomBarWhenPushed = true
            
            // 自定义返回按钮样式
            let backBtn = UIButton(type: .custom)
            backBtn.setImage(UIImage(named: "nav_back_btn_n"), for: .normal)
            backBtn.setImage(UIImage(named: "nav_back_btn_n"), for: .highlighted)
            backBtn.setTitle("返回", for: .normal)
            backBtn.setTitleColor(UIColor.orange, for: .normal)
            backBtn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 10)
            backBtn.sizeToFit()
            backBtn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    
    /// 启用左滑返回手势
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return children.count > 1
    }
}

// MARK: UI界面
extension BaseNavigationController {
    fileprivate func setUpNavigationBar() {
        let navBar = UINavigationBar.appearance()
        // 取消毛玻璃效果
        navBar.isTranslucent = false
        // 去除分割线
        navBar.shadowImage = UIImage()
        navBar.setBackgroundImage(UIImage(), for: .default)
        // 设置标题文字属性
        var attrs = [NSAttributedString.Key : Any]()
        attrs[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 18.0)
        navBar.titleTextAttributes = attrs
    }
}

// MARK: 事件监听
extension BaseNavigationController {
    /// 返回前一个界面
    @objc func goBack() {
        popViewController(animated: true)
    }
}
