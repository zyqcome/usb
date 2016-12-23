//
//  TimeperiodGetModel.h
//  TinyShop
//
//  Created by rimi on 16/12/23.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeperiodGetModel : NSObject

@property (nonatomic, strong) NSString *client_type;//=android
@property (nonatomic, assign) double client_version;//=2.0
@property (nonatomic, strong) NSString *client_token;//=2a8242f0858bbbde9c5dcbd0a0008e5a
@property (nonatomic, assign) int shop_id;//=11
@property (nonatomic, assign) int mgr_base_id;//=3
@property (nonatomic, strong) NSString *access_token;//=b5e9f2327f88843907c481b9f00ac59d
@property (nonatomic, assign) int mac_code;//=2322323
@property (nonatomic, strong) NSString *key;//=验签密钥
/**
 client_type=android
 &  client_version=2.0
 &  client_token=2a8242f0858bbbde9c5dcbd0a0008e5a
 &  shop_id=11
 &  mgr_base_id=3
 &  access_token=b5e9f2327f88843907c481b9f00ac59d
 &  mac_code=2322323
 &  key=验签密钥
 */
@end
