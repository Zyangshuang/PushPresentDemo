//
//  PushViewController.m
//  NavigationBar的各种
//
//  Created by zyangshuang on 2017/7/4.
//  Copyright © 2017年 dhcc. All rights reserved.
//

#import "PushViewController.h"
#import "CustomPushAnimation.h"

@interface PushViewController ()<UINavigationControllerDelegate,UIViewControllerInteractiveTransitioning>

//交互控制器 (Interaction Controllers) 通过遵从 UIViewControllerInteractiveTransitioning协议来控制可交互式转场
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition* interactionController;
@property (nonatomic, strong) CustomPushAnimation* pushAnimation;

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //实现交互操作的手势
    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(didClickPanGestureRecognizer:)];
    [self.view addGestureRecognizer:panGesture];
    self.pushAnimation = [[CustomPushAnimation alloc]init];
}

//交互
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    /*
     在非交互式动画效果中,该方法返回nil
     交互式转场中,自我理解意思是,用户能通过自己的动作(常见:手势)控制,不同于系统缺省给定的push或者pop(非交互式)
     */
    return _interactionController;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        return nil;
    }else{
        self.pushAnimation.animationType = popType;
        return self.pushAnimation;
    }
}

#pragma mark - 手势交互
- (void)didClickPanGestureRecognizer:(UIPanGestureRecognizer*)recognizer
{
    UIView* view = self.view;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.interactionController = [[UIPercentDrivenInteractiveTransition alloc]init];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        CGPoint translation = [recognizer translationInView:view];
        CGFloat distance = fabs(translation.x / CGRectGetWidth(view.bounds));
        [self.interactionController updateInteractiveTransition:distance];
    }else if (recognizer.state == UIGestureRecognizerStateEnded){
        CGPoint translation = [recognizer translationInView:view];
        CGFloat distance = fabs(translation.x / CGRectGetWidth(view.bounds));
        if (distance > 0.5) {
            [self.interactionController finishInteractiveTransition];
        }else{
            [self.interactionController cancelInteractiveTransition];
        }
        self.interactionController = nil;
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
