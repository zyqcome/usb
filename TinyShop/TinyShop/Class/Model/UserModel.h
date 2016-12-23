//
//  UserModel.h
//  TinyShop
//
//  Created by rimi on 16/12/22.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property (nonatomic, strong) NSString *mgr_base_id;
@property (nonatomic, strong) NSString *mgr_account;
@property (nonatomic, strong) NSString *mgr_type;
@property (nonatomic, strong) NSString *mgr_login_token;
@property (nonatomic, strong) NSString *mgr_role_id;
@property (nonatomic, strong) NSString *mgr_online;
@property (nonatomic, strong) NSString *mgr_shop_id;
@property (nonatomic, strong) NSString *mgr_name;
@property (nonatomic, strong) NSString *mgr_nickname;
@property (nonatomic, strong) NSString *role_name;
/**
 user = {
 mgr_base_id = "37";
 mgr_account = "001";
 mgr_type = "4";
 mgr_login_token = "02f639e42b9fb6ce2cb662e4908ffe2b";
 mgr_role_id = "317";
 mgr_online = "3";
 mgr_shop_id = "24";
 mgr_name = "孙";
 mgr_nickname = "小小孙";
 role_name = "boss"
 }
 */
@end
