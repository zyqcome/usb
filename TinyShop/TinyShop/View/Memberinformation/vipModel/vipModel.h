//
//  vipModel.h
//  TinyShop
//
//  Created by rimi on 16/12/31.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface vipModel : NSObject
@property (nonatomic, strong) NSString *userId;// = "7753";
@property (nonatomic, strong) NSString *vip_base_id;// = "7753";
@property (nonatomic, strong) NSString *uvgrade_money;// = "0.00";
@property (nonatomic, strong) NSString *uvgrade_consume_money;// = "3322.00";
@property (nonatomic, strong) NSString *vip_nickname;// = "陈";
@property (nonatomic, strong) NSString *userSex;// = "1";
@property (nonatomic, strong) NSString *sigd_discount;// = "无折扣";
@property (nonatomic, strong) NSString *shop_name;// = "雅莉家烤肉馆";
@property (nonatomic, strong) NSString *uvgrade_recharge_all_money;// = "2000.00";
@property (nonatomic, strong) NSString *shop_id;// = "157";
@property (nonatomic, strong) NSString *vip_mobile;// = "13709014148"

/**
 userId = "7753";
 vip_base_id = "7753";
 uvgrade_money = "0.00";
 uvgrade_consume_money = "3322.00";
 vip_nickname = "陈";
 userSex = "1";
 sigd_discount = "无折扣";
 shop_name = "雅莉家烤肉馆";
 uvgrade_recharge_all_money = "2000.00";
 shop_id = "157";
 vip_mobile = "13709014148"
 */

@end
