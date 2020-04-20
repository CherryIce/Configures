//
//  SchoolModel.h
//  Configures
//
//  Created by hubin on 2020/4/20.
//  Copyright © 2020 hubin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GradeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SchoolModel : NSObject

@property(nonatomic,copy)NSString * name;

@property(nonatomic,copy)NSString * address;

@property(nonatomic,strong)GradeModel * grade;

@end

NS_ASSUME_NONNULL_END
