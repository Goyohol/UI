//
//  MyViewController.m
//  UI_Of_Youku_APP
//
//  Created by goyohol on 15/9/29.
//  Copyright © 2015年 goyohol. All rights reserved.
//

#import "MyViewController.h"
#import "MessageViewController.h"
#import "SetViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    UIImageView * imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"_4"]];
//    imageview.frame = self.view.frame;
//    [self.view addSubview:imageview];
    
#pragma mark - NavigationItem设置
    UIView * gyhvc = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 90)];
    gyhvc.backgroundColor = [UIColor colorWithRed:30/255.0 green:171/255.0 blue:253/255.0 alpha:1];
    [self.view addSubview:gyhvc];
    
    //隐藏导航栏
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController.navigationBar setTranslucent:NO];
    
    
    UIButton * userbtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 65, 65)];
    [userbtn setImage:[[UIImage imageNamed:@"_4-1picture"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [userbtn addTarget:self action:@selector(loginclick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * userbtn2 = [[UIButton alloc]initWithFrame:CGRectMake(85, 25, 75, 25)];
    [userbtn2 addTarget:self action:@selector(loginclick) forControlEvents:UIControlEventTouchUpInside];
    [userbtn2 setTitle:@"未登录" forState:UIControlStateNormal];
    userbtn2.titleLabel.textColor = [UIColor whiteColor];
    
    [gyhvc addSubview:userbtn];
    [gyhvc addSubview:userbtn2];
    
    UIButton * vipbtn = [[UIButton alloc]initWithFrame:CGRectMake(85, 53, 75, 25)];
    [vipbtn setImage:[[UIImage imageNamed:@"_4-2BeVip"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [vipbtn addTarget:self action:@selector(vipway) forControlEvents:UIControlEventTouchUpInside];
    [gyhvc addSubview:vipbtn];
    //===================================
    UIButton * message = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 70, 25, 25, 25)];
    [message setImage:[UIImage imageNamed:@"_4-3message"] forState:UIControlStateNormal];
    [message addTarget:self action:@selector(onclick:) forControlEvents:UIControlEventTouchUpInside];
    message.tag = 1;
    [gyhvc addSubview:message];

    UIButton * set = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 33, 25, 25, 25)];
    [set setImage:[UIImage imageNamed:@"_4-4set"] forState:UIControlStateNormal];
    [set addTarget:self action:@selector(onclick:) forControlEvents:UIControlEventTouchUpInside];
    set.tag = 2;
    [gyhvc addSubview:set];
    
}

-(void)loginclick
{
    
}
-(void)vipway
{
    
}
-(void)onclick:(UIButton *)button
{
    if (button.tag == 1) {
        MessageViewController * message = [[MessageViewController alloc]init];
        message.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:message animated:YES];
    }else{
        SetViewController * set = [[SetViewController alloc]init];
        set.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:set animated:YES];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //分栏选择器 显示
//    self.tabBarController.tabBar.hidden = NO;
    // hidesBottomBarWhenPushed属性    代替    tabBar.hidden
    
    //导航栏 隐藏
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //导航栏 显示
    self.navigationController.navigationBarHidden = NO;
}


    



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
