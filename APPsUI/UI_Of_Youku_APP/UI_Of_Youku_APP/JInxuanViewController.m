//
//  JInxuanViewController.m
//  UI_Of_Youku_APP
//
//  Created by goyohol on 15/9/29.
//  Copyright © 2015年 goyohol. All rights reserved.
//

#import "JInxuanViewController.h"

@interface JInxuanViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
}
@property (nonatomic,strong) NSMutableArray * dataArray;
@end

@implementation JInxuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatTableView];
}
-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
        NSArray * plistPaths = [[NSBundle mainBundle]pathsForResourcesOfType:@"plist" inDirectory:nil];
        for (NSString * pathname in plistPaths) {
            if (![pathname hasSuffix:@"Info.plist"]&&![pathname hasSuffix:@"data2.plist"]) {
                NSArray * array = [[NSArray alloc]initWithContentsOfFile:pathname];
                [_dataArray addObject:array];
            }
        }
    }
    return _dataArray;
}

-(void)creatTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-130) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView setRowHeight:60];
//    [_tableView setSectionHeaderHeight:150];
    [self.view addSubview:_tableView];
}

#pragma mark -tableView DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * sectionArray = self.dataArray[section];
    
    return sectionArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"id";
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
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 50;
//}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
#pragma mark - tableView Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120.f;
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
