//
//  ViewController.m
//  页面跳转转场动画自定义
//
//  Created by zyangshuang on 2017/7/5.
//  Copyright © 2017年 dhcc. All rights reserved.
//

#import "ViewController.h"
#import "CustomPushAnimation.h"
#import "PushViewController.h"
#import "CustomPresentAnimation.h"
#import "PresentViewController.h"

@interface ViewController ()<UINavigationControllerDelegate,UIViewControllerTransitioningDelegate>
@property (nonatomic, strong)CustomPushAnimation* pushAnimation;
@property (nonatomic, strong)CustomPresentAnimation* presentAnimation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor greenColor];
    UIButton* pushButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [pushButton setTitle:@"Push" forState:UIControlStateNormal];
    [pushButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    pushButton.frame = CGRectMake(20, 90, 80, 30);
    [self.view addSubview:pushButton];
    [pushButton addTarget:self action:@selector(pushButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* presentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [presentButton setTitle:@"present" forState:UIControlStateNormal];
    [presentButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    presentButton.frame = CGRectMake(20, 120, 80, 30);
    [self.view addSubview:presentButton];
    [presentButton addTarget:self action:@selector(presentButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.pushAnimation = [[CustomPushAnimation alloc]init];
    self.navigationController.delegate = self;
    self.presentAnimation = [[CustomPresentAnimation alloc]init];
}

- (void)pushButtonClicked
{
    PushViewController* VC = [[PushViewController alloc]init];
    VC.view.backgroundColor = [UIColor blueColor];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)presentButtonClicked{
    PresentViewController* vc = [[PresentViewController alloc]init];
    vc.transitioningDelegate = self;
    vc.modalTransitionStyle = UIModalPresentationCustom;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - Transitioning Delegate (modal)

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.presentAnimation.animationType = AnimationTypePresent;
    return self.presentAnimation;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    /**
     
     *  typedef NS_ENUM(NSInteger, UINavigationControllerOperation) {
     
     *     UINavigationControllerOperationNone,
     
     *     UINavigationControllerOperationPush,
     
     *     UINavigationControllerOperationPop,
     
     *  };
     
     */
    //push的时候用我们自己定义的customPush
    if (operation == UINavigationControllerOperationPush) {
        self.pushAnimation.animationType = pushType;
        return self.pushAnimation;
    }else{
        return nil;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
