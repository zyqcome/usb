//
//  rightsModel.h
//  TinyShop
//
//  Created by rimi on 16/12/22.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RightsModel : NSObject

@property (nonatomic, strong) NSString *mod_id;
@property (nonatomic, strong) NSArray *subs;
@property (nonatomic, strong) NSString *mod_type;
@property (nonatomic, strong) NSString *mod_params;
@property (nonatomic, strong) NSString *mod_show;
@property (nonatomic, strong) NSString *mod_controller;
@property (nonatomic, strong) NSString *mod_name;
@property (nonatomic, strong) NSString *mod_action;
@property (nonatomic, strong) NSString *mod_sort;


/**
 mod_id = "816";
 subs = [
 {
 mod_id = "822";
 subs = [];
 mod_type = "3";
 mod_params = "https://service.icloudmatrix.com/service/vip/operation_vip";
 mod_show = "1";
 mod_controller = "AddMemberViewController";
 mod_name = "添加会员";
 mod_action = "addMemberAction";
 mod_sort = "1"
 },
 ];
 mod_type = "3";
 mod_params = "";
 mod_show = "1";
 mod_controller = "";
 mod_name = "微结算2.0";
 mod_action = "";
 mod_sort = "1"
 
 */

@end
