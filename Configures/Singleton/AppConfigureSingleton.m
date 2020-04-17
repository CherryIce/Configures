//
//  AppConfigureSingleton.m
//  Configures
//
//  Created by hubin on 2020/4/16.
//  Copyright © 2020 hubin. All rights reserved.
//

#import "AppConfigureSingleton.h"

@implementation AppConfigureSingleton

SingleImplementation(AppConfigureSingleton);

- (NSDictionary *) getPlistFileContentWithName:(NSString *)plistName {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    //当数据结构为非数组时
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    return dictionary;
}


- (void) getSomeAppConfigureWithKey:(NSString * ) sKey {
    NSDictionary * dict = [[AppConfigureSingleton shareAppConfigureSingleton] getPlistFileContentWithName:@"AppConfigures"];
    #ifdef DEBUG
       [AppConfigureSingleton shareAppConfigureSingleton].baseUrl = dict[@"serverAddress"][@"develop"][@"baseUrl"];
           //do sth.
    #else
       [AppConfigureSingleton shareAppConfigureSingleton].baseUrl = dict[@"serverAddress"][@"production"][@"baseUrl"];
           //do sth.
    #endif
}

/**
static AppConfigureSingleton *_mySingle = nil;
+(instancetype)shareInstance
{
    if (_mySingle == nil) {
        _mySingle = [[AppConfigureSingleton alloc] init];
    }
    return _mySingle;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _mySingle = [super allocWithZone:zone];
    });
    return _mySingle;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return self;
}
 **/

@end
