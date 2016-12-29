//
//  TimeperiodProtocol.h
//  TinyShop
//
//  Created by rimi on 16/12/23.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum _Received {
    Received_lineChart = 0,//线性图表数据
    Received_ApporderSubgraph = 1,
//    Received = 1 << 0,
//    Received = 1 << 1,
//    Received = 1 << 2,
//    Received = 1 << 3
} Received;

@protocol TimeperiodProtocol <NSObject>
@optional
/**
 界面刷新代理

 @param sender 消息分类
 @param bl 成功/失败
 @param ms 信息
 */
-(void)resetTimeperiod:(Received)sender Bl:(BOOL)bl message:(id)ms;
@end
