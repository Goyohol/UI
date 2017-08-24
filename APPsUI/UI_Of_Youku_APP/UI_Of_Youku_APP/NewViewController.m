//
//  NewViewController.m
//  UI_Of_Youku_APP
//
//  Created by goyohol on 15/9/29.
//  Copyright © 2015年 goyohol. All rights reserved.
//

#import "NewViewController.h"

@interface NewViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
}
@property (nonatomic,strong) NSMutableArray * dataArray;
@end

@implementation NewViewController

#pragma mark - 懒加载
-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
        NSString * path = [[NSBundle mainBundle]pathForResource:@"image_火影忍者.plist" ofType:nil];
        NSArray * plistArray = [[NSArray alloc]initWithContentsOfFile:path];
        for (NSDictionary * dict in plistArray) {
            [_dataArray addObject:dict];
        }
    }
    return _dataArray;
}


#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatTableView];
}
-(void)creatTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-130) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView setRowHeight:60];
    [self.view addSubview:_tableView];
    
}

#pragma mark - tableView DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"id";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    NSDictionary * dict = self.dataArray[indexPath.row];
    cell.textLabel.text = dict[@"imageInfo"];
    cell.imageView.image = [UIImage imageNamed:dict[@"imageName"]];
    
    return cell;
}
#pragma mark - tableView Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 188.f;
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
