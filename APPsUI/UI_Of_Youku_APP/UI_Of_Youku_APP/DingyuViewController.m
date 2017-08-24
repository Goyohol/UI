//
//  DingyuViewController.m
//  UI_Of_Youku_APP
//
//  Created by goyohol on 15/9/29.
//  Copyright © 2015年 goyohol. All rights reserved.
//

#import "DingyuViewController.h"
#import "GYHYoukuSegmentView.h"

#import "NewViewController.h"
#import "JInxuanViewController.h"
@interface DingyuViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
}
//数据源数据
@property (nonatomic,strong) NSMutableArray * dataArray;
@end

@implementation DingyuViewController

#pragma mark - 懒加载
-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
        NSArray * plistPaths = [[NSBundle mainBundle]pathsForResourcesOfType:@"plist" inDirectory:nil];
        for (NSString * pathname in plistPaths) {
            if (![pathname hasSuffix:@"Info.plist"]&&![pathname  hasSuffix:@"_圣斗士.plist"]&&![pathname hasSuffix:@"data2.plist"]) {
                NSArray * array = [[NSArray alloc]initWithContentsOfFile:pathname];
                [_dataArray addObject:array];
            }
        }
    }
    return _dataArray;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    //创建tableView
    [self creatTableView];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    UIImageView * imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"_3"]];
//    imageview.frame = self.view.frame;
//    [self.view addSubview:imageview];
    
    NewViewController * new = [[NewViewController alloc]init];
    JInxuanViewController * jinxuan = [[JInxuanViewController alloc]init];
    [self addChildViewController:new];
    [self addChildViewController:jinxuan];
    new.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);//更新
    jinxuan.view.frame = CGRectMake(self.view.frame.size.width , 0, self.view.frame.size.width, self.view.frame.size.height);//精选
    //自己就是订阅界面
    [self.view addSubview:new.view];
    [self.view addSubview:jinxuan.view];
    
    
    
#pragma mark - NavigationItem设置
//    UISegmentedControl * seg = [[UISegmentedControl alloc]initWithItems:@[@"更新",@"订阅",@"精选"]];
//     seg.frame = CGRectMake((self.view.frame.size.width-180)/2.0, 7, 180, 30);
//    [self.navigationController.navigationBar addSubview:seg];
    GYHYoukuSegmentView * gyhseg = [[GYHYoukuSegmentView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-180)/2.0, 7, 180, 30)];
    gyhseg.items = @[@"更新",@"订阅",@"精选"];
    [self.navigationController.navigationBar addSubview:gyhseg];
     gyhseg.selectedIndex = 1;//默认选择定阅❤️?????????????
    [gyhseg addTarget:self withAction:@selector(onclick:)];
    
}
-(void)onclick:(GYHYoukuSegmentView *)seg
{
    NewViewController * new = self.childViewControllers[0];
    JInxuanViewController * jinxuan = self.childViewControllers[1];
    switch (seg.selectedIndex) {
        case 0:{//@"更新"
        [UIView animateWithDuration:0.3 animations:^{
            new.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            jinxuan.view.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
        }];
        }break;
        case 1:{//@"订阅"
        [UIView animateWithDuration:0.3 animations:^{
            new.view.frame = CGRectMake(-self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
            jinxuan.view.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
        }];
        }break;
        case 2:{//@"精选"
        [UIView animateWithDuration:0.3 animations:^{
            new.view.frame = CGRectMake(-self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
            jinxuan.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        }];
        }break;
        default:
            break;
    }
}
#pragma mark - 创建TableView界面
-(void)creatTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-130) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
//    [_tableView setSectionHeaderHeight:50.0];
    [_tableView setRowHeight:60.0];
    
    //    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 100)];
    //    backView.backgroundColor = [UIColor redColor];
    //    _tableView.backgroundView = backView;
    
    [self.view addSubview:_tableView];
}
#pragma mark - tableView DataSource 两方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * sectionArray = self.dataArray[section];
    return sectionArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"Id";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    NSArray * sectionArray = self.dataArray[indexPath.section];
    NSDictionary * rowDict = sectionArray[indexPath.row];
    
    cell.textLabel.text = rowDict[@"imageInfo"];
    cell.imageView.image = [UIImage imageNamed:rowDict[@"imageName"]];
    
    return cell;
}
//返回组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
#pragma mark - tableView Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130.f;
}




-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //分栏选择器 显示
//    self.tabBarController.tabBar.hidden = NO;
    // hidesBottomBarWhenPushed属性    代替    tabBar.hidden
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
