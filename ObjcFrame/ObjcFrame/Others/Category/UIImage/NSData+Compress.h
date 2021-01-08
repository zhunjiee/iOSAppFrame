//
//  NSData+Compress.h
//  ychat
//
//  Created by 孙俊 on 2017/12/3.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Compress)

/**
 * @brief 图片压缩处理
 * @param sourceImage 原图片
 * @param isUploadHeadProtrant 是否是上传头像 上传头像是正方形
 */
+ (NSData *)compressImageDataWithImage:(UIImage *)sourceImage isUploadHeadProtrant:(BOOL)isUploadHeadProtrant;

@end
