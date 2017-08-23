//
//  UIView+GYHView.m
//模态控制器切换
//
//  Created by goyohol on 16/2/23.
//  Copyright © 2016年 goyohol. All rights reserved.
//

#import "UIView+GYHView.h"

@implementation UIView(GYHView)
//重写 动画方法❤️
-(void)addTransitionAnimationWithDuration:(double)duration type:(GYHTransitionType)transitionType Directiontype:(GYHTransitionDirection)direction
{
    //1.创建一个切换 动画对象
    CATransition * transition = [CATransition animation];
    
    //2.设置 动画时间
    transition.duration = duration;
    //3.设置 动画类型
    NSArray * typeArray = @[kCATransitionFade,kCATransitionMoveIn,kCATransitionPush,kCATransitionReveal,@"pageCurl",@"pageUnCurl",@"rippleEffect",@"suckEffect",@"cube",@"oglFlip",@"cameraIrisHollowOpen",@"cameraIrisHollowClose"];
    transition.type = typeArray[transitionType];
    //4.设置动画方向
    NSArray * directionArray = @[kCATransitionFromRight,kCATransitionFromLeft,kCATransitionFromTop,kCATransitionFromBottom];
    transition.subtype = directionArray[direction];
    //5.添加动画()
    [self.window.layer addAnimation:transition forKey:nil];
}

@end
