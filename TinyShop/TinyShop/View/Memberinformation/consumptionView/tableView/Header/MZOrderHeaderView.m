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


//@property (nonatomic, strong) UILabel *order_id; //订单 id;
@end

@implementation MZOrderHeaderView

#pragma mark- LifeCycle
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor orangeColor];
        [self initface];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];

    self.selecButton.frame = self.bounds;
}

#pragma mark- Getter
- (UIButton *)selecButton
{
    if (!_selecButton) {
        _selecButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selecButton addTarget:self action:@selector(taped) forControlEvents:UIControlEventTouchUpInside];
        //[self.selecButton setBackgroundColor:[UIColor blueColor]];
        [self addSubview:_selecButton];
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

    UIView *view = [UIView new];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(300, 50));
        make.top.mas_equalTo(self.mas_top);
    }];
    
    self.order_sn = [UILabel new];//订单号
    self.order_sn.textAlignment = NSTextAlignmentCenter;
    [view addSubview:self.order_sn];
    [self.order_sn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
        make.size.mas_equalTo(CGSizeMake(300, 30));
    }];
    
    
    self.order_time = [UILabel new];//订单号
    self.order_time.textAlignment = NSTextAlignmentRight;
    self.order_time.font = [UIFont systemFontOfSize:10];
    self.order_time.text = @"at:16:27:00";
    [view addSubview:self.order_time];
    [self.order_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        //make.size.mas_equalTo(CGSizeMake(100, 10));
        make.height.mas_equalTo(10);
        make.width.mas_equalTo(view.mas_width).offset(-10);
        make.top.mas_equalTo(self.order_sn.mas_bottom);
    }];
    
    
    UIView *vw = [UIView new];
    vw.backgroundColor = [UIColor whiteColor];
    [self addSubview:vw];
    [vw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(view.mas_bottom);
    }];
    
//////////////////////////////////////////////////////
    //左视图宽度
    float letfviewwith = 50.0;
    
    UIView *letfvw = [UIView new];
    letfvw.backgroundColor = [UIColor whiteColor];
    [self addSubview:letfvw];
    [letfvw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(letfviewwith);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.top.mas_equalTo(vw.mas_bottom);
        make.left.mas_equalTo(self.mas_left);
    }];
    
    

    UIImageView *image = [UIImageView new];
    image.image = [UIImage imageNamed:@"日历框"];
    [letfvw addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.width.mas_equalTo(letfvw.mas_width);
        make.top.mas_equalTo(letfvw.mas_top).offset(5);
        //make.left.mas_equalTo(letfvw.mas_left);
        make.centerX.equalTo(letfvw.mas_centerX);
    }];
    
    self.order_day = [UILabel new];
    self.order_day.textColor = [UIColor redColor];
    self.order_day.font = [UIFont systemFontOfSize:16];
    self.order_day.textAlignment = NSTextAlignmentCenter;
    self.order_day.text = @"27日";
    [letfvw addSubview:self.order_day];
    [self.order_day mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(letfvw.mas_width);
        make.top.mas_equalTo(letfvw.mas_top).offset(20);
        //make.left.mas_equalTo(letfvw.mas_left);
        make.centerX.equalTo(letfvw.mas_centerX);
    }];
    
    self.order_moth = [UILabel new];
    self.order_moth.font = [UIFont systemFontOfSize:10];
    self.order_moth.textAlignment = NSTextAlignmentCenter;
    self.order_moth.text = @"2016-10";
    [letfvw addSubview:self.order_moth];
    [self.order_moth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(letfvw.mas_width);
        make.top.mas_equalTo(image.mas_top).offset(40);
        make.centerX.equalTo(letfvw.mas_centerX);
    }];
    
//    @property (nonatomic, strong) UILabel *order_time;//日

    
    
    //右视图
    UIView *rightvw = [UIView new];
    rightvw.backgroundColor = [UIColor whiteColor];
    [self addSubview:rightvw];
    [rightvw mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.width.mas_equalTo(letfviewwith);
        make.top.mas_equalTo(vw.mas_bottom);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.left.mas_equalTo(letfvw.mas_right);
        make.right.mas_equalTo(self.mas_right);
    }];
    
    self.order_stable_deskno = [UILabel new];//人数
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
    
    UILabel *nouse = [UILabel new];
    NSMutableArray<UILabel *> *arry = [NSMutableArray new];
    [arry addObject:self.order_stable_deskno];
    [arry addObject:self.order_person_num];//人数
    [arry addObject:self.time_length];//就餐时长（分）
    [arry addObject:self.order_goods_amount];//应收
    [arry addObject:self.order_order_amount];//实收
    [arry addObject:self.order_waiter_account];//收银员
    [arry addObject:self.order_cash_money];//现金
    [arry addObject:self.order_creditcard_money];//刷卡
    [arry addObject:self.order_use_balance];//预存款
    [arry addObject:self.shopdt_discount];//折扣
    [arry addObject:nouse];
    [arry addObject:self.order_shopping_volume_fee];//代金劵
    
    UILabel * templable = nil;
    CGFloat padding = 1.0f;
    CGFloat height = 30.0f; // 高度固定等于50
    for (int i = 0; i<arry.count; i++) {
        UILabel *lb = arry[i];
        lb.textAlignment = NSTextAlignmentLeft;
        lb.backgroundColor = [UIColor whiteColor];
        lb.font = [UIFont systemFontOfSize:10];
        
        [rightvw addSubview:lb];
        if (i == 0) {
            [lb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(rightvw.mas_left).offset(padding);
                make.top.equalTo(rightvw.mas_top).offset(padding);
                make.height.equalTo(@(height));
            }];
            
        } else if (i == arry.count -1) {
            [lb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(templable.mas_right).offset(padding);
                make.right.equalTo(rightvw.mas_right).offset(-padding);
                make.top.equalTo(templable);
                make.height.equalTo(@(height));
                make.width.equalTo(templable);
            }];
            
        }else if( i %3 == 0 ) {
            [lb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(rightvw.mas_left).offset(padding);
                make.top.equalTo(templable.mas_bottom).offset(padding);
                make.height.equalTo(@(height));
                make.width.equalTo(templable);
            }];
        } else {
            [lb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(templable.mas_right).offset(padding);
                make.top.equalTo(templable);
                make.height.equalTo(@(height));
                make.width.equalTo(templable);
                
            }];
        }
        templable = lb;
    }
}




@end



















