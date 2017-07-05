//
//  CustomPushAnimation.h
//  NavigationBar的各种
//
//  Created by zyangshuang on 2017/7/4.
//  Copyright © 2017年 dhcc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AnimationType) {
    popType,
    pushType
};

@interface CustomPushAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) AnimationType animationType;

@end
