//
//  AppViewController.swift
//  QShortVideo
//
//  Created by Houge on 2020/3/27.
//  Copyright © 2020 ZHUNJIEE. All rights reserved.
//

import UIKit

class AppViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
    }
}

// MARK: -  UI界面
extension AppViewController {
    // 导航栏
    fileprivate func setupNavigationBar() {
        navigationItem.title = "应用"
    }
}

// MARK: -  网络请求
extension AppViewController {
    
}

// MARK: -  事件监听
extension AppViewController {
    
}
