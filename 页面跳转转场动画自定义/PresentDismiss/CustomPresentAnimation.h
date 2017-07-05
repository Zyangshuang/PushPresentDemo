//
//  CustomPresentAnimation.h
//  NavigationBar的各种
//
//  Created by zyangshuang on 2017/7/4.
//  Copyright © 2017年 dhcc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,PresentType) {
    AnimationTypePresent,
    AnimationTypeDismiss
};

@interface CustomPresentAnimation : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic,assign) PresentType animationType;

@end
