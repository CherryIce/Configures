//
//  TTViewController.m
//  Configures
//
//  Created by hubin on 2020/4/29.
//  Copyright © 2020 hubin. All rights reserved.
//

#import "TTViewController.h"

#import "TDViewController.h"

@interface TTViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController * pageViewController;

@property (nonatomic, strong) NSMutableArray * pageContentArray;

@property (nonatomic, assign) NSInteger pageIndex;

@end

@implementation TTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    
    self.view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.2];
    
    UIView * v = [[UIView alloc] initWithFrame:CGRectMake(0, 200,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height - 200 )];
    v.backgroundColor = [UIColor redColor];
    [self.view addSubview:v];
    
    [self buildView];
       
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addTitleView:) name:@"refreshRedPointCallBack" object:nil];
}

- (void)buildView{
    
//    self.sagView = [[FDSagmentBtnView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
//    self.sagView.fDSagmentBtnViewDelegate = self;
//    self.sagView.dataArr = [NSArray arrayWithObjects:@"资金消息",@"操作消息", @"状态消息",nil];
//    self.sagView.tagTextColor_normal = [UIColor blackColor];
//    self.sagView.tagTextFont_normal = 16;
//    self.sagView.tagTextFont_selected = 16;
//    self.sagView.sliderW = 70;
//    self.sagView.sliderH = 3;
//    [self.view addSubview:self.sagView];
    
    [self setUIWithIndex:0];
}

//通知刷新
- (void) addTitleView:(NSNotification *) noti {
    NSDictionary * dict = noti.userInfo;
    if (!dict || [dict isKindOfClass:[NSNull class]] || [dict isEqual:[NSNull null]]){
        return;
    }
//    NSString * moneyNews = dict[@"moneyNewsCount"];
//    NSString * operateNewsCount = dict[@"operateNewsCount"];
//    NSString * stateNewsCount = dict[@"stateNewsCount"];
//    self.sagView.titleArrNew = @[moneyNews,operateNewsCount,stateNewsCount];
}

//默认
 - (void)setUIWithIndex:(NSInteger)index{
     [self.pageViewController setViewControllers:@[self.pageContentArray[index]] direction:UIPageViewControllerNavigationDirectionReverse animated:nil completion:nil];
     [self addChildViewController:self.pageViewController];
     [self.view addSubview:self.pageViewController.view];
     
     //[self.sagView slidBtnWithIndex:index];
 }

//选择按钮
- (void)didTapBtnWithIndex:(NSInteger)index{
    [self.pageViewController setViewControllers:@[self.pageContentArray[index]] direction:UIPageViewControllerNavigationDirectionReverse animated:nil completion:nil];
 }

#pragma mark -- UIPageViewControllerDataSource
 //右滑的时候调用
 - (UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
     NSInteger index = [self.pageContentArray indexOfObject:viewController];
     if(index == 0 || index == NSNotFound) {
         return nil;
     }
     return [self.pageContentArray objectAtIndex:index-1];
 }
 
 //左滑的时候调用
 - (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
     NSInteger index = [self.pageContentArray indexOfObject:viewController];
     if ((index == self.pageContentArray.count - 1) || (index == NSNotFound)) {
         return nil;
     }
     return [self.pageContentArray objectAtIndex:index+1];
 }

#pragma mark -- UIPageViewControllerDelegate
// 将要滑动
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    UIViewController *nextVC = [pendingViewControllers firstObject];
    NSInteger index = [self.pageContentArray indexOfObject:nextVC];
    self.pageIndex = index;
}

// 结束滑动
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    if (completed) {
        //[self.sagView slidBtnWithIndex:self.pageIndex];
    }
}

#pragma mark -- lazy load
 - (NSMutableArray *)pageContentArray{
     if (!_pageContentArray) {
         _pageContentArray = [NSMutableArray array];
         for (int i = 0; i < 3; i++) {
             TDViewController * ctl = [[TDViewController alloc] init];
             ctl.view.backgroundColor = @[[UIColor blueColor],[UIColor greenColor],[UIColor brownColor]][i];
             [_pageContentArray addObject:ctl];
         }
     }
     return _pageContentArray;
 }

- (UIPageViewController *)pageViewController{
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        _pageViewController.view.frame = CGRectMake(0, 250, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height - 250 );
    }
    return _pageViewController;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
