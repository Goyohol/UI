//
//  GameViewController.m
//  UI_Of_Youku_APP
//
//  Created by goyohol on 15/9/29.
//  Copyright © 2015年 goyohol. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //分栏选择器 隐藏
//    self.tabBarController.tabBar.hidden = YES;
    // hidesBottomBarWhenPushed属性    代替    tabBar.hidden
    
    self.view.backgroundColor = [UIColor whiteColor];//背景颜色:白
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    [self.navigationItem setTitle:@"游戏中心"];
    
    
    //返回按钮
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 10, 13)];
    [btn setImage:[[UIImage imageNamed:@"back_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * item1 = [[UIBarButtonItem alloc]initWithCustomView:btn];
    [self.navigationItem setLeftBarButtonItem:item1];
}
-(void)backto
{
    [self.navigationController popViewControllerAnimated:YES];
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
