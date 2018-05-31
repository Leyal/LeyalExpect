//
//  TaoBaoViewController.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/29.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "TaoBaoViewController.h"
#import <WebKit/WebKit.h>
@interface TaoBaoViewController ()

@end

@implementation TaoBaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebView * webView = [[WKWebView alloc]initWithFrame:self.view.frame];
    
    //    WKWebView * webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 200, ScreenW, 300)];
    
    NSURL * url = [NSURL URLWithString:@"https://www.jd.com/?cu=true&utm_source=baidu-pinzhuan&utm_medium=cpc&utm_campaign=t_288551095_baidupinzhuan&utm_term=0f3d30c8dba7459bb52f2eb5eba8ac7d_0_24a89228201e4a2a9f7d237037fe9c37"];
    
    //     NSURL * url = [NSURL URLWithString:@"http://wimg.spriteapp.cn/ugc/2017/07/15/596a010e92372.gif"];
    //http://wimg.spriteapp.cn/ugc/2017/07/15/596a010e92372.gif
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
