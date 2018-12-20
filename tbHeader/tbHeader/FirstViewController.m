




//
//  FirstViewController.m
//  tbHeader
//
//  Created by huangjian on 2018/12/19.
//  Copyright © 2018年 huangjian. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIImageView *bkView;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self setUpTableView];
}
-(void)setUpTableView
{
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.origin.y+self.navigationController.navigationBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-self.navigationController.navigationBar.frame.origin.y+self.navigationController.navigationBar.frame.size.height) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.backgroundColor=[UIColor blueColor];
   
    [self.view addSubview:tableView];
    self.tableView=tableView;
    

    //不用v来装imgV 会有问题
    UIView *v=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 200)];
    UIImageView *imgV =[[UIImageView alloc]initWithFrame:v.bounds];
    imgV.image=[UIImage imageNamed:@"2.jpg"];
    [v addSubview:imgV];
    
    self.tableView.tableHeaderView=v;
    self.bkView=imgV;
   
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text=@"hehe";
    cell.contentView.backgroundColor=[UIColor redColor];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//高扩大
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    //获取偏移量
//    CGPoint offset = scrollView.contentOffset;
//    //判断是否改变
//    if (offset.y < 0) {
//        CGRect rect = self.bkView.frame;
//        //我们只需要改变图片的y值和高度即可
//        rect.origin.y = offset.y;
//        rect.size.height = 200 - offset.y;
//        self.bkView.frame = rect;
//        NSLog(@"99 %lf  %lf",self.bkView.frame.origin.y,self.bkView.frame.size.height);
//    }
//}

//宽高等比扩大
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat width = self.view.frame.size.width;
    // 图片宽度
    CGFloat yOffset = scrollView.contentOffset.y;
    // 偏移的y值
    if(yOffset < 0)
    {CGFloat totalOffset = 200 + ABS(yOffset);
        CGFloat f = totalOffset / 200;
        //拉伸后的图片的frame应该是同比例缩放。
        self.bkView.frame =  CGRectMake(- (width *f-width) / 2, yOffset, width * f, totalOffset);
    }
}
@end
