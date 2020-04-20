//
//  StudentModel.h
//  Configures
//
//  Created by hubin on 2020/4/20.
//  Copyright © 2020 hubin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSObject+Model.h"
#import "SchoolModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface StudentModel : NSObject

@property(nonatomic,copy)NSString * name;
@property(nonatomic,assign)int age;
@property(nonatomic,copy)NSString * sex;
@property(nonatomic,strong)SchoolModel * school;
@property(nonatomic,strong)NSArray * lessons;

@end

NS_ASSUME_NONNULL_END
