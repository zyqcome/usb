//
//  NetWorkConfig.h
//  EduHousekeeper
//
//  Created by rimi on 16/12/6.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#ifndef NetWorkConfig_h
#define NetWorkConfig_h
/**状态码	说明
 *0      成功
 *2000	普通错误
 *1000	App登陆后超时退出，用户角色权限发生变化
 *1001	用户权限发生变化
 */

// **************** 后台地址 ***************
//#define BaseUrl @"https://service.icloudmatrix.com/service"
#define BaseUrl @"http://service.icloudmatrix.com/service"


//登录接口
#define LoginUrl @"/user/login"

#pragma mark  时段收入分析统计接口（销售额）
//APP时段收入分析(主图)
#define ApporderMainfigure @"/apporder_statistical/main_figure"

//APP时段收入分析(子图) 子图（分店占比、菜类销售额比）
#define ApporderSubgraph @"/apporder_statistical/subgraph"

#pragma mark  日常运营分析接口（订单数、人数、人均消费、平均餐时）
//APP日常运营分析(主图)
#defime AppdailyMainfigure @"/appdaily_analysis/main_figure"

//APP日常运营分析(子图)
#defime AppdailySubgraph @"/appdaily_analysis/subgraph"

#pragma mark  商品运营分析
//APP日常运营分析(主图) GET
#defime AppproductMainfigure @"/appproduct_analysis/main_figure"

//APP商品运营分析(子图) 
#defime AppproductSubgraph @"/appproduct_analysis/subgraph"

#pragma mark  会员消费信息
//APP会员消费信息列表
#defime Appviplist @"/appvip_consumption/list"

//APP会员订单列表
#defime AppdailyDetailedOrders @"/appvip_consumption/detailed_orders"

#pragma mark  历史记录列表
//APP历史记录列表
#defime ApphistoricalList @"/apphistorical_record/list"


#endif /* NetWorkConfig_h */
