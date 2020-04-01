//
//  BWLoading.swift
//  MengTianXia
//
//  Created by zl on 2019/7/26.
//  Copyright © 2019 ZHUNJIEE. All rights reserved.
//

import MBProgressHUD

// MARK: -  在指定的view上显示HUD
extension MBProgressHUD {
    /// 成功
    class func showSuccess(_ success: String?, on view: UIView) {
        show(success, icon: "Resource.bundle/success", on: view)
    }
    /// 错误
    class func showError(_ error: String?, on view: UIView) {
        show(error, icon: "Resource.bundle/error", on: view)
    }
    /// 警告
    class func showWarning(_ warning: String?, on view: UIView) {
        show(warning, icon: "Resource.bundle/warning", on: view)
    }
    /// 纯文本
    class func showMessage(_ message: String?, on view: UIView) {
        show(message, icon: nil, on: view)
    }
    /// 自定义图片
    class func showMessageWithImage(named: String, message: String?, on view: UIView) {
        show(message, icon: named, on: view)
    }
    /// 菊花 + 文字
    class func showLoadingMessage(_ message: String?, on view: UIView) {
        showLoading(message, on: view)
    }
    /// 只显示菊花,不显示文字
    class func showLoading(on view: UIView) {
        showLoading("", on: view);
    }
}

// MARK: -  在window上显示HUD
extension MBProgressHUD {
    class func showSuccess(_ success: String?) {
        show(success, icon: "Resource.bundle/success", on: getWindowView())
    }
    
    class func showError(_ error: String?) {
        show(error, icon: "Resource.bundle/error", on: getWindowView())
    }
    
    class func showWarning(_ warning: String?) {
        show(warning, icon: "Resource.bundle/warning", on: getWindowView())
    }
    
    class func showMessage(_ message: String?) {
        show(message, icon: nil, on: getWindowView())
    }
    
    class func showMessageWithImage(named: String, message: String?) {
        show(message, icon: named, on: getWindowView())
    }

    class func showLoadingMessage(_ message: String?) {
        showLoading(message, on: getWindowView())
    }

    class func showLoading() {
        showLoading("", on: getWindowView());
    }
}

// MARK: -  隐藏HUD
extension MBProgressHUD {
    /// 隐藏指定view的HUD
    class func hideHUDForView(_ view: UIView) {
        hide(for: view, animated: true)
    }
    
    /// 隐藏window的HUD
    class func hideHUD() {
        let view = getWindowView()
        hideHUDForView(view)
    }
}


// MARK: -  显示基本信息
extension MBProgressHUD {
    private class func show(_ text: String?, icon iconName: String?, on view: UIView) {
        //在显示新的之前需要隐藏掉旧的，否则会导致多个loading页面重叠
        hide(for: view, animated: true)
        
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.bezelView.layer.cornerRadius = 8.0
        var renderMode: UIImage.RenderingMode = .alwaysTemplate
        
        if HUDStyleManager.sharedInstance.hudStyle == .grayBackgroundStyle {
            //灰白色背景+icon 和背景同色
            renderMode = .alwaysTemplate
            hud.bezelView.style = .blur //单色背景
        }
        if HUDStyleManager.sharedInstance.hudStyle == .dimBackgroundStyle {
            //老版本样式，带透明度的黑色背景+白色icon
            renderMode = .alwaysOriginal
            hud.bezelView.backgroundColor = UIColor.black.withAlphaComponent(1.0) //黑色背景
            hud.backgroundColor = UIColor.black.withAlphaComponent(0.3) // 整个view背景
            hud.contentColor = UIColor.white
        }
        
        hud.label.text = text
        let image = UIImage(named: iconName ?? "")?.withRenderingMode(renderMode)
        hud.customView = UIImageView(image: image)
        hud.mode = .customView
        hud.removeFromSuperViewOnHide = true
        // 保证任务在主线程执行
        DispatchQueue.main.async {
            hud.hide(animated: true, afterDelay: HUDStyleManager.sharedInstance.hudShowTime)
        }
    }
    
    /// 获取当前窗口视图
    private class func getWindowView()->(UIView) {
        var view: UIView?
        if (UIApplication.shared.keyWindow != nil) {
            view = UIApplication.shared.keyWindow
        } else {
            view = UIApplication.shared.windows.last
        }
        return view ?? UIView()
    }
}

// MARK: -  显示带旋转菊花的hud
extension MBProgressHUD {
    /// 显示旋转菊花+文字
    private class func showLoading(_ message: String?, on view: UIView) {
        //在显示新的之前需要隐藏掉旧的，否则会导致多个loading页面重叠
        hide(for: view, animated: true)
        
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.bezelView.layer.cornerRadius = 8.0
        hud.label.text = message
        hud.removeFromSuperViewOnHide = true
        
        if HUDStyleManager.sharedInstance.hudStyle == .grayBackgroundStyle {
            //灰白色背景+icon 和背景同色
            hud.bezelView.style = .blur //单色背景
        }
        if HUDStyleManager.sharedInstance.hudStyle == .dimBackgroundStyle {
            //老版本样式，带透明度的黑色背景+白色icon
            hud.bezelView.backgroundColor = UIColor.black.withAlphaComponent(1.0) //黑色背景
            hud.backgroundColor = UIColor.black.withAlphaComponent(0.3) // 整个view背景
            hud.contentColor = UIColor.white
        }
    }
}

