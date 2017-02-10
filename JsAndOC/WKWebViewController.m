//
//  WKWebViewController.m
//  JsAndOC
//
//  Created by haha on 17/2/10.
//  Copyright © 2017年 myself. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>

@interface WKWebViewController ()<WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *wkWebView;
@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setleftBackButton];
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.preferences.minimumFontSize = 18;
    self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height/2) configuration:config];
    [self.view addSubview:self.wkWebView];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL *baseURL = [[NSBundle mainBundle] bundleURL];
    [self.wkWebView loadHTMLString:[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil] baseURL:baseURL];
    
    WKUserContentController *userCC = config.userContentController;
    //JS调用OC 添加处理脚本
    [userCC addScriptMessageHandler:self name:@"showMobile"];
    [userCC addScriptMessageHandler:self name:@"showName"];
    [userCC addScriptMessageHandler:self name:@"showSendMsg"];

    
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
        
    }];}

//网页加载完成之后调用JS代码才会执行，因为这个时候html页面已经注入到webView中并且可以响应到对应方法

- (IBAction)btnClick:(UIButton *)sender {
    if (!self.wkWebView.loading) {
        if (sender.tag == 123) {
            [self.wkWebView evaluateJavaScript:@"alertMobile()" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                //TODO
                NSLog(@"%@ %@",response,error);
            }];
        }
        
        if (sender.tag == 234) {
            [self.wkWebView evaluateJavaScript:@"alertName('小红')" completionHandler:nil];
        }
        
        if (sender.tag == 345) {
            [self.wkWebView evaluateJavaScript:@"alertSendMsg('18870707070','周末爬山真是件愉快的事情')" completionHandler:nil];
        }
        
    } else {
        NSLog(@"the view is currently loading content");
    }
}

#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    NSLog(@"%@",message.body);
    
    if ([message.name isEqualToString:@"showMobile"]) {
        [self showMsg:@"我是下面的小红 手机号是:18870707070"];
    }
    
    if ([message.name isEqualToString:@"showName"]) {
        NSString *info = [NSString stringWithFormat:@"你好 %@, 很高兴见到你",message.body];
        [self showMsg:info];
    }
    
    if ([message.name isEqualToString:@"showSendMsg"]) {
        NSArray *array = message.body;
        NSString *info = [NSString stringWithFormat:@"这是我的手机号: %@, %@ !!",array.firstObject,array.lastObject];
        [self showMsg:info];
    }
}

- (void)showMsg:(NSString *)msg {
    [[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
}

- (IBAction)clear:(id)sender {
    [self.wkWebView evaluateJavaScript:@"clear()" completionHandler:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
