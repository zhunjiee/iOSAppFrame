//
//  HomeViewController.swift
//  QShortVideo
//
//  Created by Houge on 2020/3/27.
//  Copyright © 2020 ZHUNJIEE. All rights reserved.
//

import UIKit
import PLPlayerKit

// MARK: -  初始化
class HomeViewController: BaseViewController {
    
    
    // MARK: -  懒加载
    lazy var playerVC: PlayerViewController = {
        return PlayerViewController()
    }()

    
    // MARK: -  生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerVC.url = "http://demo-videos.qnsdk.com/shortvideo/super.mp4"
        view.addSubview(playerVC.view)
    }
    
    @objc func switchTypeBtnDidClick(button: UIButton) {
        print("hahahha")
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    deinit {
        
    }
}

// MARK: -  UI界面
extension HomeViewController {
    // 修改状态栏颜色为白色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: -  网络请求
extension HomeViewController {
    
}

// MARK: -  事件监听
extension HomeViewController {
    
}
