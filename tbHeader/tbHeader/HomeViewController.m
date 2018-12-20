

//
//  HomeViewController.m
//  tbHeader
//
//  Created by huangjian on 2018/12/19.
//  Copyright © 2018年 huangjian. All rights reserved.
//

#import "HomeViewController.h"
#import "FirstViewController.h"
#import "AnimTbController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *titleArray;
@end

@implementation HomeViewController
-(NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray=@[@"表头拉大",@"上拉表头文字移至title动画"];
    }
    return _titleArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self setUpTableView];
}

-(void)setUpTableView
{
    UITableView *tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text=self.titleArray[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self goHeaderTb];
            break;
        case 1:
            [self goAnimTb];
            break;
        default:
            break;
    }
}
-(void)goHeaderTb
{
    FirstViewController *vc=[[FirstViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)goAnimTb
{
    AnimTbController *vc=[[AnimTbController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
