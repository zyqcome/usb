//
//  LoginModel.h
//  TinyShop
//
//  Created by rimi on 16/12/22.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject
//客户端类型，固定取值为： android、 ios、 web_admin
@property (nonatomic, strong) NSString *client_type;
//客户端版本号，固定为:2.0
@property (nonatomic, strong) NSString *client_version;
//客户端公共访问令牌， 测试令牌为 2a8242f0858bbbde9c5dcbd0a0008e5a
@property (nonatomic, strong) NSString *client_token;
//店铺帐户名，唯一
@property (nonatomic, strong) NSString *shop_account;
//员工号
@property (nonatomic, strong) NSString *user_account;
//密码
@property (nonatomic, strong) NSString *user_password;
@end
