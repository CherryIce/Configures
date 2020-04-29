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

@interface ViewController ()

/**
 dict->model
 */
@property(nonatomic,copy)NSDictionary * dict;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   // [self test1];
   // [self test2];
    [self modelTest];
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

//push
- (IBAction)click:(UIButton *)sender {
    //[self pushSwift];
    //[self pushOC];
    [self presentST];
}

- (void) pushSwift {
    SViewController * sv = [[SViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:sv];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:nav animated:false completion:nil];
}

- (void) pushOC {
    TestViewController * test = [[TestViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:test];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:nav animated:false completion:^{
        
    }];
}

- (void) presentST {
    TTViewController * tt = [[TTViewController alloc] init];
    //tt.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:tt animated:true completion:nil];
}


@end
