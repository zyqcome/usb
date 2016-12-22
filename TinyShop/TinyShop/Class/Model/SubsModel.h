//
//  subsModel.h
//  TinyShop
//
//  Created by rimi on 16/12/22.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubsModel : NSObject
@property (nonatomic, strong) NSString *mod_id;// = "822";
@property (nonatomic, strong) NSArray *subs;// = [];
@property (nonatomic, strong) NSString *mod_type;// = "3";
@property (nonatomic, strong) NSString *mod_params;// = "https://service.icloudmatrix.com/service/vip/operation_vip";
@property (nonatomic, strong) NSString *mod_show;// = "1";
@property (nonatomic, strong) NSString *mod_controller;// = "AddMemberViewController";
@property (nonatomic, strong) NSString *mod_name;// = "添加会员";
@property (nonatomic, strong) NSString *mod_action;// = "addMemberAction";
@property (nonatomic, strong) NSString *mod_sort;// = "1"

@end
