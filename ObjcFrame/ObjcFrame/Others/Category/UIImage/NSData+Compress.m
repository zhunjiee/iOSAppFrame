//
//  NSData+Compress.m
//  ychat
//
//  Created by 孙俊 on 2017/12/3.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import "NSData+Compress.h"
#import "UIImage+Util.h"

@implementation NSData (Compress)

+ (NSData *)compressImageDataWithImage:(UIImage *)sourceImage isUploadHeadProtrant:(BOOL)isUploadHeadProtrant {
    //    //进行图像尺寸的压缩
    CGSize imageSize = sourceImage.size;//取出要压缩的image尺寸
    CGFloat width = imageSize.width;    //图片宽度
    CGFloat height = imageSize.height;  //图片高度
    UIImage *newImage;
    
    if (isUploadHeadProtrant) {
        if (width != height) {
            newImage = [UIImage getSubImage:sourceImage mCGRect:CGRectMake(0, 0, ScreenWidth, ScreenWidth) centerBool:YES];
        } else {
            //1.宽高大于1280(宽高比不按照2来算，按照1来算)
            if (width>1280) {
                if (width>height) {
                    CGFloat scale = width/height;
                    height = 1280;
                    width = height*scale;
                }else{
                    CGFloat scale = height/width;
                    width = 1280;
                    height = width*scale;
                }
                //2.高度大于1280
            }else if(height>1280){
                CGFloat scale = height/width;
                width = 1280;
                height = width*scale;
            }else{
            }
            UIGraphicsBeginImageContext(CGSizeMake(width, height));
            [sourceImage drawInRect:CGRectMake(0,0,width,height)];
            newImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
    } else {
        //1.宽高大于1280(宽高比不按照2来算，按照1来算)
        if (width>1280) {
            if (width>height) {
                CGFloat scale = width/height;
                height = 1280;
                width = height*scale;
            }else{
                CGFloat scale = height/width;
                width = 1280;
                height = width*scale;
            }
            //2.高度大于1280
        }else if(height>1280){
            CGFloat scale = height/width;
            width = 1280;
            height = width*scale;
        }else{
        }
        UIGraphicsBeginImageContext(CGSizeMake(width, height));
        [sourceImage drawInRect:CGRectMake(0,0,width,height)];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
        //进行图像的画面质量压缩
    NSData *data=UIImageJPEGRepresentation(newImage, 1.0);
    if (data.length>100*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(newImage, 0.7);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(newImage, 0.8);
        }else if (data.length>200*1024) {
            //0.25M-0.5M
            data=UIImageJPEGRepresentation(newImage, 0.9);
        }
    }
    return data;
}

@end
