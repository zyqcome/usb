//
//  ShopSubModel.h
//  TinyShop
//
//  Created by rimi on 16/12/22.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopSubModel : NSObject

@property (nonatomic, strong) NSString *shop_type;// = "1";
@property (nonatomic, strong) NSString *shop_name;// = "云迈天行-测试";
@property (nonatomic, strong) NSString *shop_EffDateEnd;// = "2015-12-31 23:59:59";
@property (nonatomic, strong) NSString *shop_EffDateBegin;// = "2015-05-19 00:00:00";
@property (nonatomic, strong) NSString *shop_id;// = "119"
//        {
//            shop_type = "1";
//            shop_name = "云迈天行-测试";
//            shop_EffDateEnd = "2015-12-31 23:59:59";
//            shop_EffDateBegin = "2015-05-19 00:00:00";
//            shop_id = "119"
//        }
@end
