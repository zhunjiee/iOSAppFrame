//
//  PlayerViewController.swift
//  QShortVideo
//
//  Created by Houge on 2020/3/30.
//  Copyright © 2020 ZHUNJIEE. All rights reserved.
//

import UIKit
import PLPlayerKit

// MARK: -  初始化
class PlayerViewController: BaseViewController {
    // 视频地址
    var url: String?
    {
        willSet{
            if newValue == url {
                return
            }
            print("播放地址: \(String(describing: newValue))")
        }
        didSet{
            rebuildPlayer()
        }
    }
    //
    var thumbImage: String?
    var thumbImageUrl: String?
    // 是否启用手指滑动调节音量和亮度, default true
    var enbleGesture: Bool? = true
    
    
    // MARK: -  懒加载
    // 播放器配置
    fileprivate lazy var option: PLPlayerOption = {
        let option: PLPlayerOption = PLPlayerOption.default();
        // 接收/发送数据包超时时间间隔
        option.setOptionValue(NSNumber(value: 15), forKey: PLPlayerOptionKeyTimeoutIntervalForMediaPackets)
        let urlStr = (url ?? "").lowercased()
        var format = kPLPLAY_FORMAT_UnKnown;
        if urlStr.hasPrefix("mp4") {
            format = kPLPLAY_FORMAT_MP4
        } else if urlStr .hasPrefix("rtmp:") {
            format = kPLPLAY_FORMAT_FLV
        } else if urlStr .hasPrefix(".mp3") {
            format = kPLPLAY_FORMAT_MP3
        } else if urlStr .hasPrefix(".m3u8") {
            format = kPLPLAY_FORMAT_M3U8
        }
        option.setOptionValue(NSNumber(value: format.rawValue), forKey: PLPlayerOptionKeyVideoPreferFormat)
        option.setOptionValue(NSNumber(value: kPLLogNone.rawValue), forKey: PLPlayerOptionKeyLogLevel)
        return option
    }()
    // 播放器
    lazy var player: PLPlayer = {
        if url == nil || url?.count == 0 {
            print("播放地址为空!!!")
        }
        let player = PLPlayer(url: URL(string: url ?? ""), option: option)
        player?.delegate = self
        // 允许后台播放
        player?.isBackgroundPlayEnable = true
        // 循环播放
        player?.loopPlay = true
        return player!
    }()
    // 播放按钮
    lazy var playButton: UIButton = {
        let playBtn = UIButton(type: .custom)
        playBtn.isHidden = true
        playBtn.setImage(UIImage(named: "player-play"), for: .normal)
        playBtn.addTarget(self, action: #selector(playBtnDidClick(sender:)), for: .touchUpInside)
        view.addSubview(playBtn)
        playBtn.snp.makeConstraints { (make) in
            make.size.equalTo(60)
            make.center.equalToSuperview()
        }
        return playBtn
    }()
    // 播放按钮
    lazy var thumbImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        addTapGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !player.isPlaying {
            player.play()
        }
    }
}


// MARK: -  UI界面
extension PlayerViewController {
    /// 初始化界面
    func initView() {
        // 添加播放器视图到控制器view
        view.insertSubview(player.playerView!, at: 0)
    }
    
    /// 重新创建播放器
    func rebuildPlayer() {
        if player.status == .statusPlaying {
            player.stop()
            player = PLPlayer(url: URL(string: url ?? ""), option: option)!
            player.play()
        }
    }
}


// MARK: -  网络请求
extension PlayerViewController {
    
}


// MARK: -  事件监听
extension PlayerViewController {
    /// 添加全屏单击事件
    fileprivate func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(singleTapAction(tap:)))
        view.addGestureRecognizer(tap)
    }
    
    /// 单击手势事件 - 继续/暂停
    /// - Parameter tap: 单击手势
    @objc func singleTapAction(tap: UITapGestureRecognizer) {
        if player.isPlaying {
            player.pause()
        } else {
            player.resume()
        }
    }
    
    /// 点击播放按钮
    /// - Parameter sender: 播放按钮
    @objc func playBtnDidClick(sender: UIButton) {
        if player.status == .statusPaused {
            resume()
        } else {
            play()
        }
    }
    
    
    
}

// MARK: -  播放状态控制
extension PlayerViewController {
    /// 播放
    fileprivate func play() {
        
    }
    
    /// 暂停
    fileprivate func pause() {
        
    }
    
    /// 继续
    fileprivate func resume() {
        
    }
    
    /// 停止
    fileprivate func stop() {
        
    }
}


// MARK: -  PLPlayerDelegate
extension PlayerViewController: PLPlayerDelegate {
    /// 监听播放状态
    func player(_ player: PLPlayer, statusDidChange state: PLPlayerStatus) {
        if state == .statusCompleted {
            
        }
    }
}
