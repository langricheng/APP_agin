//
//  CWWebViewController.h
//  HealthCloud
//
//  Created by chengwen on 16/7/11.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>

@interface CWWebViewController :BaseViewController <UIWebViewDelegate,WKNavigationDelegate>

@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) WKWebView *wkWebView;
- (void)startLoadingWithRequestURL:(NSString *)urlStr;
@end
