//
//  BaseWebViewController.m
//  MengTianXia
//
//  Created by zl on 2019/8/10.
//  Copyright © 2019 qttx. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController ()
@property (strong, nonatomic) WKWebViewConfiguration *webConfig;
@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
    if (!BWStringIsEmpty(self.urlStr)) {
        [SVProgressHUD show];
        if ([self.urlStr containsString:@"http"] || [self.urlStr containsString:@"https"]) {
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
        }else{
            // 加载html代码
            [self.webView loadHTMLString:self.urlStr baseURL:nil];
        }
    }
}

- (void)setupNavigationBar {
    if (!BWStringIsEmpty(self.titleStr)) {
        self.navigationItem.title = self.titleStr;
    }
}


#pragma mark - <WKNavigationDelegate>

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [SVProgressHUD dismiss];
}


#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
}


#pragma mark - 懒加载

- (WKWebViewConfiguration *)webConfig {
    if (!_webConfig) {
        _webConfig = [[WKWebViewConfiguration alloc] init];
        // 禁止手势缩放
        WKUserContentController *userController = [WKUserContentController new];
        NSString *js = @"var script = document.createElement('meta');"
        "script.name = 'viewport';"
        "script.content=\"width=device-width, user-scalable=no\";"
        "document.getElementsByTagName('head')[0].appendChild(script);";
        WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
        [userController addUserScript:script];
        [userController addScriptMessageHandler:self name:@"openInfo"];
        _webConfig.userContentController = userController;
    }
    return _webConfig;
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:self.webConfig];
        _webView.navigationDelegate = self;
        _webView.allowsBackForwardNavigationGestures = YES;
        [self.view addSubview:_webView];
    }
    return _webView;
}

@end
