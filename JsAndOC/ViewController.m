//
//  ViewController.m
//  JsAndOC
//
//  Created by haha on 17/2/9.
//  Copyright © 2017年 myself. All rights reserved.
//

#import "ViewController.h"
#import "UIWebViewController.h"
#import "WKWebViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)UIWebViewClick:(id)sender {
    UIWebViewController *vc = [[UIWebViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
   }

- (IBAction)WKWebViewClick:(id)sender {
    WKWebViewController *vc = [[WKWebViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
