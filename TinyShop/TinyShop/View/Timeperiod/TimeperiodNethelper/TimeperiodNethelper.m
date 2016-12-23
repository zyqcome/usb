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
    //NSDictionary *dic = [EntityTools entityToDictionary:timeperiodGetModel];
    //NSString *myString = [TimeperiodNethelper stringWithDictionary:dic];
    //client_type=android&client_version=2.0&client_token=2a8242f0858bbbde9c5dcbd0a000 8e5a&shop_id=11&mgr_base_id=3&access_token=b5e9f2327f88843907c481b9f00ac59d&mac_cod e=2322323
    NSString *myString = @"client_type=";
    myString = [myString stringByAppendingString:timeperiodGetModel.client_type];
    myString = [myString stringByAppendingString:@"&client_version="];
    myString = [myString stringByAppendingString:timeperiodGetModel.client_version];
    myString = [myString stringByAppendingString:@"&client_token="];
    myString = [myString stringByAppendingString:timeperiodGetModel.client_token];
    myString = [myString stringByAppendingString:@"&shop_id="];
    myString = [myString stringByAppendingString:timeperiodGetModel.shop_id];
    myString = [myString stringByAppendingString:@"&mgr_base_id="];
    myString = [myString stringByAppendingString:timeperiodGetModel.mgr_base_id];
    myString = [myString stringByAppendingString:@"&access_token="];
    myString = [myString stringByAppendingString:timeperiodGetModel.access_token];
    myString = [myString stringByAppendingString:@"&mac_code="];
    myString = [myString stringByAppendingString:timeperiodGetModel.mac_code];
    //获取MD5 码
    NSString *key=[myString MD5];
    //post 参数字典
    //获取店铺数组
    NSString *mutStr = loginViewMode.shop.shop_id;
    mutStr = [mutStr stringByAppendingString:@","];
    for (int i=0; i< loginViewMode.shop.subs.count; i++) {
        ShopSubModel *shopsubModel = loginViewMode.shop.subs[i];
        mutStr=[mutStr stringByAppendingString:shopsubModel.shop_id];
        if (i < (loginViewMode.shop.subs.count -1)) {
            mutStr = [mutStr stringByAppendingString:@","];
        }
    }
    NSString *UrlStr = ApporderMainfigure;
    UrlStr = [UrlStr stringByAppendingString:@"?"];
    UrlStr = [UrlStr stringByAppendingString:myString];
    UrlStr = [UrlStr stringByAppendingString:@"&key="];
    UrlStr = [UrlStr stringByAppendingString:key];
    
//    UrlStr = [UrlStr stringByReplacingOccurrencesOfString:@"<null>" withString:@""];//stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    
    NSDictionary * dictbody = @{@"shop_id":mutStr};
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
    BOOL bl = false;
    for (NSString *key in dic) {
        id value = dic[key];
        if ([dic[key] isKindOfClass:[NSNumber class]]) {
            value = [NSString stringWithFormat:@"%@",dic[key]];
        }
        if (bl == false) {
            [string appendFormat:@"%@=%@",key,value];
            bl = true;
        } else {
            [string appendFormat:@"&%@=%@",key,value];
        }
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
