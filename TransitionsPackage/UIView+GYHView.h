//
//  UIView+GYHView.h
//模态控制器切换
//
//  Created by goyohol on 16/2/23.
//  Copyright © 2016年 RainHeroic Kung. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    GYHTransitionFade,  //交叉淡化过渡
    GYHTransitionMoveIn,   //新视图移到旧视图上面
    GYHTransitionPush, //新视图把旧视图推出去
    GYHTransitionReveal,//将旧视图移开,显示下面的新视图
    GYHTransitionpageCurl,//向上翻一页
    GYHTransitionpageUnCurl,//向下翻一页
    GYHTransitionRippleEffect,//滴水效果
    GYHTransitionSuckEffect,//收缩效果，如一块布被抽走
    GYHTransitionCube,//立方体效果
    GYHTransitionOglFlip,//上下翻转效果
    GYHTransitionCameraIrisHollowOpen,//打开照相机效果
    GYHTransitionCameraIrisHollowClose//关闭相机效果
} GYHTransitionType;//❤️ 枚举名字


typedef enum : NSUInteger{  //运动方向
    GYHTransitionFromRight,
    GYHTransitionFromLeft,//(默认值)
    GYHTransitionFromTop,
    GYHTransitionFromBottom
} GYHTransitionDirection;

@interface UIView(GYHView)
//参数：都是自己定义的枚举类型❤️
-(void)addTransitionAnimationWithDuration:(double)duration type:(GYHTransitionType)transitionType Directiontype:(GYHTransitionDirection)direction;

@end
