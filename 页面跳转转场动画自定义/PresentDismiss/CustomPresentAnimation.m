//
//  CustomPresentAnimation.m
//  NavigationBar的各种
//
//  Created by zyangshuang on 2017/7/4.
//  Copyright © 2017年 dhcc. All rights reserved.
//

#import "CustomPresentAnimation.h"

@implementation CustomPresentAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.8;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //目的ViewController
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //起始ViewController
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    if (self.animationType == AnimationTypePresent) {
        //添加toView到上下文
        [[transitionContext containerView] insertSubview:toViewController.view aboveSubview:fromViewController.view];
        //自定义动画
        toViewController.view.transform = CGAffineTransformMakeTranslation([UIScreen mainScreen].bounds.size.width-100, [UIScreen mainScreen].bounds.size.height - 60);
        toViewController.view.bounds = CGRectMake(0, 0, 100, 60);
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromViewController.view.transform = CGAffineTransformIdentity;
            toViewController.view.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            toViewController.view.transform = CGAffineTransformMakeTranslation(0, 0);
        }completion:^(BOOL finished) {
            fromViewController.view.transform = CGAffineTransformIdentity;
            //声明过渡结束时调用 completeTransition:这个方法
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }else{
        [[transitionContext containerView] insertSubview:toViewController.view belowSubview:fromViewController.view];
        //自定义动画
        toViewController.view.transform = CGAffineTransformMakeTranslation(0, 0);
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromViewController.view.transform = CGAffineTransformMakeTranslation([UIScreen mainScreen].bounds.size.width - 150, [UIScreen mainScreen].bounds.size.height - 60);
            toViewController.view.transform = CGAffineTransformMakeTranslation(0, 0);
        } completion:^(BOOL finished) {
            fromViewController.view.transform = CGAffineTransformIdentity;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}
@end
