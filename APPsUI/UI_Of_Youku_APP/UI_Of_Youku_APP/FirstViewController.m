//
//  FirstViewController.m
//  UI_Of_Youku_APP
//
//  Created by goyohol on 15/9/29.
//  Copyright © 2015年 goyohol. All rights reserved.
//

#import "FirstViewController.h"
#import "SearchViewController.h"
#import "CrownViewController.h"
#import "GameViewController.h"
#import "OldViewController.h"

@interface FirstViewController ()<UITableViewDataSource>
{
    UIImageView * _imageView;
    UIView * _itemView;
    UITableView * _tableView;
}
@property (nonatomic,strong) NSMutableArray * dataArray;
@end

@implementation FirstViewController
{
    int i;//全局变量(按钮 控制) ❤️实现itemView之外 的点击
}
#pragma mark - 懒加载
-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
        NSString * path = [[NSBundle mainBundle]pathForResource:@"data2.plist" ofType:nil];
        NSArray * plistArray = [[NSArray alloc]initWithContentsOfFile:path];
        for (NSDictionary * dict in plistArray) {
            [_dataArray addObject:dict];
        }
    }
    return _dataArray;
}

#pragma mark - creatTableView
-(void)creatTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 120) style:UITableViewStylePlain];//无间隙，对应的差值：20+44+49=113
    _tableView.dataSource = self;
    
    _tableView.rowHeight = 100;
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"id";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    NSDictionary * dict = self.dataArray[indexPath.row];
    cell.imageView.image = [UIImage imageWithData:dict[@"image_data"]];//取Plist文件里的 图片data
    cell.textLabel.text = dict[@"title"];
    
    return cell;
}


#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
//    UIImageView * imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"_1"]];
//    imageview.frame = self.view.frame;
//    [self.view addSubview:imageview];
    
    
    [self creatTableView];
    //=================设置手势===================
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(otherClick:)];
    [self.view addGestureRecognizer:tap];
    
#pragma mark - NavigationItem设置
    //标志 图片
    _imageView = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"_1-1title"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    _imageView.tag = 100;
    [self.navigationController.navigationBar addSubview:_imageView];
    _imageView.frame = CGRectMake(15, 3, _imageView.frame.size.width, _imageView.frame.size.height);
    
    //=====================导航栏====================
    UIBarButtonItem * item1 = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"_1-2search"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(onclick:)];
    item1.tag = 1;
    
    UIBarButtonItem * item2 = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"_1-3crown"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(onclick:)];
    item2.tag = 2;
    
    UIBarButtonItem * item3 = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"_1-4game"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(onclick:)];
    item3.tag = 3;
    
    UIBarButtonItem * item4 = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"_1-5other"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(onclick:)];
    item4.tag = 4;
    
    //间距？？？？？？？？？？
    UIBarButtonItem * space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];

    [space setWidth:2];//    space.width = 2;
    [self.navigationItem setRightBarButtonItems:@[item4,space,item3,space,item2,space,item1]];
}
-(void)otherClick:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:self.view];
    if (!(_itemView.frame.origin.x<=point.x&&point.x<=self.view.frame.size.width&&_itemView.frame.origin.y<=point.y&&point.y<=_itemView.frame.size.height+_itemView.frame.origin.y)) {
        //点击手势 点击 其他地方❤️
        [_itemView removeFromSuperview];
        i = 0;
    }
}


