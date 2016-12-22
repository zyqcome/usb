//
//  ReflectionClassTools.h
//  TinyShop
//
//  Created by rimi on 16/12/22.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReflectionClassTools : NSObject
/**
 字典转数组
 @param mutin 输入字典
 @param cls 数据模型
 @return 返回数组
 */
+ (NSArray *)getModelArry:(NSDictionary *)mutin pickStr:(NSString *)pickstr Class:(NSString *)cls;
+ (NSArray *)getModelsArry:(NSDictionary *)mutin pickStr:(NSString *)pickstr Class:(NSString *)cls;
/**
 字典数组转对象数组
 @param mutin 输入字典
 @param cls 数据模型
 @return 返回数组
 */
+ (NSArray *)DicArrygetModelsArry:(NSArray *)mutin Class:(NSString *)cls;
@end
