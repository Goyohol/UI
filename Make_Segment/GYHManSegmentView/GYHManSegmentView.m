//
//  GYHManSegmentView.m
//  112
//
//  Created by RainHeroic Kung on 16/3/26.
//  Copyright © 2016年 RainHeroic Kung. All rights reserved.
//

#import "GYHManSegmentView.h"

#define Button_tag 100
#define margin (self.frame.size.width/self.items.count * (1/5.0f))

@interface GYHManSegmentView()
//创建两个属性
@property (nonatomic,strong) id target; //存响应消息的对象
@property (nonatomic,assign) SEL action;//存响应消息

@end


@implementation GYHManSegmentView
{
    UIView * line;
    UIView * slider;
}

////每次给items属性赋值的时候 就会调用这方法
//-(void)setItems:(NSArray *)items
//{
//    _items = items;
//}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _items = [[NSArray alloc]init];
    }
    return self;
}

//当视图真正 显示在界面上的时候 才会调用（这时的属性的值肯定是最后一次赋的值）
//在这儿创建动态子视图，设置和当前视图frame相关的子视图的frame
-(void)layoutSubviews
{
    //1.创建按钮
    [self creatButton];
    //2.创建滑块
    [self creatLineAndSlider];
    
    //    NSLog(@"layoutSubviews");
    //    NSLog(@"X:%f Y:%f",self.frame.origin.x,self.frame.origin.y);
}
#pragma mark -创建线和滑块
-(void)creatLineAndSlider
{
    //1.创建 线 (全局变量)
    CGFloat lineX = 0;
    CGFloat lineH = 2;
    CGFloat lineY = self.frame.size.height - lineH;
    CGFloat lineW = self.frame.size.width;
    line = [[UIView alloc]initWithFrame:CGRectMake(lineX, lineY, lineW, lineH)];
    line.backgroundColor = [UIColor orangeColor];
    [self addSubview:line];
    
    //2.创建滑块
    //    CGFloat margin = self.frame.size.width/self.items.count * (1/5.0f);
    CGFloat sliderX = margin;
    CGFloat sliderH = 4;
    CGFloat sliderY = lineY - sliderH;
    CGFloat sliderW = self.frame.size.width/self.items.count - margin*2;
    slider = [[UIView alloc]initWithFrame:CGRectMake(sliderX, sliderY, sliderW, sliderH)];
    slider.backgroundColor = [UIColor orangeColor];
    [self addSubview:slider];
    
    //    //设置tag值
    //    slider.tag = Button_tag + i;
    //
    //    i ++;
    
}

#pragma mark - 创建按钮
-(void)creatButton
{
    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width/self.items.count;
    CGFloat buttonH = self.frame.size.height;
    
    int i = 0;  //宽度确定
    for(NSString * title in self.items)
    {
        CGFloat buttonX = i * buttonW;
        //创建按钮
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
        //设置title
        [button setTitle:title forState:UIControlStateNormal];
        //设置字体颜色
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        //显示在界面上
        [self addSubview:button];
        
        //添加点击事件
        [button addTarget:self action:@selector(buttonOnclicked:) forControlEvents:UIControlEventTouchDown];
        
        //设置tag值
        button.tag = Button_tag + i;
        
        i ++;
    }
}
#pragma mark - 按钮点击
-(void)buttonOnclicked:(UIButton *)button
{
    //找到上次选中的按钮，将其变成没有选中(变回原来的颜色)
    UIButton *  button2 = (UIButton *)[self viewWithTag:Button_tag + self.seletedSegmentIndex];
    button2.selected = NO;//状态变为不被选中状态
    
    //让上次的按钮 变为 可选
    button2.userInteractionEnabled = YES;
    //将当前选中的变为选中
    button.selected = YES;
    button.userInteractionEnabled = NO;//变为 不可选
    self.seletedSegmentIndex = button.tag - Button_tag;//确定下标
    
    
    
    //改变滑块的位置
    CGFloat sliderX = self.frame.size.width/self.items.count * self.seletedSegmentIndex + margin;
    [UIView animateWithDuration:0.3f animations:^{
        slider.frame = CGRectMake(sliderX, slider.frame.origin.y, slider.frame.size.width, slider.frame.size.height);   //带入动画
    }];
    
    //让对象响应消息，传递按钮点击事件
    if ([self.target respondsToSelector:self.action])
    {
        [self.target performSelector:self.action withObject:self];//版本(Version)问题，有警告
    }
    else
    {
        NSLog(@"没有实现方法");
    }
}

#pragma mark - 添加事件响应
-(void)addTarget:(id)target action:(SEL)action
{   //传过来的消息存起来，再 合适的时候 [self.target self.action]
    self.target = target;
    self.action = action;
}


@end
