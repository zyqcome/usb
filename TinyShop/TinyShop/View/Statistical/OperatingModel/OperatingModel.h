//
//  OperatingModel.h
//  TinyShop
//
//  Created by 王灿 on 2016/12/24.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OperatingModel : NSObject

@property (nonatomic, strong) NSString *client_type;//=android
@property (nonatomic, strong) NSString *client_version;//=2.0
@property (nonatomic, strong) NSString *client_token;//=2a8242f0858bbbde9c5dcbd0a0008e5a
@property (nonatomic, strong) NSString *shop_id;//=11
@property (nonatomic, strong) NSString *mgr_base_id;//=3
@property (nonatomic, strong) NSString *access_token;//=b5e9f2327f88843907c481b9f00ac59d
@property (nonatomic, strong) NSString *mac_code;//=2322323
//折线图需要的数据
@property(nonatomic, strong)NSArray *dateAry;   //底部时间数组
@property(nonatomic, strong)NSArray *detailAry; //每天的情况数组


@end
