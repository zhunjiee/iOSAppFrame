//
//  HttpNetwork.swift
//  MengTianXia
//
//  Created by zl on 2019/7/25.
//  Copyright © 2019 ZHUNJIEE. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import SwiftyJSON

//自定义错误类型，区别网络获取
let customErrorCode = "CUSTOM_ERROR_CODE"

/// 闭包别名
typealias ReqRsponseSuccess = (_ response: Any) -> Void     // 请求成功回调
typealias ReqResponseFail = (_ errorCode: String, _ errorMsg: String) -> Void       // 请求失败回调
typealias ReqProgressBlock = (_ progress: Int32) -> Void        // 下载进度回调
typealias NetworkStatus = (_ HTNetworkStatus: Int32) -> Void        // 网络状态回调

/// 网络状态
enum HTNetworkStatus: Int32 {
    case  HttpUnknow       = -1  //未知
    case  HttpNoReachable  = 0  // 无网络
    case  HttpCellular         = 1   //移动数据
    case  HttpWiFi         = 2  // wifi
}
/// 网络请求类型
enum methodType {
    case RequestMethodGet
    case RequestMethodPost
}

struct HTTPAPI {
    // 设置公共域名或者IP
    static let  hostName = "http://youyou.qdunzi.com"
}


// MARK: -  初始化配置
class HttpRequest: NSObject {
    private var sessionManager: Session?
    // 当前网络状态
    var htNetworkStatus: HTNetworkStatus = HTNetworkStatus.HttpWiFi
    
    // 单例
    static let shared  = HttpRequest()

    private override init() {
        super.init()
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60
        sessionManager = Session.init(configuration: config, delegate: SessionDelegate.init())
    }
}


// MARK: -  GET/POST网络请求方法
extension HttpRequest {
    /// GET 请求
    public func getRequestWith(_ url: String,
                               params: Parameters? = nil,
                               showHUD: Bool = false,
                               success: @escaping ReqRsponseSuccess,
                               error: @escaping ReqResponseFail) {
        if showHUD {
            MBProgressHUD.showLoading()
        }
        // 拼接URL
        let  httpUrl = HTTPAPI.hostName + url
        // 设置请求头
        var headers = HTTPHeaders()
       let token = BWUserDefaults.shareInstance.getUserToken() ?? ""
        headers = ["token" : token]
        
        sessionManager?.request(httpUrl, method: .get, parameters: params, headers: headers).responseJSON { (response) in
            if showHUD {
                MBProgressHUD.hideHUD()
            }
            self.responseResultHandle(response: response, success: success, error: error)
        }
    }
    
    /// POST 请求
    public func postRequestWith(_ url: String,
                                params: Parameters,
                                showHUD: Bool = false,
                                success: @escaping ReqRsponseSuccess,
                                error: @escaping ReqResponseFail) {
        if showHUD {
            MBProgressHUD.showLoading()
        }
        // 拼接URL
        let  httpUrl = HTTPAPI.hostName + url
        // 设置请求头
        var headers = HTTPHeaders()
        let token = BWUserDefaults.shareInstance.getUserToken() ?? ""
        headers = ["token" : token]
        
        sessionManager?.request(httpUrl, method: .post, parameters: params, headers: headers).responseJSON { (response) in
            if showHUD {
                MBProgressHUD.hideHUD()
            }
            self.responseResultHandle(response: response, success: success, error: error)
        }
    }
    
    /// 服务器返回结果的统一处理方法
    /// - Parameters:
    ///   - response: 服务器返回数据
    ///   - success: 成功回调
    ///   - error: 失败回调
    private func responseResultHandle(response: AFDataResponse<Any>, success: @escaping ReqRsponseSuccess, error: @escaping ReqResponseFail) {
        switch response.result {
        case .success(let value):
            let json = JSON(value)
            let responseCode = json["code"].string
            if responseCode == "1" {
                // 成功
                if json["data"].exists() && (json["data"].dictionary != nil || json["data"].array != nil) {
                    success(json["data"])
                } else {
                    success(json)
                }
            } else if responseCode == "-100" {
                // token失效 退出登录
                
            } else {
                // 错误
                let errorDes = json["msg"] .string
                error(responseCode ?? "", errorDes ?? "网络连接错误!")
            }
            break
            
        case .failure(let err):
            error(customErrorCode, "网络连接错误!")
            print("ERROR ========> \(err)")
            break
        }
    }
}


// MARK: -  上传图片
extension HttpRequest {
    
    /// 图片上传接口(上传音频与图片是一致的，需要更改的只是 mimeType类型，根据要求设置对应的格式即可)
    /// - Parameters:
    ///   - url: 接口地址
    ///   - params: 请求参数
    ///   - fileConfig: 上传文件配置
    ///   - showHUD: 是否显示loading
    ///   - progressBlock: 上传进度
    ///   - success: 成功回调
    ///   - error: 失败回调
    public func uploadImage(url: String,
                            params: Parameters?,
                            fileConfig: UploadFileConfig,
                            showHUD: Bool = false,
                            progressBlock:@escaping ReqProgressBlock,
                            success:@escaping ReqRsponseSuccess,
                            error:@escaping ReqResponseFail) {
        if showHUD {
            MBProgressHUD.showLoading()
        }
        // 拼接URL
        let  httpUrl = HTTPAPI.hostName + url
        // 设置请求头
        var headers = HTTPHeaders()
        let token = BWUserDefaults.shareInstance.getUserToken() ?? ""
        headers = ["token" : token]
        
        // 默认60s超时
        sessionManager?.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(fileConfig.fileData, withName: fileConfig.name, fileName: fileConfig.fileName, mimeType: fileConfig.mimeType)
            
        }, to: httpUrl, headers: headers).uploadProgress(queue: .main, closure: { (progress) in
            // 上传r图片的进度
            print("Upload Progress: \(progress.fractionCompleted)")
            progressBlock(Int32(progress.fractionCompleted))
            
        }).responseJSON { (response) in
            if showHUD {
                MBProgressHUD.hideHUD()
            }
            switch response.result {
            case .success:
                let json = String(data: response.data!, encoding: String.Encoding.utf8)
                success(json ?? "")
            case .failure:
                let statusCode = response.response?.statusCode
                error("\(statusCode ?? 0)", "上传失败")
                debugPrint(response.response as Any)
            }
        }
        
    }
}


// MARK: -  网络状态监听
extension HttpRequest {
    /// 监听网络状态
    public func monitoringNetwork(networkStatus:@escaping NetworkStatus) {
        // 创建网络监听器
        let reachability = NetworkReachabilityManager()
        // 开始监听
        reachability?.startListening(onUpdatePerforming: { [weak self] networkStatusListener in
            guard  let weakSelf = self else { return }
            switch networkStatusListener {
            case .notReachable: // 无网络
                weakSelf.htNetworkStatus = HTNetworkStatus.HttpNoReachable
            case .unknown:  // 未知网络
                weakSelf.htNetworkStatus = HTNetworkStatus.HttpUnknow
            case .reachable(.cellular): // 移动数据
                weakSelf.htNetworkStatus = HTNetworkStatus.HttpCellular
            case .reachable(.ethernetOrWiFi):   // 以太网或WIFI
                weakSelf.htNetworkStatus = HTNetworkStatus.HttpWiFi
            }
            networkStatus(weakSelf.htNetworkStatus.rawValue)
        })
    }
    
    /// 网络状态变化后做的处理
    public func monitoringDataFormLocalWhenNetChanged() {
        self.monitoringNetwork{ (netStatus) in
            print("网络状态变化: \(netStatus)")
        }
    }
}
