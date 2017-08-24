//
//  SearchViewController.m
//  UI_Of_Youku_APP
//
//  Created by goyohol on 15/9/29.
//  Copyright © 2015年 goyohol. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //分栏选择器 隐藏
//    self.tabBarController.tabBar.hidden = YES;
    // hidesBottomBarWhenPushed属性    代替    tabBar.hidden
    
    
    self.view.backgroundColor = [UIColor whiteColor];//背景颜色:白
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];//镂空颜色
    //返回按钮
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 13, 16)];
    [btn setImage:[[UIImage imageNamed:@"back_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * item1 = [[UIBarButtonItem alloc]initWithCustomView:btn];
    [self.navigationItem setLeftBarButtonItem:item1];
    
    //search按钮
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search)];
    //搜索框
    UITextField * textfield = [[UITextField alloc]initWithFrame:CGRectMake(40, 20, 280, 25)];
    textfield.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0  blue:240/255.0  alpha:1];
    textfield.placeholder = @"SOKU搜库";
    textfield.borderStyle = UITextBorderStyleRoundedRect;
    textfield.returnKeyType = UIReturnKeySearch;
    UIBarButtonItem * item2 = [[UIBarButtonItem alloc]initWithCustomView:textfield];
    [self.navigationItem setRightBarButtonItems:@[item,item2]];
}
//返回上一界面
-(void)backto
{
    [self.navigationController popViewControllerAnimated:YES];
}
//搜索按钮
-(void)search
{

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
