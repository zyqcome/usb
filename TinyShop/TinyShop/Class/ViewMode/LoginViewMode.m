//
//  LoginViewMode.m
//  TinyShop
//
//  Created by rimi on 16/12/22.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//  时段分析界面
//

#import "LoginViewMode.h"
static LoginViewMode *userInfo;

@implementation LoginViewMode


+ (instancetype)shareUserInfo {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfo = [[self alloc]  init];
    });
    return userInfo;
}

-(BOOL)intwithDictionary:(NSDictionary *)Dic  {
    self.user = (UserModel *)[ReflectionClassTools getModelArry:Dic[@"body"] pickStr:@"user" Class:@"UserModel"];
    
    self.rightsArry = [NSArray arrayWithArray:[ReflectionClassTools getModelsArry:Dic[@"body"] pickStr:@"rights" Class:@"RightsModel"]];
    
    self.roleDiscountsArry = [NSArray arrayWithArray:[ReflectionClassTools getModelsArry:Dic[@"body"] pickStr:@"roleDiscounts" Class:@"RoleDiscountsModel"]];
    
    self.shopArry = (ShopModel *)[ReflectionClassTools getModelArry:Dic[@"body"] pickStr:@"shop" Class:@"ShopModel"];
    
    self.shopArry.subs = [NSArray arrayWithArray:[ReflectionClassTools DicArrygetModelsArry:self.shopArry.subs Class:@"ShopSubModel"]];
    for (int i =0 ; i < self.rightsArry.count; i++) {
        RightsModel *rtModel =  self.rightsArry[i];
        rtModel.subs = [NSArray arrayWithArray:[ReflectionClassTools DicArrygetModelsArry:rtModel.subs Class:@"RightsSubsModel"]];
    }
    return true;
}


@end
