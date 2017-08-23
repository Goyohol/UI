//
//  ViewController.m
//  RoleWalkingWhenTouchDown
//
//  Created by RainHeroic Kung on 2017/8/24.
//  Copyright © 2017年 RainHeroic Kung. All rights reserved.
//

#import "ViewController.h"

#define screenBounds [UIScreen mainScreen].bounds

@interface ViewController ()
{
    NSTimer * _timer;
    //1.创建一个定时器
    NSTimer * _timerbird;
    
    
    
    float _moveDitance;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    //=============添加背景图片===============
    //1.创建背景图对象backgroundView
    UIImageView * backgroungView = [[UIImageView alloc]initWithFrame:screenBounds];
    //2.设置背景图片
    backgroungView.image = [UIImage imageNamed:@"map"];
    //2.将背景图添加到界面
    [self.view addSubview:backgroungView];
    
    //===============添加人物(UIImageview)==================
    //1.添加UIImageview对象
    UIImageView * imagePeople = [[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 80, 80)];
    //2.插入最初状态的 人物图片
    imagePeople.image = [UIImage imageNamed:@"player_down_2"];
    //3.添加人物图片 到界面
    [self.view addSubview:imagePeople];
    //获取UIImageView的tag值
    imagePeople.tag = 100;
    
    
    //============添加按钮(up,down,left,right)=================
    //1.创建按钮对象
    UIButton * buttonup = [[UIButton alloc]initWithFrame:CGRectMake((screenBounds.size.width-100)/2.0f, screenBounds.size.height-200, 100, 100)];
    UIButton * buttondown = [[UIButton alloc]initWithFrame:CGRectMake((screenBounds.size.width-100)/2.0f, screenBounds.size.height-100, 100, 100)];
    UIButton * buttonleft = [[UIButton alloc]initWithFrame:CGRectMake((screenBounds.size.width-100)/2.0f-100, screenBounds.size.height-150, 100, 100)];
    UIButton * buttonright = [[UIButton alloc]initWithFrame:CGRectMake((screenBounds.size.width-100)/2.0f+100, screenBounds.size.height-150, 100, 100)];
    //2.添加按钮对应图片
    [buttonup setImage:[UIImage imageNamed:@"button_up"] forState:UIControlStateNormal];
    [buttondown setImage:[UIImage imageNamed:@"button_down"] forState:UIControlStateNormal];
    [buttonleft setImage:[UIImage imageNamed:@"button_left"] forState:UIControlStateNormal];
    [buttonright setImage:[UIImage imageNamed:@"button_right"] forState:UIControlStateNormal];
    //    为各个按钮添加透明背景颜色
    buttonup.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.1];
    buttondown.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.1];
    buttonleft.backgroundColor = [UIColor colorWithRed:1 green:0 blue:1 alpha:0.2];
    buttonright.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:0.2];
    //3.添加按钮到界面
    [self.view addSubview:buttonup];
    [self.view addSubview:buttondown];
    [self.view addSubview:buttonleft];
    [self.view addSubview:buttonright];
    //❤️❤️❤️❤️❤️
    //4.给按钮 添加事件
    [buttonup addTarget:self action:@selector(buttonOnClickUp) forControlEvents:UIControlEventTouchDragInside];
    [buttondown addTarget:self action:@selector(buttonOnClickDown) forControlEvents:UIControlEventTouchDragInside];
    [buttonleft addTarget:self action:@selector(buttonOnClickleft) forControlEvents:UIControlEventTouchDragInside];
    [buttonright addTarget:self action:@selector(buttonOnClickright) forControlEvents:UIControlEventTouchDragInside];
    
    
    
    
    //点击后，移动的距离 (速度)
    _moveDitance = 5.f;
    
    
    
    
    
    
    //❤️❤️ ：在按下不放时，使用定时器        考虑两个状态：a.按下不放、b.弹起时
    //添加定时器
//    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(buttonOnClickDown) userInfo:nil repeats:YES];
    
    
}




