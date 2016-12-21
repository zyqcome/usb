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
#define LoginUrl @"/login"
/**帐户、员工号、密码进行登录*/

//APP时段收入分析(主图)
#define ApporderMainfigure @"/apporder_statistical/main_figure"

//APP时段收入分析(子图)
#define ApporderSubgraph @"/apporder_statistical/subgraph"

//APP日常运营分析(主图)
#defime AppdailyMainfigure @"/appdaily_analysis/main_figure"

//APP日常运营分析(子图)
#defime AppdailySubgraph @"/appdaily_analysis/subgraph"

#pragma mark  商品运营分析
//APP日常运营分析(主图) GET
//#defime AppproductMainfigure @"/appproduct_analysis/main_figure"
//
////APP日常运营分析(主图)
//#defime AppdailyMainfigure @"/appdaily_analysis/main_figure"
//
////APP日常运营分析(主图)
//#defime AppdailyMainfigure @"/appdaily_analysis/main_figure"


#endif /* NetWorkConfig_h */
