//
//  ViewController.m
//  BalckCat_Login_UI
//
//  Created by RainHeroic Kung on 2017/8/24.
//  Copyright © 2017年 RainHeroic Kung. All rights reserved.
//

#import "ViewController.h"
#import "GYHTextField.h"

#define screenabout [UIScreen mainScreen].bounds

@interface ViewController ()<UITextFieldDelegate>
{
    UILabel * label;
}
@end

@implementation ViewController
#pragma mark - 登录界面
-(void)creatLogin
{
    //1.添加背景图
    UIImageView * backgound = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    backgound.image = [UIImage imageNamed:@"3.jpg"];
    [self.view addSubview:backgound];
    
    //==============放置所有登录相关的琐碎的view===============
#pragma mark - 总视图bossView
    UIView * bossView = [[UIView alloc]initWithFrame:CGRectMake((screenabout.size.width - 260)/2.0f, 180, 260, 280)];
    //        bossView.backgroundColor = [UIColor redColor];
    //        bossView.alpha = 0.5;
    [self.view addSubview:bossView];
    bossView.tag = 1;//添加tag值
    //=============================================
    
    
    //3.添加白色视图(装UITextfield对象)
    UIView * whiteView = [[UIView alloc]initWithFrame:CGRectMake((260-230)/2.0f, 70, 230, 110)];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.tag = 2;
    [bossView addSubview:whiteView];
    
    //4.登录按钮
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(30/2.0f, 200, 230, 30)];
    button.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:0.5];
    [button setTitle:@"登录" forState:UIControlStateNormal];
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [bossView addSubview:button];
    [button addTarget:self action:@selector(onclick) forControlEvents:UIControlEventTouchUpInside];
    
    //=========================================
    //添加 头部
    UIImageView * viewhead = [[UIImageView alloc]initWithFrame:CGRectMake(160/2.0f, 15, 100, 60)];
    viewhead.image = [UIImage imageNamed:@"header"];
    [bossView addSubview:viewhead];
    viewhead.tag = 300;
    //添加小手
    UIImageView * viewleft = [[UIImageView alloc]initWithFrame:CGRectMake(240/2.0f-40, 60, 20, 20)];
    UIImageView * viewright = [[UIImageView alloc]initWithFrame:CGRectMake(240/2.0f+40, 60, 20, 20)];
    viewleft.image = [UIImage imageNamed:@"hand"];
    viewright.image = [UIImage imageNamed:@"hand"];
    [bossView addSubview:viewleft];
    [bossView addSubview:viewright];
    //获取tag值
    viewleft.tag = 100;
    viewright.tag = 200;
    
    //===========================================
#pragma mark - 创建自定制对象
    //2.添加GYHTextField对象
    GYHTextField * uiTextField1 = [[GYHTextField alloc]initWithFrame:CGRectMake(10, 20, 200, 30)];    //尺寸
    GYHTextField * uiTextField2 = [[GYHTextField alloc]initWithFrame:CGRectMake(10, 60, 200, 30)];
    [whiteView addSubview:uiTextField1];    //添加到界面
    [whiteView addSubview:uiTextField2];
    uiTextField1.backgroundColor = [UIColor whiteColor];//背景色
    uiTextField2.backgroundColor = [UIColor whiteColor];
    //设置字体
    //    uiTextField1.font = [UIFont systemFontOfSize:12];
    //边框圆滑
    [uiTextField1 setBorderStyle:UITextBorderStyleRoundedRect];
    [uiTextField2 setBorderStyle:UITextBorderStyleRoundedRect];
    //占位文字
    [uiTextField1 setPlaceholder:@"请输入账号"];
    uiTextField2.placeholder = @"请输入密码";
    
    
    //设置左视图
    UIImageView * leftimageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    leftimageView1.image = [UIImage imageNamed:@"user"];
    uiTextField1.leftView = leftimageView1;//获得左视图
    [uiTextField1 setLeftViewMode:UITextFieldViewModeAlways];
    
    UIImageView * leftimageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    leftimageView2.image = [UIImage imageNamed:@"pass"];
    uiTextField2.leftView = leftimageView2;//获得子视图
    [uiTextField2 setLeftViewMode:UITextFieldViewModeAlways];
    
    
    [uiTextField1 setClearButtonMode:UITextFieldViewModeAlways];        //清除按钮
    [uiTextField2 setClearButtonMode:UITextFieldViewModeAlways];
    //设置键盘样式
    [uiTextField1 setKeyboardType:UIKeyboardTypeDefault];
    [uiTextField2 setKeyboardType:UIKeyboardTypeAlphabet];
    
    //键盘2 不显示二级(子)键盘 ❤️？？？？？？？？？？❤️
    [uiTextField2 setInputAccessoryView:NULL];
    
    //=============================================
    //设置代理  （都可以实现）
    uiTextField1.delegate = self;
    uiTextField2.delegate = self;
    //    //设置tag值
    uiTextField1.tag = 10;
    uiTextField2.tag = 20;
}
#pragma mark — 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    //创建登录界面
    [self creatLogin];
}
#pragma mark - 登录按钮
//点击登录
-(void)onclick
{
    UITextField * field1 = (UITextField *)[self.view viewWithTag:10];
    UITextField * field2 = (UITextField *)[self.view viewWithTag:20];
    
    UIView * bossview = (UIView *)[self.view viewWithTag:1];
    if ([field1.text  isEqualToString:@"goyohol"]&&[field2.text  isEqualToString:@"goyohol"]) //账户名：goyohol ，密码：goyohol
    {
        [bossview removeFromSuperview];//删除bossview里的所有视图
        UILabel * label1 = [self.view viewWithTag:1000];
        [label1 removeFromSuperview];   //删除输入提醒栏视图
        
        UILabel * labelin = [[UILabel alloc]initWithFrame:CGRectMake((screenabout.size.width-300)/2.0f, screenabout.size.height/2.0f, 300, 30)];
        labelin.backgroundColor = [UIColor colorWithRed:0 green:1 blue:1 alpha:0.6];
        labelin.text = @"Nothing,Aha~~ 登录成功！啥也没有哦！！！";
        [labelin setTextAlignment:NSTextAlignmentCenter];
        [self.view addSubview:labelin];
#pragma mark - 返回按钮
        //添加 返回按钮
        UIButton * buttonreturn = [[UIButton alloc]initWithFrame:CGRectMake((screenabout.size.width - 100)/2.0f, screenabout.size.height/2.0 - 60, 100, 50)];
        buttonreturn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.2];
        [buttonreturn setTitle:@"back(返回)" forState:UIControlStateNormal];
        [buttonreturn addTarget:self action:@selector(creatLogin) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:buttonreturn];
        
        NSLog(@"登录成功！");
    }
    if(![field2.text isEqualToString:@"gyh"]&&![field2.text isEqualToString:@""])// 密码有 且 错误
    {   //提醒栏  信息
        label = [[UILabel alloc]initWithFrame:CGRectMake((bossview.frame.size.width-150)/2.0f, 70, 150, 20)];
        label.backgroundColor = [UIColor colorWithRed:1 green:0 blue:1 alpha:0.3];
        label.text = @"用户名或密码错误";
        [label setTextAlignment:NSTextAlignmentCenter];
        [bossview addSubview:label];
        label.tag = 1000;
    }
}

