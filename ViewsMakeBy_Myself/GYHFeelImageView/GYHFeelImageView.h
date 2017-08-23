//
//  GYHFeelImageView.h
//  ges
//
//  Created by RainHeroic Kung on 16/3/26.
//  Copyright © 2016年 RainHeroic Kung. All rights reserved.
//

#import <UIKit/UIKit.h>
//创建属于自己的 事件机制(枚举❤️)
typedef enum :NSUInteger{
    GYHEventTouchDown,
    GYHEventTouchUpinside
} GYHEvent;

@interface GYHFeelImageView : UIImageView
//添加事件
-(void)addTarget:(id)target action:(SEL)action forEvent:(GYHEvent)event;

@end
