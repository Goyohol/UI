//
//  SetViewController.m
//  UI_Of_Youku_APP
//
//  Created by goyohol on 15/9/29.
//  Copyright © 2015年 goyohol. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //分栏选择器 隐藏
//    self.tabBarController.tabBar.hidden = YES;
    // hidesBottomBarWhenPushed属性    代替    tabBar.hidden
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    //返回按钮
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 10, 13)];
    [btn setImage:[[UIImage imageNamed:@"back_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * item1 = [[UIBarButtonItem alloc]initWithCustomView:btn];
    //观看设置
    UILabel * title2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 30)];
    [title2 setText:@"|  设置"];
    UIBarButtonItem * item2 = [[UIBarButtonItem alloc]initWithCustomView:title2];
    [self.navigationItem setLeftBarButtonItems:@[item1,item2]];
    
}
-(void)backto
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
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
