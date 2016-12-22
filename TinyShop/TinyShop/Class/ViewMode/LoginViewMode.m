//
//  LoginViewMode.m
//  TinyShop
//
//  Created by rimi on 16/12/22.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
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

@end
