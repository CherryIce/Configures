//
//  AppConfigureSingleton.h
//  Configures
//
//  Created by hubin on 2020/4/16.
//  Copyright © 2020 hubin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Single.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppConfigureSingleton : NSObject

//宏创建单例模式
SingleInterface(AppConfigureSingleton);

@property (nonatomic , copy) NSString * baseUrl;

//test1
- (NSDictionary *) getPlistFileContentWithName:(NSString *)plistName;

//test2 获取所有配置信息
- (void) getAllAppConfigures;


//+(instancetype)shareInstance;

@end

NS_ASSUME_NONNULL_END
