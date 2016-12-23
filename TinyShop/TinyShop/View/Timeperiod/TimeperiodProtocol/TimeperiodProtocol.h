//
//  TimeperiodProtocol.h
//  TinyShop
//
//  Created by rimi on 16/12/23.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TimeperiodProtocol <NSObject>
@optional
/**
 界面刷新代理
 @param bl 成功/失败
 @param ms 信息
 */
-(void)resetTimeperiod:(BOOL)bl message:(id *)ms;
@end
