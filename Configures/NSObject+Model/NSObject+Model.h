//
//  NSObject+Model.h
//  Configures
//
//  Created by hubin on 2020/4/20.
//  Copyright © 2020 hubin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Model)

+ (instancetype)ModelWithDict:(NSDictionary *)dict;

- (void)transformDict:(NSDictionary *)dict;

//获取数组中模型对象的类型
- (NSString *)gainClassType;

@end

NS_ASSUME_NONNULL_END
