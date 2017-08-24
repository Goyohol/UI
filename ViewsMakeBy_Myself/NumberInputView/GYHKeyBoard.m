//
//  GYHKeyBoard.m
//  inputView
//
//  Created by goyohol on 16/5/19.
//  Copyright © 2016年 goyohol. All rights reserved.
//

#import "GYHKeyBoard.h"

@implementation GYHKeyBoard
{   //输入源数组
    NSArray * inputSourceArray;
}

//重写init方法
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //在这儿布局
        [self creatUI];
    }
    return self;
}

#pragma mark - 键盘布局
-(void)creatUI
{
    //1.确定键盘上要显示的内容，将其放到一个数组中
    inputSourceArray = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",@"清除",@"删除", nil];
    
    //2.根据键盘按钮，进行布局
    //间距
    CGFloat mergin = 10;
    //每行的 个数
    int lineCount = 3;
    // 宽度 = [(一行的按钮个数 + 1)*间距] / 一行的按钮个数
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - (lineCount + 1)*mergin) /lineCount;
    //高度
    CGFloat height = 60;
    
    //遍历输入源，计算 每个按钮的frame
    for (int i = 0 ; i < inputSourceArray.count; i++)
    {
        UIButton * button = [[UIButton alloc]init];
        // x:间距 + （i%个数）*（间距 + W）
        // Y:间距 + （i/个数）*（间距 + H）
        button.frame = CGRectMake(mergin + (i%lineCount)*(mergin + width), mergin + (i/lineCount)*(mergin + height), width, height);
        //显示文字
        [button setTitle:inputSourceArray[i] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor purpleColor]];
        //添加到界面上
        [self addSubview:button];
        
        //添加 点击事件
        [button addTarget:self action:@selector(onclick:) forControlEvents:UIControlEventTouchUpInside];
    }
}
//键盘被点击后，项要显示自己被点 的内容。但是键盘没有能力显示，所有需要一个 可以控制显示文字的对象❤️ 来帮他完成 显示这件事
//协议：显示指定的内容
//代理：ViewController
//委托：GYHKeyBoard (制定协议)     （❤️设置代理）




-(void)onclick:(UIButton *)button
{
    //打印按钮上的文字
    NSLog(@"%@",button.titleLabel.text);
    
    // 告诉代理显示文字  （❤️❤️点击按钮时）
    [self.delegate showText:button.titleLabel.text];
}



@end
