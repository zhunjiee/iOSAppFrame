//
//  NewsViewController.swift
//  MengTianXia
//
//  Created by zl on 2019/7/25.
//  Copyright © 2019 LuMeng. All rights reserved.
//

import UIKit

class NewsViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "新闻资讯"
        view.backgroundColor = UIColor.blue
        
        let btn = UIButton(type: .system)
        btn.setTitle("Toast Show Success", for: .normal)
        btn.frame = CGRect(x: 100, y: 100, width: 200, height: 30)
        btn.addTarget(self, action: #selector(btnDidClick), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    @objc func btnDidClick(sender: UIButton) {
        MBProgressHUD.showSuccess("成功", on: view)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