-(void)onclick:(UIBarButtonItem *)item
{
    
    
    switch (item.tag) {
        case 1:{
            SearchViewController * search = [[SearchViewController alloc]init];
            search.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:search animated:YES];
        }break;
        case 2:{
            CrownViewController * crown = [[CrownViewController alloc]init];
            crown.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:crown animated:YES];
        }break;
        case 3:{
            GameViewController * game = [[GameViewController alloc]init];
            game.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:game animated:YES];
        }break;
        case 4:{
            
            if (i == 0) {
                UIButton * button1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 110, 35)];
                button1.tag = 100;
                [button1 addTarget:self action:@selector(btnonclick:) forControlEvents:UIControlEventTouchUpInside];
                [button1 setTitle:@"记录" forState:UIControlStateNormal];
                [button1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                UIImageView * old = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"_2-3history"]];
                old.frame = CGRectMake(8, 8, 20, 20);
                [button1 addSubview:old];
                
                UIButton * button2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 35, 110, 35)];
                button2.tag = 200;
                [button2 addTarget:self action:@selector(btnonclick:) forControlEvents:UIControlEventTouchUpInside];
                [button2 setTitle:@"下载" forState:UIControlStateNormal];
                [button2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                UIImageView * old2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_downloading"]];
                old2.frame = CGRectMake(8, 8, 20, 20);
                [button2 addSubview:old2];
                
                UIButton * button3 = [[UIButton alloc]initWithFrame:CGRectMake(0, 70, 110, 35)];
                button3.tag = 300;
                [button3 addTarget:self action:@selector(btnonclick:) forControlEvents:UIControlEventTouchUpInside];
                [button3 setTitle:@"上传" forState:UIControlStateNormal];
                [button3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                UIImageView * old3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_upload"]];
                old3.frame = CGRectMake(8, 8, 20, 20);
                [button3 addSubview:old3];
                
                UIButton * button4 = [[UIButton alloc]initWithFrame:CGRectMake(0, 105, 110, 35)];
                button4.tag = 400;
                [button4 addTarget:self action:@selector(btnonclick:) forControlEvents:UIControlEventTouchUpInside];
                [button4 setTitle:@"扫一扫" forState:UIControlStateNormal];
                [button4 setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
                [button4 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                UIImageView * old4 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_saosao"]];
                old4.frame = CGRectMake(8, 8, 20, 20);
                [button4 addSubview:old4];
                
                UIButton * button5 = [[UIButton alloc]initWithFrame:CGRectMake(0, 140, 110, 35)];
                button5.tag = 500;
                [button5 addTarget:self action:@selector(btnonclick:) forControlEvents:UIControlEventTouchUpInside];
                [button5 setTitle:@"设置" forState:UIControlStateNormal];
                [button5 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                UIImageView * old5 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_setting"]];
                old5.frame = CGRectMake(8, 8, 20, 20);
                [button5 addSubview:old5];
                
                UIButton * button6 = [[UIButton alloc]initWithFrame:CGRectMake(0, 175, 110, 35)];
                button6.tag = 600;
                [button6 addTarget:self action:@selector(btnonclick:) forControlEvents:UIControlEventTouchUpInside];
                [button6 setTitle:@"会员" forState:UIControlStateNormal];
                [button6 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                UIImageView * old6 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_vip"]];
                old6.frame = CGRectMake(8, 8, 20, 20);
                [button6 addSubview:old6];
                
                
                
                _itemView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-110, 0, 110, 210)];
                _itemView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
                [_itemView addSubview:button1];
                [_itemView addSubview:button2];
                [_itemView addSubview:button3];
                [_itemView addSubview:button4];
                [_itemView addSubview:button5];
                [_itemView addSubview:button6];
                [self.view addSubview:_itemView];
                i ++;
           
            }else{
                [_itemView removeFromSuperview];
                i = 0;
            }
            
        }break;
        default:
            break;
    }
}
-(void)btnonclick:(UIButton *)btn
{
    switch (btn.tag/100) {
        case 1:{
            OldViewController * old = [[OldViewController alloc]init];
            old.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:old animated:YES];
        }break;
        case 2:{
            
        }break;
        case 3:{
            
        }break;
        case 4:{
            
        }break;
        case 5:{
            
        }break;
        case 6:{
            
        }break;
        default:
            break;
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_imageView];//要出现是添加
    //分栏选择器 显示
//    self.tabBarController.tabBar.hidden = NO;
  // hidesBottomBarWhenPushed属性    代替    tabBar.hidden  
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_imageView removeFromSuperview];//要消失时，移除图片
    
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
