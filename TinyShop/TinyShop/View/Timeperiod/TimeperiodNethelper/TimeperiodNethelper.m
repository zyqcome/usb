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
@implementation TimeperiodNethelper

-(void)getTimeperiodDate {
    NSDictionary * dict = @{@"client_type":@"ios",@"client_version":@"2.0",@"client_token":@"2a8242f0858bbbde9c5dcbd0a0008e5a",@"shop_account":@"ymtxtshg",@"user_account":@"001",@"user_password":@"12345678"};
    TimeperiodGetModel *timeperiodGetModel = [TimeperiodGetModel new];
    timeperiodGetModel.client_type=@"ios";
    timeperiodGetModel.client_version=2.0;
    timeperiodGetModel.client_token=@"2a8242f0858bbbde9c5dcbd0a0008e5a";
    timeperiodGetModel.shop_id=11;
    timeperiodGetModel.mgr_base_id=3;
    timeperiodGetModel.access_token=@"b5e9f2327f88843907c481b9f00ac59d";
    timeperiodGetModel.mac_code=2322323;
    timeperiodGetModel.key=@"验签密钥";
    [[NetworkTools sharedTooles] requestMethod:POST isJson:YES WithUrl:ApporderMainfigure parematers:dict finished:^(id data, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
            return ;
        }
    }];
}
@end
