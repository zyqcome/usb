//
//  StatisticalViewController.m
//  TinyShop
//
//  Created by 王灿 on 2016/12/22.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import "StatisticalViewController.h"

@interface StatisticalViewController ()
@property(nonatomic,strong)NSArray *buttonImageArray; //按钮图片
@property(nonatomic,strong)UILabel *label;   //统计文字

@end

@implementation StatisticalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

-(void)setUI{
    //背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    //五个按钮
    for (NSInteger index = 0; index < 5; index++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(Screen_W/5*index, 70, Screen_W/5, 80)];
        btn.tag = 1000+index;
        [btn setImage:[UIImage imageNamed:self.buttonImageArray[index]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(statisticalClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    //两根横线
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(150);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(Screen_W, 1));
    }];
    UIView *lineView2 = [UIView new];
    lineView2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(33);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(Screen_W, 1));
    }];
    //统计Label
    _label = [UILabel new];
    _label.text = @"1313231231";
    _label.backgroundColor = [UIColor blackColor];
    _label.textColor = [UIColor redColor];
    [self.view addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(3);
        make.left.equalTo(self.view.mas_left).offset(3);
        make.size.mas_equalTo(CGSizeMake(200, 30));
    }];
    
}
//5个按钮
-(void)statisticalClicked:(UIButton *)button{
    NSLog(@"%ld",button.tag);
    [button setImage:[UIImage imageNamed:@"销售额-选中"] forState:UIControlStateNormal];
}

#pragma 懒加载
-(NSArray *)buttonImageArray{
    if (!_buttonImageArray) {
        _buttonImageArray = @[@"销售额-未选",@"桌数-未选",@"人数-未选",@"人均-未选",@"餐时-未选"];
    }
    return _buttonImageArray;
}


@end
