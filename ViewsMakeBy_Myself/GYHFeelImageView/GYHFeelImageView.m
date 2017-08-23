//
//  GYHFeelImageView.m
//  ges
//
//  Created by RainHeroic Kung on 16/3/26.
//  Copyright © 2016年 RainHeroic Kung. All rights reserved.
//

#import "GYHFeelImageView.h"

@implementation GYHFeelImageView
{//先创建三个变量，用来保存 通过添加事件传过来的参数
    id _target;
    SEL _action;
    GYHEvent _event;
}

-(void)addTarget:(id)target action:(SEL)action forEvent:(GYHEvent)event
{
    //1.设置 ❤️能否接收事件
    self.userInteractionEnabled = YES;
    //2.保存传过来的对象、消息和事件（存起来，在确定的事件调用❤️）
    _target = target;
    _action = action;
    _event = event;
}
//按下 touchDown
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{//如果添加事件是GYHEventTouchDown，就在这儿使用传过来对象调用传过来的方法
    if (_event == GYHEventTouchDown) {
        //if语句是 为了防止_action没有被实现而导致的崩溃
        if([_target respondsToSelector:_action]){
            [_target performSelector:_action withObject:self];//保证响应对象是自己
        }
    }
}
//弹起 touchUpinside
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{//如果添加事件是GYHEventTouchUpinside，就在这儿使用传过来对象调用传过来的方法
    if (_event == GYHEventTouchUpinside) {
        if ([_target respondsToSelector:_action]) {
            [_target performSelector:_action withObject:self];
        }
    }
}

@end
