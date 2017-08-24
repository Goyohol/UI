//
//  ViewController.m
//  FlyBird_Animation
//
//  Created by goyohol on 2015/6/17.
//  Copyright © 2015年 goyohol. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{   //1.创建一个定时器
    NSTimer * _timer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.设置背景图对象
    UIImageView * backview = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //2.设置背景图
    backview.image = [UIImage imageNamed:@"back2.jpg"];
    //3.添加背景图 到界面
    [self.view addSubview:backview];
    
    
    //播放帧动画
    //1.使用UIImageView显示帧动画
    UIImageView * birdflyimageview = [[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 100, 100)];
    //设置静态图片
    birdflyimageview.image = [UIImage imageNamed:@"DOVE 1.png"];
    //显示图片 在界面
    [self.view addSubview:birdflyimageview];
    
    //2.播放帧动画
    //a.设置图片组
    NSMutableArray * animationImages = [[NSMutableArray alloc]init];
    for (int i = 1; i < 19; i++)
    {
        NSString * imageName = [NSString stringWithFormat:@"DOVE %d.png",i];
        UIImage * image = [UIImage imageNamed:imageName];
        [animationImages addObject:image];
    }
    [birdflyimageview setAnimationImages:animationImages];
    
    //b.动画播放的时间(周期)间隔
    [birdflyimageview setAnimationDuration:1];
    //c.动画播放的次数（无穷次）
    [birdflyimageview setAnimationRepeatCount:0];
    //d.播放动画
    [birdflyimageview startAnimating];
    
    birdflyimageview.tag = 10;
    
    
    //添加定时器， 并且 实例化
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(moveright) userInfo:nil repeats:YES];
    
}

-(void)moveright
{   //鸟🐦飞
    //1.飞鸟对象
    UIView * birdfly = (UIView *)[self.view viewWithTag:10];
    CGRect rect = birdfly.frame;
    if (rect.origin.x==[UIScreen mainScreen].bounds.size.width) //飞到右边界
    {
        rect.origin.x = -50;    //让头慢慢出来
        
    }
    if (rect.origin.y==-50) //尾巴飞出顶部
    {
        rect.origin.y = [UIScreen mainScreen].bounds.size.height;
    }
    
    birdfly.frame = CGRectMake(rect.origin.x+1, rect.origin.y-1, 100, 100);
    
}












- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
