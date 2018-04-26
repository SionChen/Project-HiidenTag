//
//  SPWebViewController.h
//  Project_Dms
//
//  Created by 超级腕电商 on 16/11/4.
//  Copyright © 2016年 超级腕电商. All rights reserved.
//

#import "SPViewController.h"
#import <WebKit/WebKit.h>

@interface SPWebViewController : SPViewController<WKNavigationDelegate>{

    UIActivityIndicatorView *_indicatorView;
    NSString *_webURL;
}

@property(nonatomic, readonly) WKWebView *webView;
@property(nonatomic, readonly) UIActivityIndicatorView *indicatorView;
@property(nonatomic, readonly) NSString *webTitle; //网页标题
@property(nonatomic, copy) NSString *webURL;
// 参数
@property(nonatomic, copy) NSString *order_id; //订单id
@property(nonatomic, copy) NSString *booking; //定金订单id


-(NSString *)parameters;

@end