//按钮 影响的事件
-(void)buttonOnClickUp      //上
{
    //移动
    UIImageView * people = (UIImageView *)[self.view viewWithTag:100];
    people.image = [UIImage imageNamed:@"player_up_2"];
    CGRect rect = people.frame;
    if (rect.origin.y <= 0)
    {
        rect.origin.y = 0;
    }
    people.frame = CGRectMake(rect.origin.x, rect.origin.y-_moveDitance, 80, 80);
    //上 ---   动画播放
    //a.设置播放图片组
    NSMutableArray * upAnimationImages = [[NSMutableArray alloc]init];
    for (int i = 1; i < 4; i++)
    {
        NSString * upimageName = [NSString stringWithFormat:@"player_up_%d",i];
        UIImage * image = [UIImage imageNamed:upimageName];
        [upAnimationImages addObject:image];
    }
    [people setAnimationImages:upAnimationImages];
    
    //b.播放一次 时间
    [people setAnimationDuration:0.5];
    //c.播放的次数   （无限次）
    [people setAnimationRepeatCount:1];
    //d.播放 画面
    [people startAnimating];
    
    //最终状态
    people.image = [UIImage imageNamed:@"player_up_2"];
    
}
-(void)buttonOnClickDown    //下
{
    
    
    UIImageView * people = (UIImageView *)[self.view viewWithTag:100];
    people.image = [UIImage imageNamed:@"player_down_2"];
    CGRect rect = people.frame;
    if (rect.origin.y >= screenBounds.size.height-80)
    {
        rect.origin.y = screenBounds.size.height - 80;
    }
    people.frame = CGRectMake(rect.origin.x, rect.origin.y+_moveDitance, 80, 80);
    //下 ---    动画播放
    //a.设置播放图片组
    NSMutableArray * upAnimationImages = [[NSMutableArray alloc]init];
    for (int i = 1; i < 4; i++)
    {
        NSString * upimageName = [NSString stringWithFormat:@"player_down_%d",i];
        UIImage * image = [UIImage imageNamed:upimageName];
        [upAnimationImages addObject:image];
    }
    [people setAnimationImages:upAnimationImages];
    
    //b.播放一次 时间
    [people setAnimationDuration:0.5];
    //c.播放的次数   （无限次）
    [people setAnimationRepeatCount:1];
    //d.播放 画面
    [people startAnimating];
    
    //最终状态
    people.image = [UIImage imageNamed:@"player_down_2"];
}
-(void)buttonOnClickleft    //左
{
    UIImageView * people = (UIImageView *)[self.view viewWithTag:100];
    people.image = [UIImage imageNamed:@"player_left_2"];
    CGRect rect = people.frame;
    if (rect.origin.x <= 0)
    {
        rect.origin.x = 0;
    }
    people.frame = CGRectMake(rect.origin.x-_moveDitance, rect.origin.y, 80, 80);
    //左 ---    动画播放
    //a.设置播放图片组
    NSMutableArray * upAnimationImages = [[NSMutableArray alloc]init];
    for (int i = 1; i < 4; i++)
    {
        NSString * upimageName = [NSString stringWithFormat:@"player_left_%d",i];
        UIImage * image = [UIImage imageNamed:upimageName];
        [upAnimationImages addObject:image];
    }
    [people setAnimationImages:upAnimationImages];
    
    //b.播放一次 时间
    [people setAnimationDuration:0.5];
    //c.播放的次数   （无限次）
    [people setAnimationRepeatCount:1];
    //d.播放 画面
    [people startAnimating];
    
    //最终状态
    people.image = [UIImage imageNamed:@"player_left_2"];
}
-(void)buttonOnClickright   //右
{
    UIImageView * people = (UIImageView *)[self .view viewWithTag:100];
    people.image = [UIImage imageNamed:@"player_right_2"];
    CGRect rect = people.frame;
    if (rect.origin.x >= screenBounds.size.width - 80)
    {
        rect.origin.x = screenBounds.size.width - 80;
    }
    people.frame = CGRectMake(rect.origin.x+_moveDitance, rect.origin.y, 80, 80);
    //右 ---    动画播放
    //a.设置播放图片组
    NSMutableArray * upAnimationImages = [[NSMutableArray alloc]init];
    for (int i = 1; i < 4; i++)
    {
        NSString * upimageName = [NSString stringWithFormat:@"player_right_%d",i];
        UIImage * image = [UIImage imageNamed:upimageName];
        [upAnimationImages addObject:image];
    }
    [people setAnimationImages:upAnimationImages];
    
    //b.播放一次 时间
    [people setAnimationDuration:0.5];
    //c.播放的次数   （无限次）
    [people setAnimationRepeatCount:1];
    //d.播放 画面
    [people startAnimating];
    
    //最终状态
    people.image = [UIImage imageNamed:@"player_right_2"];
}





















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
