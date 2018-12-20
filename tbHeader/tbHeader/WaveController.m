





//
//  WaveController.m
//  tbHeader
//
//  Created by huangjian on 2018/12/20.
//  Copyright © 2018年 huangjian. All rights reserved.
//

#import "WaveController.h"

typedef void (^WaveYBlock)(CGFloat waveY);
@interface WaveController ()
// 刷屏器
@property (nonatomic, strong) CADisplayLink *timer;

// 波
@property (nonatomic, strong) CAShapeLayer *waveLayer;

// 偏移量
@property (nonatomic, assign) CGFloat offset;

@property(nonatomic,strong)UIView *v;

/** 浪宽： 一个完整的浪的宽度 */
@property (nonatomic, assign) CGFloat waveWidth;

/** 浪高： 波峰到波谷的距离 */
@property (nonatomic, assign) CGFloat waveHeight;

/** 浪速： 浪的移动速度 */
@property (nonatomic, assign) CGFloat waveSpeed;

/** 浪速： 浪的内填充颜色 */
@property (nonatomic, strong) UIColor *waveColor;


@end

@implementation WaveController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.waveHeight = 18;
    self.waveSpeed = 30;

    self.waveWidth = self.view.bounds.size.width;
    self.waveColor = [UIColor whiteColor];
    [self setUpUI];
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.timer invalidate];
    self.timer=nil;
}

-(void)setUpUI
{
    UIView *v=[[UIView alloc]initWithFrame:CGRectMake(0, 100, self.waveWidth, 200)];
    v.backgroundColor=[UIColor orangeColor];
    [self.view addSubview:v];
    self.v=v;
    
    _waveLayer = [CAShapeLayer layer];
    _waveLayer.fillColor = self.waveColor.CGColor;
    CGRect frame = self.v.bounds;
    frame.origin.y = frame.size.height - self.waveHeight;
    frame.size.height = self.waveHeight;
    _waveLayer.frame = frame;
    [self.v.layer addSublayer:_waveLayer];
    
    
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(wave)];
    [self.timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
}

// 动画实现
- (void)wave{
    self.offset += self.waveSpeed;
    
    CGFloat width = self.v.bounds.size.width;
    CGFloat height = self.waveHeight;
    CGFloat y = 0.f;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, height)];
    for (CGFloat x = 0.f; x <= width; x++) {
        y = height * sinf(2*M_PI/self.waveWidth *x - self.offset*0.0045);
        [path addLineToPoint:CGPointMake(x, y)];
    }

    [path addLineToPoint:CGPointMake(width, height)];
    [path addLineToPoint:CGPointMake(0, height)];
    [path closePath];
    self.waveLayer.path = path.CGPath;
}
@end
