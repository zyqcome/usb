//
//  TimeperiodNethelper.m
//  TinyShop
//
//  Created by rimi on 16/12/23.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import "TimeperiodNethelper.h"
#import "NetworkTools.h"
#import "TimeperiodGetModel.h"
#import "LoginViewMode.h"
#import "EntityTools.h"
#import "NSString+MD5.h"
@implementation TimeperiodNethelper

-(void)getTimeperiodDate {
    
    LoginViewMode *loginViewMode = [LoginViewMode shareUserInfo];
    loginViewMode.shop_account = @"ymtxtshg";
    loginViewMode.user_account = @"001";
    
    
    TimeperiodGetModel *timeperiodGetModel = [TimeperiodGetModel new];
    timeperiodGetModel.client_type=@"ios";
    timeperiodGetModel.client_version=@"2.0";
    timeperiodGetModel.client_token=@"2a8242f0858bbbde9c5dcbd0a0008e5a";

    
    timeperiodGetModel.shop_id = loginViewMode.shop.shop_id;
    timeperiodGetModel.mgr_base_id=loginViewMode.user.mgr_base_id;
    timeperiodGetModel.access_token=loginViewMode.user.mgr_login_token;
    timeperiodGetModel.mac_code=@"";
    //get 参数字典
    NSDictionary *dic = [EntityTools entityToDictionary:timeperiodGetModel];
    NSString *myString = [TimeperiodNethelper stringWithDictionary:dic];
    //获取MD5 码
    NSString *key=[myString MD5];
    //post 参数字典
    //获取店铺数组
    NSMutableString *mutStr = [NSMutableString new];
    for (int i=0; i< loginViewMode.shop.subs.count; i++) {
        ShopSubModel *shopsubModel = loginViewMode.shop.subs[i];
        [mutStr stringByAppendingString:shopsubModel.shop_id];
        if (i < (loginViewMode.shop.subs.count -1)) {
            [mutStr stringByAppendingString:@","];
        }
    }
    NSMutableString *UrlStr = [NSMutableString stringWithString:ApporderMainfigure];
    [UrlStr stringByAppendingString:@"?"];
    [UrlStr stringByAppendingString:myString];
    [UrlStr stringByAppendingString:@"&"];
    [UrlStr stringByAppendingString:key];
    
    NSDictionary * dictbody = @{@"shop_id":@"mutStr"};
    NSDictionary * dict = @{@"body":dictbody};
    [[NetworkTools sharedTooles] requestMethod:POST isJson:YES WithUrl:UrlStr parematers:dict finished:^(id data, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
            return ;
        }
    }];
}

//将传入字典参数字符拼接
+ (NSString *)stringWithDictionary:(NSDictionary *)dic{
    NSMutableString *string = [NSMutableString string];
    for (NSString *key in dic) {
        id value = dic[key];
        if ([dic[key] isKindOfClass:[NSNumber class]]) {
            value = [NSString stringWithFormat:@"%@",dic[key]];
        }
        [string appendFormat:@"&%@=%@",key,value];//[self urlEncodeString:value]];
    }
    return string;
}
//中文编码成url
+ (NSString *)urlEncodeString:(NSString *)string
{
    NSString *result = [string  stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet symbolCharacterSet]];
    return result;
}
@end
