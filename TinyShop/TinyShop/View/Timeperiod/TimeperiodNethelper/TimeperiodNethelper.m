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

/**
 时段收入分析所有数据获取
 */
-(void)getTimeperiodDate {
    //数据模拟
    LoginViewMode *loginViewMode = [LoginViewMode shareUserInfo];
    //登陆名
    loginViewMode.shop_account = loginViewMode.shop_account;//@"yljkrg";//@"ymtxtshg";
    //员工id
    loginViewMode.user_account = loginViewMode.user_account;//@"ymtx";//@"001";
    //登陆配置信息
    TimeperiodGetModel *timeperiodGetModel = [TimeperiodGetModel new];
    timeperiodGetModel.client_type=@"ios";//固定参数
    timeperiodGetModel.client_version=@"2.0";//固定参数
    timeperiodGetModel.client_token=@"2a8242f0858bbbde9c5dcbd0a0008e5a";//固定参数
    timeperiodGetModel.shop_id = loginViewMode.shop.shop_id;
    timeperiodGetModel.mgr_base_id=loginViewMode.user.mgr_base_id;
    timeperiodGetModel.access_token=loginViewMode.user.mgr_login_token;
    timeperiodGetModel.mac_code=@"";

    //获取-所有分店
    NSString *mutStr = [self strAllShopList];
    
    [self getTimeperiodNetWorkset:timeperiodGetModel AllShopList:mutStr];
}

/**
 时段收入分析-数据处理-网络请求

 @param timeGtMl 网络配置数据
 @param allShoplist 登陆返回的所有子店铺名单
 */
-(void)getTimeperiodNetWorkset:(TimeperiodGetModel *)timeGtMl AllShopList:(NSString *)allShoplist {

    self.UrlStr = [self strUrlGetMake:timeGtMl];
    NSLog(@"%@",timeGtMl.access_token);
    NSDictionary * dict = [self DicUrlPostMake:allShoplist];
    
    [[NetworkTools sharedTooles] requestMethod:POST isJson:YES WithUrl:self.UrlStr parematers:dict finished:^(id data, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
            return ;
        }
        NSLog(@"%@",data);
    }];
}

-(NSString *)strAllShopList {
    //数据模拟
    LoginViewMode *loginViewMode = [LoginViewMode shareUserInfo];
    //获取-所有分店
    NSString *mutStr = loginViewMode.shop.shop_id;
    //加上登陆店铺本身
    mutStr = [mutStr stringByAppendingString:@","];
    for (int i=0; i< loginViewMode.shop.subs.count; i++) {
        ShopSubModel *shopsubModel = loginViewMode.shop.subs[i];
        mutStr=[mutStr stringByAppendingString:shopsubModel.shop_id];
        //中间拼接的逗号-最后一个特殊处理
        if (i < (loginViewMode.shop.subs.count -1)) {
            mutStr = [mutStr stringByAppendingString:@","];
        }
    }
    return mutStr;
}

/**
 获取时段收入分析-Post-参数

 @param allShoplist 选择店铺参数
 @return 返回Post 字典
 */
-(NSDictionary *)DicUrlPostMake:(NSString *)allShoplist {
    NSDictionary * dictbody = @{@"shop_id":allShoplist};
    NSDictionary * dict = @{@"body":dictbody};
    return dict;
}
/**
 获取时段收入分析-get-连接字符串

 @param timeGtMl 网络配置数据
 @return 连接字符串
 */
-(NSString *)strUrlGetMake:(TimeperiodGetModel *)timeGtMl {
    NSString *myString = @"client_type=";
    myString = [myString stringByAppendingString:timeGtMl.client_type];
    myString = [myString stringByAppendingString:@"&client_version="];
    myString = [myString stringByAppendingString:timeGtMl.client_version];
    myString = [myString stringByAppendingString:@"&client_token="];
    myString = [myString stringByAppendingString:timeGtMl.client_token];
    myString = [myString stringByAppendingString:@"&shop_id="];
    myString = [myString stringByAppendingString:timeGtMl.shop_id];
    myString = [myString stringByAppendingString:@"&mgr_base_id="];
    myString = [myString stringByAppendingString:timeGtMl.mgr_base_id];
    myString = [myString stringByAppendingString:@"&access_token="];
    myString = [myString stringByAppendingString:timeGtMl.access_token];
    myString = [myString stringByAppendingString:@"&mac_code="];
    myString = [myString stringByAppendingString:timeGtMl.mac_code];
    //获取MD5 码
    NSString *key=[myString MD5];
    //post 参数字典
    NSString *UrlStr = ApporderMainfigure;
    UrlStr = [UrlStr stringByAppendingString:@"?"];
    UrlStr = [UrlStr stringByAppendingString:myString];
    UrlStr = [UrlStr stringByAppendingString:@"&key="];
    UrlStr = [UrlStr stringByAppendingString:key];
    return UrlStr;
}

/**
 将字典转换为字符串
 @param dic 传入的字典
 @return 返回的字符串
 */
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
@end
