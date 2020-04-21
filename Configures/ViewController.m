//
//  ViewController.m
//  Configures
//
//  Created by hubin on 2020/4/16.
//  Copyright © 2020 hubin. All rights reserved.
//

#import "ViewController.h"

#import "AppConfigureSingleton.h"

#import "NSObject+Model.h"
#import "StudentModel.h"
#import "SchoolModel.h"
#import "GradeModel.h"
#import "LessonModel.h"

#ifndef DEBUG
#undef NSLog
#define NSLog(args, ...)
#endif

@interface ViewController ()<WKScriptMessageHandler,WKUIDelegate,WKNavigationDelegate>

/**
 dict->model
 */
@property(nonatomic,copy)NSDictionary * dict;

/**
 WKWebView
 */
@property (nonatomic,strong)WKWebView  *wkWebView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   // [self test1];
   // [self test2];
    [self modelTest];
    [self loadLocalHtmlAction];
}

#pragma mark -- test1
- (void) test1 {
    /*
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"plist"];
    //当数据结构为数组时
    NSArray *array = [[NSArray alloc] initWithContentsOfFile:plistPath];
    //当数据结构为非数组时
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
     */
    
    NSDictionary * dict = [[AppConfigureSingleton shareAppConfigureSingleton] getPlistFileContentWithName:@"AppConfigures"];
    #ifdef DEBUG
    [AppConfigureSingleton shareAppConfigureSingleton].baseUrl = dict[@"serverAddress"][@"develop"][@"baseUrl"];
        //do sth.
    #else
    [AppConfigureSingleton shareAppConfigureSingleton].baseUrl = dict[@"serverAddress"][@"production"][@"baseUrl"];
        //do sth.
    #endif
    
    //release --- product --- scheme -- edit scheme
    NSLog(@">>>>%@",[AppConfigureSingleton shareAppConfigureSingleton].baseUrl);
}

#pragma mark -- test2
- (void) test2 {
    [[AppConfigureSingleton shareAppConfigureSingleton] getAllAppConfigures];
}

#pragma mark -- modelTest
- (void) modelTest {
    StudentModel * st = [StudentModel ModelWithDict:self.dict];
    LessonModel * l = [st.lessons lastObject];
    SchoolModel * s = st.school;
    GradeModel * g = s.grade;
    NSLog(@"People:%@\n",st);
    NSLog(@"Lesson:%@\n",l);
    NSLog(@"School:%@\n",s);
    NSLog(@"Grade:%@\n",g);
    NSLog(@"teacher:%@",st.school.grade.teacher);
}

- (NSDictionary *)dict {
    if (!_dict) {
        _dict = @{
                  @"name" : @"Xiaoming",
                  @"age" : @18,
                  @"sex" : @"男",
                  @"city" : @"北京市",
                  @"lessons" : @[
                          @{
                              @"name" : @"语文",
                              @"score" : @125
                              },
                          @{
                              @"name" : @"数学",
                              @"score" : @146
                              },
                          @{
                              @"name" : @"英语",
                              @"score" : @112
                              }
                          ],
                  @"school" : @{
                          @"name" : @"海淀一中",
                          @"address" : @"海淀区",
                          @"grade" : @{
                                  @"name" : @"九年级",
                                  @"teacher" : @"Mr Li"
                                  }
                          }
                  };
    }
    return _dict;
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
        
        CGRect rectValue = self.view.bounds;
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

@end
