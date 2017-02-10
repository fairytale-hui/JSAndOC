
//
//  UIWebViewController.m
//  JsAndOC
//
//  Created by haha on 17/2/10.
//  Copyright © 2017年 myself. All rights reserved.
//

#import "UIWebViewController.h"

@interface UIWebViewController ()<UIWebViewDelegate,WebViewJSExportProtocol>
{
    UIWebView *_webView;
    //声明一个JSContent JS运行环境上下文
    JSContext *_context;
}
@end

@implementation UIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setleftBackButton];
    _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    _webView.delegate = self;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"haha" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    
}
- (void)setleftBackButton{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44, 44);
    [btn setImage:[UIImage imageNamed:@"button_back_home"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"button_back_home"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -28, 0, 0);
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = backItem;
    //解决手势问题
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;

}

- (void)leftAction{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //获取WebView的JS运行环境上下文环境
    _context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //设置一个特定的属性，与js约定好
    [_context setObject:self forKeyedSubscript:@"iOSNative"];
    [_context setObject:self forKeyedSubscript:@"IOSNative"];
    //native调js
    NSString *alertJS = @"alert('hello world')";
    [_context evaluateScript: alertJS];
    
    
}

//只要JS端调用 iOSNative.callHandler(handlerName)就会回调到OC中的callHandler方法。
- (void)callHandler:(NSString *)handlerName {
    if ([_context.name isEqualToString:@"iOSNative"]) {
        NSLog(@"小写---%@",handlerName);
    }
    else {
        NSLog(@"大写---%@",handlerName);
    }
    
}

@end
