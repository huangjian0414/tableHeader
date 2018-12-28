



//
//  AnimTbController.m
//  tbHeader
//
//  Created by huangjian on 2018/12/19.
//  Copyright © 2018年 huangjian. All rights reserved.
//

#import "AnimTbController.h"
#import "AnimHeader.h"
#import "Masonry/Masonry.h"

@interface AnimTbController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat rangeX;  // 动画开始和结束X方向的距离
    CGFloat rangeY;  // 动画开始和结束Y方向的距离
    CGFloat originY; // 动画开始时Y原点
}
@property (nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)AnimHeader *header;
@property(nonatomic,strong)UILabel *labe;

@property (nonatomic,assign)CGFloat startY;
@end

@implementation AnimTbController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    //[navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //此处设置底部线条颜色
    [navigationBar setShadowImage:[UIImage new]];
    UILabel *label=[[UILabel alloc]init];
    label.text=@"";
    label.frame=CGRectMake(0, 0, 100, 30);
    self.navigationItem.titleView=label;
    self.labe=label;
    
    [self setUpTableView];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGRect trackRect = [self.navigationItem.titleView convertRect:self.labe.frame toView:self.view];
        NSLog(@"77 %lf  %lf  %lf  %lf",trackRect.origin.x,trackRect.origin.y,trackRect.size.width,trackRect.size.height);
        
        CGRect trackRect1 = [self.header convertRect:self.header.titleLabel.frame toView:self.view];
        
        NSLog(@"777 %lf  %lf  %lf  %lf",trackRect1.origin.x,trackRect1.origin.y,trackRect1.size.width,trackRect1.size.height);
        
        self->rangeX = fabs(trackRect.origin.x - trackRect1.origin.x);
        self->rangeY = fabs((trackRect.origin.y + trackRect.size.height)- (trackRect1.origin.y + trackRect.size.height));
        self->originY = self.tableView.frame.origin.y;
    });
}
-(void)setUpTableView
{
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_offset(0);
    }];
    
    if (@available(iOS 11.0, *)){
        tableView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    }
    
    AnimHeader *header=[[AnimHeader alloc]init];
    header.frame=CGRectMake(0, 0, self.view.bounds.size.width, 120);
    header.backgroundColor=[UIColor orangeColor];
    tableView.tableHeaderView=header;
    self.header=header;
    
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text=@"gun ba ";
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
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //获取偏移量
    CGPoint offset = scrollView.contentOffset;
    NSLog(@"99  %lf",offset.y);
    //判断是否改变
    if (offset.y > 0&&offset.y<=120-64)
    {
        // 上推
        CGFloat ratioY = offset.y / rangeY; // Y轴已经位移的百分比
        NSLog(@" 00 77   %lf",ratioY);
        if (ratioY >= 1) {
            
        } else {
            
            [self.header.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(20+ ratioY * self->rangeX);
            }];
            self.header.subLabel.font=[UIFont systemFontOfSize:14-14*ratioY];
            [self.header.subLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(30-30*ratioY);
                make.width.mas_equalTo(100-100*ratioY);
            }];
            self.navigationItem.titleView.alpha = ratioY;
            [[[self.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:1-ratioY];
        }
        self.header.subLabel.hidden= self.header.titleLabel.hidden=offset.y==120-64;
        self.labe.text=offset.y==120-64?@"上海好冷":@"";
    }else if(offset.y>120-64)
    {
        self.header.subLabel.hidden=self.header.titleLabel.hidden=YES;
        self.labe.text=@"上海好冷";
    }else
    {
        self.header.subLabel.hidden=self.header.titleLabel.hidden=NO;
        [self.header.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(20);
        }];
        self.header.subLabel.font=[UIFont systemFontOfSize:14];
        [self.header.subLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(100);
        }];
    }
    
}
@end
