//
//  GYHYoukuSegmentView.m
//  UI_Of_Youku_APP
//
//  Created by goyohol on 15/9/29.
//  Copyright © 2015年 goyohol. All rights reserved.
//

#import "GYHYoukuSegmentView.h"

#define Button_tag 100
#define margin (self.frame.size.width/self.items.count * (1/2.0f))

@interface GYHYoukuSegmentView ()
@property (nonatomic,strong) id target;//存 响应对象
@property (nonatomic,assign) SEL action;//存 响应消息
@end

@implementation GYHYoukuSegmentView
{
    UIView * _blueline;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _items = [[NSArray alloc]init];
        
    }
    return self;
}
-(void)layoutSubviews
{
    //1.创建按钮
    [self creatButton];
    //2.创建 滑线
    [self creatBlueline];
}

-(void)creatButton
{
    CGFloat buttonY = 0;
    CGFloat buttonW = (self.frame.size.width + margin)/self.items.count - margin;
    CGFloat buttonH = self.frame.size.height;
    int i = 0;
    for (NSString * title in self.items) {
        CGFloat buttonX = i * (buttonW+margin);
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:50/255.0 green:166/255.0 blue:235/255.0 alpha:1] forState:UIControlStateSelected];
        [self addSubview:button];
        
        [button addTarget:self action:@selector(buttonOnclick:) forControlEvents:UIControlEventTouchDown];
        
        button.tag = Button_tag + i;
        i ++;
    }
}

-(void)creatBlueline
{
    CGFloat lineX = 0;
    CGFloat lineH = 2;
    CGFloat lineW = (self.frame.size.width + margin)/self.items.count - margin;
    CGFloat lineY = self.frame.size.height - lineH;
    
    _blueline = [[UIView alloc]initWithFrame:CGRectMake(lineX, lineY, lineW, lineH)];
    _blueline.backgroundColor = [UIColor colorWithRed:50/255.0 green:166/255.0 blue:235/255.0 alpha:1];
    [self addSubview:_blueline];
}

-(void)buttonOnclick:(UIButton *)button
{
    UIButton * button2 = (UIButton *)[self viewWithTag:Button_tag + self.selectedIndex];
    button2.selected = NO;  //非选中状态
    button2.userInteractionEnabled = YES;   //可选
    
    button.selected = YES;
    button.userInteractionEnabled = NO;
    self.selectedIndex = button.tag - Button_tag;//确定下标
    
    //改变线的位置
    CGFloat lineX = (self.frame.size.width+margin)/self.items.count*self.selectedIndex;
    [UIView animateWithDuration:0.1 animations:^{
        _blueline.frame = CGRectMake(lineX, _blueline.frame.origin.y, _blueline.frame.size.width, _blueline.frame.size.height);
    }];
    
    //让对象响应消息 传递按钮点击事件
    if ([self.target respondsToSelector:self.action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Warc-performSelector-leaks" //根据警告(类型)提示 ，选择 字串
        [self.target performSelector:self.action withObject:self];
#pragma clang diagnostic pop
       
    }else{
        NSLog(@"没实现方法");
    }
}
#pragma mark - 添加事件响应
-(void)addTarget:(id)target withAction:(SEL)action
{
    self.target = target;
    self.action = action;
}


@end
