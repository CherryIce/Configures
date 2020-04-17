//
//  ViewController.m
//  Configures
//
//  Created by hubin on 2020/4/16.
//  Copyright © 2020 hubin. All rights reserved.
//

#import "ViewController.h"

#import "AppConfigureSingleton.h"

#ifndef DEBUG
#undef NSLog
#define NSLog(args, ...)
#endif

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self test1];
}

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

- (void) test2 {
    [[AppConfigureSingleton shareAppConfigureSingleton] getAllAppConfigures];
}


@end
