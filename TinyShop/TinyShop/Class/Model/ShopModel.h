//
//  ShopModel.h
//  TinyShop
//
//  Created by rimi on 16/12/22.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopModel : NSObject
@property (nonatomic, strong) NSString *charge_money_send_percent;// = 1.2;
@property (nonatomic, strong) NSString *shop_name;// = "云迈天行特色火锅";
@property (nonatomic, strong) NSString *shop_EffDateEnd;// = "2016-12-31 23:59:59";
@property (nonatomic, strong) NSString *shop_qrCode_pro;// = "";
@property (nonatomic, strong) NSString *shop_user;// = "0";
@property (nonatomic, strong) NSString *shop_EffDateBegin;// = "2015-03-26 00:00:00";
@property (nonatomic, strong) NSString *shop_sumtimeoffset;// = "0";
@property (nonatomic, strong) NSString *shop_type;// = "1";
@property (nonatomic, strong) NSString *shop_qrcode_url;// = "";
@property (nonatomic, strong) NSString *shop_account;// = "ymtxtshg";
@property (nonatomic, strong) NSString *shop_bluetooth_said;// = "1";
@property (nonatomic, strong) NSArray *subs;
//= [
//        {
//            shop_type = "1";
//            shop_name = "云迈天行-测试";
//            shop_EffDateEnd = "2015-12-31 23:59:59";
//            shop_EffDateBegin = "2015-05-19 00:00:00";
//            shop_id = "119"
//        },
//        ];
@property (nonatomic, strong) NSString *shop_id;// = "24"
@end
