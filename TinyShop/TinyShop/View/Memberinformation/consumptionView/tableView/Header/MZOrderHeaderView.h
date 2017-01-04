//
//  MZOrderHeaderView.h
//  Cell的展开和收起
//
//  Created by MrZhao on 16/12/29.
//  Copyright © 2016年 MrZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SectionCallBack)(NSUInteger section);

@interface MZOrderHeaderView : UITableViewHeaderFooterView

@property (nonatomic, assign) NSUInteger section;

@property (nonatomic, copy) SectionCallBack didSelectSection;

//@property (nonatomic,strong)orderModel *ordermodel;


#pragma make -界面
@property (nonatomic, strong) UILabel *order_sn;//订单号

@property (nonatomic, strong) UILabel *order_shipping_time;//结账时间

@property (nonatomic, strong) UILabel *order_stable_deskno;//桌号
@property (nonatomic, strong) UILabel *order_person_num;//人数
@property (nonatomic, strong) UILabel *time_length;//时长（分）
@property (nonatomic, strong) UILabel *order_goods_amount;//应收
@property (nonatomic, strong) UILabel *order_order_amount;//实收
@property (nonatomic, strong) UILabel *order_waiter_account;//收营员
@property (nonatomic, strong) UILabel *order_cash_money;//现金
@property (nonatomic, strong) UILabel *order_creditcard_money;//刷卡
@property (nonatomic, strong) UILabel *order_use_balance;//预存款
@property (nonatomic, strong) UILabel *shopdt_discount;//折扣
@property (nonatomic, strong) UILabel *order_shopping_volume_fee;//代金劵

@property (nonatomic, strong) UILabel *order_day;//日
@property (nonatomic, strong) UILabel *order_moth;//日
@property (nonatomic, strong) UILabel *order_time;//日

@end
