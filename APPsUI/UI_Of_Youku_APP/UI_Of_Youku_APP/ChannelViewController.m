//
//  ChannelViewController.m
//  UI_Of_Youku_APP
//
//  Created by goyohol on 15/9/29.
//  Copyright © 2015年 goyohol. All rights reserved.
//

#import "ChannelViewController.h"
#import "SearchViewController.h"
#import "OldViewController.h"
@interface ChannelViewController ()
{
    UITableView * _tableView;
}
@end

@implementation ChannelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
//    UIImageView * imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"_2"]];
//    imageview.frame = self.view.frame;
//    [self.view addSubview:imageview];
    
#pragma mark - NavigationItem设置
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(12, 6, 100, 30)];
    label.text = @"频道";
    label.tag = 100;
    [self.navigationController.navigationBar addSubview:label];
    
    UIBarButtonItem * item1 =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"_2-2search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(onclick:)];
    item1.tag = 1;
    
    UIBarButtonItem * item2 = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"_2-3history"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(onclick:)];
    item2.tag = 2;
    
    [self.navigationItem setRightBarButtonItems:@[item2,item1]];
    
#pragma mark - tableView定制
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [_tableView setSectionHeaderHeight:0.0];
    [_tableView setRowHeight:30.0];
    
//    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 100)];
//    backView.backgroundColor = [UIColor redColor];
//    _tableView.backgroundView = backView;
    
    [self.view addSubview:_tableView];
}

#pragma mark - NavigationBarItem
-(void)onclick:(UIBarButtonItem *)item
{
    if (item.tag == 1) {
        SearchViewController * search = [[SearchViewController alloc]init];
        search.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:search animated:YES];
    }
    else{
        OldViewController * old = [[OldViewController alloc]init];
        old.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:old animated:YES];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [(UILabel *)[self.navigationController.navigationBar viewWithTag:100] setHidden:YES];//显示label“视频”
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];//隐藏label“视频”
    [(UILabel *)[self.navigationController.navigationBar viewWithTag:100] setHidden:NO];
    //分栏选择器 显示
//    self.tabBarController.tabBar.hidden = NO;
    // hidesBottomBarWhenPushed属性   代替    tabBar.hidden

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
