//
//  AnimHeader.m
//  tbHeader
//
//  Created by huangjian on 2018/12/19.
//  Copyright © 2018年 huangjian. All rights reserved.
//

#import "AnimHeader.h"
#import "Masonry/Masonry.h"

@interface AnimHeader ()

@end
@implementation AnimHeader

-(instancetype)init
{
    if (self=[super init]) {
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI
{
    UIView *v=[[UIView alloc]init];
    [self addSubview:v];
    self.v=v;
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(self);
    }];
    
    UILabel *titleLabel=[[UILabel alloc]init];
    titleLabel.text=@"上海好冷";
    titleLabel.textColor=[UIColor blackColor];
    [v addSubview:titleLabel];
    self.titleLabel=titleLabel;
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-7);
        make.left.mas_offset(20);
        make.height.mas_equalTo(30);
        //make.width.mas_equalTo(100);
    }];
    
    UILabel *subLabel=[[UILabel alloc]init];
    subLabel.text=@"阿西吧呢";
    subLabel.font=[UIFont systemFontOfSize:14];
    subLabel.textColor=[UIColor blackColor];
    [self addSubview:subLabel];
    self.subLabel=subLabel;
    
    [subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLabel);
        make.bottom.mas_equalTo(titleLabel.mas_top).offset(-2);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(100);
    }];
}


@end
