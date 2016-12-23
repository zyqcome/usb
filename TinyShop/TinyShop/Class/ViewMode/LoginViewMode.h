//
//  LoginViewMode.h
//  TinyShop
//
//  Created by rimi on 16/12/22.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import "ShopModel.h"
@interface LoginViewMode : NSObject
//登陆店铺名称
@property (nonatomic, strong) NSString *shop_account;
@property (nonatomic, strong) NSString *user_account;
@property (nonatomic, strong) NSArray *rightsArry;
@property (nonatomic, strong) NSArray *roleDiscountsArry;
@property (nonatomic, strong) ShopModel *shop;
@property (nonatomic, strong) UserModel *user;
//单例
+ (instancetype)shareUserInfo;
-(BOOL)intwithDictionary:(NSDictionary *)Dic;
@end
