//
//  BaseWebViewController.h
//  MengTianXia
//
//  Created by zl on 2019/8/10.
//  Copyright © 2019 qttx. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseWebViewController : BaseViewController <WKNavigationDelegate, WKScriptMessageHandler>

@property (copy, nonatomic) NSString *titleStr; // 导航栏标题
@property (copy, nonatomic) NSString *urlStr;   // url地址
@property (nonatomic, strong) WKWebView *webView;
@end

NS_ASSUME_NONNULL_END
