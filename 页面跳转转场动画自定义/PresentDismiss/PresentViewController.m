//
//  PresentViewController.m
//  NavigationBar的各种
//
//  Created by zyangshuang on 2017/7/4.
//  Copyright © 2017年 dhcc. All rights reserved.
//

#import "PresentViewController.h"
#import "CustomPresentAnimation.h"

@interface PresentViewController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) CustomPresentAnimation* presentAnimation;

//交互控制器(Interaction Controllers) 通过遵从UIViewControllerInteractiveTransitoning 协议来控制可交互式的转场
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition* interactionController;

@end

@implementation PresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.presentAnimation = [[CustomPresentAnimation alloc]init];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"back" forState:UIControlStateNormal];
    button.frame = CGRectMake(20, 40, 80, 40);
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIPanGestureRecognizer*panRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(didClickPanGestureRecognizer:)];
    [self.view addGestureRecognizer:panRecognizer];
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.presentAnimation.animationType = AnimationTypeDismiss;
    return self.presentAnimation;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return _interactionController;
}

#pragma mark - 手势交互的主要表现--->UIPercentDrivenInteractiveTransition
- (void)didClickPanGestureRecognizer:(UIPanGestureRecognizer*)recognize
{
    UIView* view = self.view;
    if (recognize.state == UIGestureRecognizerStateBegan) {
        //创建过渡对象,弹出viewController
        self.interactionController = [[UIPercentDrivenInteractiveTransition alloc]init];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (recognize.state == UIGestureRecognizerStateChanged){
        //获取手势在视图上偏移的坐标
        CGPoint translation = [recognize translationInView:view];
        //根据手指拖动的距离计算一个百分比,切换的动画效果也随着这个百分比来走
        CGFloat distance = fabs(translation.x / CGRectGetWidth(view.bounds));
        //交互控制器控制动画的进度
        [self.interactionController updateInteractiveTransition:distance];
    }else if (recognize.state == UIGestureRecognizerStateEnded){
        CGPoint translation = [recognize translationInView:view];
        //根据手指拖动的距离计算一个百分比,切换的动画效果也随着这个百分比来走
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
    self.transitioningDelegate = self;
    self.modalPresentationStyle = UIModalPresentationCustom;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.transitioningDelegate = nil;
    self.modalPresentationStyle = UIModalPresentationNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
