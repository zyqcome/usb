//
//  TimeperiodNethelper.h
//  TinyShop
//
//  Created by rimi on 16/12/23.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimeperiodProtocol.h"

@interface linePointModel : NSObject
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSString *value;
@end



@interface TimeperiodNethelper : NSObject
@property(nonatomic,weak)id<TimeperiodProtocol> delege;
-(void)getTimeperiodDate;

/**
 获取子店铺数据-时间

 @param ShopList <#ShopList description#>
 */
-(void)getApporderStatisticalDateShoplist:(NSString *)ShopList time:(NSString *)timer;
@end
