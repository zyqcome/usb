//
//  orderModel.h
//  TinyShop
//
//  Created by rimi on 17/1/3.
//  Copyright © 2017年 cc.zyqblog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface goodsModel : NSObject
@property (nonatomic, strong) NSString *unit; // = "位";
@property (nonatomic, strong) NSArray *subs; // = [];
@property (nonatomic, strong) NSString *price; // = "3.00";
@property (nonatomic, strong) NSString *count; // = "3";
@property (nonatomic, strong) NSString *discount; // = "10";
@property (nonatomic, strong) NSString *kindName; // = "味碟类";
@property (nonatomic, strong) NSString *foodType; // = "0";
@property (nonatomic, strong) NSString *name; // = "味碟"
@end
@interface orderModel : NSObject
@property (nonatomic, strong) NSString *order_shopping_volume_fee; // = "0.00";
@property (nonatomic, strong) NSString *order_stable_deskno; // = "1";
@property (nonatomic, strong) NSString *order_sn; // = "602016042500000007";
@property (nonatomic, strong) NSString *aBulk; // = "0.00";
@property (nonatomic, strong) NSString *order_goods_amount; // = "447.00";
@property (nonatomic, strong) NSString *order_id; // = "721172";
@property (nonatomic, strong) NSString *order_shipping_time; // = "2016-04-25 21:05:33";
@property (nonatomic, strong) NSString *weixin; // = "0.00";
@property (nonatomic, strong) NSString *order_waiter_account; // = "001";
@property (nonatomic, strong) NSString *order_person_num; // = "3";
@property (nonatomic, strong) NSString *order_use_balance; // = "364.00";
@property (nonatomic, strong) NSString *shopdt_discount; // = "8.5";
@property (nonatomic, strong) NSString *order_creditcard_money; // = "0.00";
@property (nonatomic, strong) NSString *aliPay; // = "0.00";
@property (nonatomic, strong) NSString *time_length; // = "153.52";
@property (nonatomic, strong) NSArray<goodsModel *> *goods; // = [
@property (nonatomic, strong) NSString *order_order_amount; // = "447.00";
@property (nonatomic, strong) NSString *order_cash_money; // = "83.00"
@end
