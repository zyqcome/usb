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
@property (nonatomic, strong) NSArray *rightsArry;
@property (nonatomic, strong) NSArray *roleDiscountsArry;
@property (nonatomic, strong) ShopModel *shopArry;
@property (nonatomic, strong) UserModel *user;
//单例
+ (instancetype)shareUserInfo;

/**
 根据字典数据初始化

 @param Dic 传入字典
 @return 是否转换成功
 */
-(BOOL)intwithDictionary:(NSDictionary *)Dic;
@end
