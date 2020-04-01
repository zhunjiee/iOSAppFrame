//
//  UploadFileConfig.swift
//  QShortVideo
//
//  Created by Houge on 2020/3/31.
//  Copyright © 2020 ZHUNJIEE. All rights reserved.
//

import UIKit

// MARK: -  上传文件的相关配置
class UploadFileConfig: NSObject {
    var fileData : Data
    var name : String
    var fileName : String
    var mimeType : String

    init(withFileData data: Data,
         name: String = "file",
         fileName: String = "",
         mimeType: String = "image/jpeg") {
        self.fileData = data
        self.name = name
        self.fileName = fileName
        self.mimeType = mimeType
    }
}
