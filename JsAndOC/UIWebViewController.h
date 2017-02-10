//
//  UIWebViewController.h
//  JsAndOC
//
//  Created by haha on 17/2/10.
//  Copyright © 2017年 myself. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

//自己要定义一个继承<JSExport>的Protocol，并在Web所在的ViewController中实现这个Protocol。
@protocol WebViewJSExportProtocol <JSExport>

/**
 JSExportAs是JSExport中的一个宏。把OC的- (void)callHandler方法对应给JS中的callHandler方法,把OC方法映射到JS中
 callHandler：和js端约定好的
 **/

JSExportAs(callHandler, - (void)callHandler:(NSString *)handlerName);

@end

@interface UIWebViewController : UIViewController

@end