////登录成功，返回(登录界面)按钮
//-(void)backToLogIn
//{
//    //根据tag值 创建 新的登录界面
//    UIView * newBossView = (UIView *)[self.view viewWithTag:1];
//    [self.view addSubview:newBossView];//之前的值也被删除
//}
#pragma mark - 输入时
//开始编辑 密码时，(1.)产生动画    （2.）登录视图整体上移
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    UIView * label1 = (UIView *)[self.view viewWithTag:1000];
    [label1 removeFromSuperview];   //去除 提醒栏
    
    if(textField.tag == 20) // 在密码上 编辑
    {
        UIView * bossview = (UIView *)[self.view viewWithTag:1];
        UIView * whiteview  = (UIView *)[self.view viewWithTag:2];
        UIView * headview = (UIView *)[self.view viewWithTag:300];
        [UIView animateWithDuration:0.3 animations:^{
            UIImageView * player1 = (UIImageView *)[self.view viewWithTag:100];
            UIImageView * player2 = (UIImageView *)[self.view viewWithTag:200];
            player1.frame = CGRectMake(240/2.0f-13, 50, 20, 30); //猫头鹰右手位置
            player2.frame = CGRectMake(240/2.0f+16, 50, 20, 30);//猫头鹰左手位置
            player1.image = [UIImage imageNamed:@"left"];//左 我们看到
            player2.image = [UIImage imageNamed:@"right"];
            [bossview insertSubview:headview belowSubview:whiteview];//头放在whiteview下
            [bossview insertSubview:player1 belowSubview:whiteview];//手放在whiteview下
            [bossview insertSubview:player2 belowSubview:whiteview];//手放在whiteview下
        }];
    }
    else    //不在密码按键 上
    {
        [UIView animateWithDuration:0.3 animations:^{
            UIImageView * player1 = (UIImageView *)[self.view viewWithTag:100];
            UIImageView * player2 = (UIImageView *)[self.view viewWithTag:200];
            player1.frame = CGRectMake(240/2.0f-40, 60, 20, 20);
            player2.frame = CGRectMake(240/2.0f+40, 60, 20, 20);
            player1.image = [UIImage imageNamed:@"hand"];
            player2.image = [UIImage imageNamed:@"hand"];
        }];
    }
    //bossview整体移动
    UIView * bossview = (UIView *)[self.view viewWithTag:1];
    [bossview setTransform:CGAffineTransformMakeTranslation(0, -50)];
    //界面画面 整体上移
    //    [self.view setTransform:CGAffineTransformMakeTranslation(0, -100)];
}

#pragma mark - 输入完成return
//按return时，实现退出键盘输入界面
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    UILabel * label1 = [self.view viewWithTag:1000];
    [label1 removeFromSuperview];       //去除提醒栏
    
    //    UITextField * textfield1 = (UITextField *)[self.view viewWithTag:10];
    //    UITextField * textfield2 = (UITextField *)[self.view viewWithTag:20];
    //    //所有边框都不为第一响应者
    [textField resignFirstResponder];
    //    [textfield1 resignFirstResponder];
    //    [textfield2 resignFirstResponder];
    
    //return后 也把手放下
    [UIView animateWithDuration:0.3 animations:^{
        UIImageView * player1 = (UIImageView *)[self.view viewWithTag:100];
        UIImageView * player2 = (UIImageView *)[self.view viewWithTag:200];
        player1.frame = CGRectMake(240/2.0f-40, 60, 20, 20);
        player2.frame = CGRectMake(240/2.0f+40, 60, 20, 20);
        player1.image = [UIImage imageNamed:@"hand"];
        player2.image = [UIImage imageNamed:@"hand"];
    }];
    //bossview整体回到原处
    UIView * bossview = (UIView *)[self.view viewWithTag:1];
    [bossview setTransform:CGAffineTransformMakeTranslation(0, 0)];
    
    //界面画面 整体回到原处
    //    [self.view setTransform:CGAffineTransformMakeTranslation(0, 0)];
    return YES;
}




















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
