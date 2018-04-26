//
//  SPWebViewController.m
//  Project_Dms
//
//  Created by 超级腕电商 on 16/11/4.
//  Copyright © 2016年 超级腕电商. All rights reserved.
//

#import "SPWebViewController.h"

@interface SPWebViewController ()

@end

@implementation SPWebViewController
- (void)_handleViewBack {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else
    {
        [super _handleViewBack];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _webView = [[WKWebView alloc] init];
    _webView.backgroundColor = [UIColor clearColor];
    //_webView.scalesPageToFit = true;
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
    
    _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
    [self.view addSubview:_indicatorView];
    
    self.webView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
    self.indicatorView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.indicatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.indicatorView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    [self.indicatorView addConstraint:[NSLayoutConstraint constraintWithItem:self.indicatorView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.0]];
    [self.indicatorView addConstraint:[NSLayoutConstraint constraintWithItem:self.indicatorView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.0]];
    
    [self loadData];
}
- (void)loadData {
    DBLOG(@"%@", self.webURL);
    if ([self.webURL length] > 0) {
        NSString *URLString = self.webURL;
        NSString *parameters = [self parameters];
        if ([parameters length] > 0) {
            if ([self.webURL rangeOfString:@"?"].location != NSNotFound) {
                URLString = stringFormat(@"%@&%@", self.webURL, parameters);
            } else {
                URLString = stringFormat(@"%@?%@", self.webURL, parameters);
            }
        }
        [self loadRequestWithURL:[NSURL URLWithString:URLString]];
    }
}
- (void)setWebTitle {
    [self.webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable title, NSError * _Nullable error) {
        self.title = title;
    }];
    //return [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

// 加载网页请求
- (void)loadRequestWithURL:(NSURL *)url {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [self.webView loadRequest:request];
}
- (NSString *)parameters {
//    NSMutableArray *parameterPairs = [NSMutableArray array];
//    if ([[DataStore sharedStore].session length] > 0) {
//        [parameterPairs addObject:[Utilities URLEncodedKeyValuePair:@"sessid" value:[DataStore sharedStore].session]];
//    }
//
//    if ([parameterPairs count] > 0) {
//        return [parameterPairs componentsJoinedByString:@"&"];
//    }
    return @"";
}
#pragma mark - WKNavigationDelegate

// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    DBLOG_FUN;
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}

// 在发送请求之前，决定是否跳转   ----替代should start load webview 方法
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    DBLOG_FUN;
    DBLOG(@"%@",navigationAction.request.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    DBLOG_FUN;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:true];
    [self.indicatorView startAnimating];
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    DBLOG_FUN;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:false];
    [self.indicatorView stopAnimating];
    
    
    [self setWebTitle];
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    DBLOG_FUN;
    [self.indicatorView stopAnimating];
}
- (BOOL)isAllowedNotification {
    //iOS8 check if user allow notification
    if (IOS_8_OR_LATER) {// system is iOS8 or later
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone != setting.types) {
            return YES;
        }
    } else {//iOS7
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if(UIRemoteNotificationTypeNone != type)
            return YES;
    }
    
    return NO;
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==alertView.firstOtherButtonIndex) {
        NSURL * url = [NSURL new];
        if (IOS_8_OR_LATER) {
            url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        }
        
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
            
        }
    }
}
@end
