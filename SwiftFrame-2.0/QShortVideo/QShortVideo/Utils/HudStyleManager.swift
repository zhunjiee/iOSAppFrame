//
//  HudStyleManager.swift
//  QShortVideo
//
//  Created by Houge on 2020/3/31.
//  Copyright © 2020 ZHUNJIEE. All rights reserved.
//

import UIKit
import SVProgressHUD

class HudStyleManager: NSObject {
    
    static let sharedInstance = HudStyleManager()
    
    var hudStyle: SVProgressHUDStyle{
        willSet{
            SVProgressHUD .setDefaultStyle(newValue)
        }
    }
    var hudMaskType: SVProgressHUDMaskType{
        willSet{
            SVProgressHUD.setDefaultMaskType(newValue)
        }
    }
    
    func setSVProgressHUDStyle() {
        SVProgressHUD.setDefaultStyle(hudStyle)
        SVProgressHUD.setDefaultMaskType(hudMaskType)
    }
    
    //切记私有化初始化方法，防止外部通过init直接创建实例。
    private override init() {
        hudStyle = .dark
        hudMaskType = .black
    }
}
