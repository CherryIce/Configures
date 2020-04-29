//
//  TestViewController.m
//  Configures
//
//  Created by hubin on 2020/4/24.
//  Copyright © 2020 hubin. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()<WKScriptMessageHandler,WKUIDelegate,WKNavigationDelegate>

/**
 WKWebView
 */
@property (nonatomic,strong)WKWebView  *wkWebView;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadLocalHtmlAction];
}

#pragma mark 加载本地HTML操作(index)
-(void)loadLocalHtmlAction{
    //主要是文件路径需要选蓝色文件夹 😂😂😂
    NSURL *urlObj = [[NSBundle mainBundle] URLForResource:@"LocalData/Html/dist/index.html" withExtension:nil];
    if (!urlObj) { return; }
    NSString * urlStr = [NSString stringWithFormat:@"%@#/home/cn",urlObj.absoluteString];
    urlObj = [NSURL URLWithString:urlStr];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:urlObj];
    [self.wkWebView loadRequest:urlRequest];
}

#pragma mark WKWebView
- (WKWebView *)wkWebView {
    if (!_wkWebView) {
        WKWebViewConfiguration *config=[[WKWebViewConfiguration alloc]init];
        config.preferences=[WKPreferences new];
        config.preferences.minimumFontSize=10;
        config.preferences.javaScriptCanOpenWindowsAutomatically=true;
        config.preferences.javaScriptEnabled=YES;  // 设置可以JS交互
        [config.preferences setValue:@YES forKey:@"allowFileAccessFromFileURLs"];
        
        WKUserContentController *wkUserVC=[[WKUserContentController alloc]init];
        config.userContentController=wkUserVC;
        
        CGRect rectValue = CGRectMake(0, 88, self.view.bounds.size.width, self.view.bounds.size.height - 88);
        _wkWebView=[[WKWebView alloc]initWithFrame:rectValue configuration:config];
        _wkWebView.scrollView.showsVerticalScrollIndicator=NO;
        _wkWebView.scrollView.showsHorizontalScrollIndicator=NO;
        _wkWebView.allowsBackForwardNavigationGestures=YES;
        _wkWebView.UIDelegate=self;
        _wkWebView.navigationDelegate=self;
        [self.view addSubview:_wkWebView];
    }
    return _wkWebView;
}

#pragma mark -WKNavigationDelegate
// 拦截URL操作
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    // 允许加载
    decisionHandler(WKNavigationActionPolicyAllow);
}

// 加载完成
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"reson1加载网页失败,原因是: %@",error);
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"reson2加载网页失败,原因是: %@",error);
}

#pragma mark WKScriptMessageHandler
// JS调用OC的回调
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{

//    NSDictionary *dicBodyValue=message.body;
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
