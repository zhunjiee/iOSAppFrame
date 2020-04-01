//
//  MineViewController.swift
//  QShortVideo
//
//  Created by Houge on 2020/3/27.
//  Copyright © 2020 ZHUNJIEE. All rights reserved.
//

import UIKit

class MineViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }
}

// MARK: -  UI界面
extension MineViewController {
    // 导航栏
    fileprivate func setupNavigationBar() {
        navigationItem.title = "我的"
    }
}

// MARK: -  网络请求
extension MineViewController {
    
}

// MARK: -  事件监听
extension MineViewController {
    
}
