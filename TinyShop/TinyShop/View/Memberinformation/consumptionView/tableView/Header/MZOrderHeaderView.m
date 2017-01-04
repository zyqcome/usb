//
//  MZOrderHeaderView.m
//  Cell的展开和收起
//
//  Created by MrZhao on 16/12/29.
//  Copyright © 2016年 MrZhao. All rights reserved.
//

#import "MZOrderHeaderView.h"
@interface MZOrderHeaderView()
{

}
@property (nonatomic, strong)UIButton *selecButton;
#pragma make -界面
@property (nonatomic, strong) UILabel *order_sn;//订单号

@property (nonatomic, strong) UILabel *order_shipping_time;//结账时间

@property (nonatomic, strong) UILabel *order_stable_deskno;//桌号
@property (nonatomic, strong) UILabel *order_person_num;//人数
@property (nonatomic, strong) UILabel *time_length;//就餐时长（分）
@property (nonatomic, strong) UILabel *order_goods_amount;//应收
@property (nonatomic, strong) UILabel *order_order_amount;//实收
@property (nonatomic, strong) UILabel *order_waiter_account;//收银员
@property (nonatomic, strong) UILabel *order_cash_money;//现金
@property (nonatomic, strong) UILabel *order_creditcard_money;//刷卡
@property (nonatomic, strong) UILabel *order_use_balance;//预存款
@property (nonatomic, strong) UILabel *shopdt_discount;//折扣
@property (nonatomic, strong) UILabel *order_shopping_volume_fee;//代金劵

//@property (nonatomic, strong) UILabel *order_id; //订单 id;
@end

@implementation MZOrderHeaderView

#pragma mark- LifeCycle
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor orangeColor];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self initface];
    self.selecButton.frame = self.bounds;
}

#pragma mark- Getter
- (UIButton *)selecButton
{
    if (!_selecButton) {
        _selecButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selecButton addTarget:self action:@selector(taped) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_selecButton];
    }
    return _selecButton;
}

#pragma mark- Action
- (void)taped
{
    if (self.didSelectSection) {
        self.didSelectSection(self.section);
    }
}

-(void)initface {
    self.order_sn = [UILabel new];//订单号
    self.order_sn.textAlignment = NSTextAlignmentCenter;
//    self.c
    [self.order_sn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
    self.order_sn.text = [NSString stringWithFormat:@"订单号：%@",self.ordermodel.order_sn];
    
    self.order_shipping_time = [UILabel new];//结账时间
    
    self.order_stable_deskno = [UILabel new];//桌号
    self.order_person_num = [UILabel new];//人数
    self.time_length = [UILabel new];//就餐时长（分）
    self.order_goods_amount = [UILabel new];//应收
    self.order_order_amount = [UILabel new];//实收
    self.order_waiter_account = [UILabel new];//收银员
    self.order_cash_money = [UILabel new];//现金
    self.order_creditcard_money = [UILabel new];//刷卡
    self.order_use_balance = [UILabel new];//预存款
    self.shopdt_discount = [UILabel new];//折扣
    self.order_shopping_volume_fee = [UILabel new];//代金劵
}


@end



















