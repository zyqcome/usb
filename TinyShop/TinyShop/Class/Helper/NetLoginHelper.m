//
//  NetLoginHelper.m
//  TinyShop
//
//  Created by rimi on 16/12/22.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import "NetLoginHelper.h"
#import "NetworkTools.h"
#import "NetWorkConfig.h"
@implementation NetLoginHelper
-(void)getlogin {
    NetworkTools *networkTools = [NetworkTools sharedTooles];
    NSString *fullUrl = [BaseUrl stringByAppendingString:LoginUrl];
    NSDictionary *dic = [NSDictionary new];
    NSError *er;
    NSData *datajSON = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&er];
    if (er) {
        NSLog(@"%@",er);
    }
    [networkTools requestMethod:POST WithUrl:fullUrl parematers:(id) finished:^(id data, NSError *error) {
        
    }];
}
@end
