//
//  ReflectionClassTools.m
//  TinyShop
//
//  Created by rimi on 16/12/22.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import "ReflectionClassTools.h"
#import <objc/runtime.h>
@implementation ReflectionClassTools

/**
 根据 str 返回对象

 @param str 对象名称字符串
 @return 返回对象
 */
+(Class)GetClassName:(NSString *)str {
    Class class = NSClassFromString(str);
    return class;
}
/**
 反射获取属性列表
 
 @param classmode 类型名
 @return 属性列表
 */
+(NSMutableArray *) getClassModePropertyList:(NSString *)classmode {
    unsigned int nCount = 0;
    NSMutableArray *mutarry = [NSMutableArray new];
    objc_objectptr_t *popertylist = class_copyPropertyList([ReflectionClassTools  GetClassName:classmode],&nCount);
    for (int i = 0; i < nCount; i++)
    {
        objc_objectptr_t property = popertylist[i];
        NSLog(@"class Name is = %s && attr = %s",property_getName(property), property_getAttributes(property));
        
        NSArray *array = [NSArray arrayWithObjects:
                          [NSString stringWithCString:property_getName(property) encoding:NSASCIIStringEncoding],
                          [NSString stringWithCString:property_getAttributes(property) encoding:NSASCIIStringEncoding],
                          nil];
        [mutarry addObject:array];
    }
    return mutarry;
}

/**
 字典转数组
 @param mutin 输入字典
 @param cls 数据模型
 @return 返回数组
 */
+ (id)getModelArry:(NSDictionary *)mutin pickStr:(NSString *)pickstr Class:(NSString *)cls {
    //返回数组
    NSMutableArray *classModearry = [NSMutableArray new];
    //获取属性列表
    NSMutableArray *arry = [ReflectionClassTools getClassModePropertyList:cls];
    //查找待分解数组
    NSDictionary  *d = (NSDictionary *)[mutin valueForKey:pickstr];
    //实例化对象名
    Class getid = [ReflectionClassTools GetClassName:cls];
    //数据填充
//    for (NSDictionary *dic in d) {
        id classmode = [getid new];
        for (NSArray *str in arry) {
            NSString *srrrt = [NSString stringWithString:str[1]];
            if ([srrrt rangeOfString:@"NSString"].length >0) {
                [classmode setValue:[NSString stringWithFormat:@"%@",[d valueForKey:str[0]]] forKey:str[0]];
            }
            if ([srrrt rangeOfString:@"NSArray"].length >0) {
                [classmode setValue:[NSArray arrayWithArray:[d valueForKey:str[0]]] forKey:str[0]];
            }
            if ([srrrt rangeOfString:@"NSDictionary"].length >0) {
                [classmode setValue:[NSDictionary dictionaryWithDictionary:[d valueForKey:str[0]]] forKey:str[0]];
            }
        }
        [classModearry addObject:classmode];
//    }
    return classModearry[0];
}

/**
 字典转数组
 @param mutin 输入字典
 @param cls 数据模型
 @return 返回数组
 */
+ (NSArray *)getModelsArry:(NSDictionary *)mutin pickStr:(NSString *)pickstr Class:(NSString *)cls {
    //返回数组
    NSMutableArray *classModearry = [NSMutableArray new];
    //获取属性列表
    NSMutableArray *arry = [ReflectionClassTools getClassModePropertyList:cls];
    //查找待分解数组
    NSArray  *d = (NSArray *)[mutin valueForKey:pickstr];
    //实例化对象名
    Class getid = [ReflectionClassTools GetClassName:cls];
    //数据填充
    for (NSDictionary *dic in d) {
        id classmode = [getid new];
        for (NSArray *str in arry) {
            NSString *srrrt = [NSString stringWithString:str[1]];
            if ([srrrt rangeOfString:@"NSString"].length >0) {
                [classmode setValue:[NSString stringWithFormat:@"%@",[dic valueForKey:str[0]]] forKey:str[0]];
            }
            if ([srrrt rangeOfString:@"NSArray"].length >0) {
                [classmode setValue:[NSArray arrayWithArray:[dic valueForKey:str[0]]] forKey:str[0]];
            }
            if ([srrrt rangeOfString:@"NSDictionary"].length >0) {
                [classmode setValue:[NSDictionary dictionaryWithDictionary:[dic valueForKey:str[0]]] forKey:str[0]];
            }
        }
        [classModearry addObject:classmode];
    }
    return classModearry;
}

/**
 字典数组转对象数组
 @param mutin 输入字典
 @param cls 数据模型
 @return 返回数组
 */
+ (NSArray *)DicArrygetModelsArry:(NSArray *)mutin Class:(NSString *)cls {
    //返回数组
    NSMutableArray *classModearry = [NSMutableArray new];
    //获取属性列表
    NSMutableArray *arry = [ReflectionClassTools getClassModePropertyList:cls];
    //查找待分解数组
    //NSArray  *d = (NSArray *)[mutin valueForKey:pickstr];
    //实例化对象名
    Class getid = [ReflectionClassTools GetClassName:cls];
    //数据填充
    for (NSDictionary *dic in mutin) {
        id classmode = [getid new];
        for (NSArray *str in arry) {
            NSString *srrrt = [NSString stringWithString:str[1]];
            if ([srrrt rangeOfString:@"NSString"].length >0) {
                [classmode setValue:[NSString stringWithFormat:@"%@",[dic valueForKey:str[0]]] forKey:str[0]];
            }
            if ([srrrt rangeOfString:@"NSArray"].length >0) {
                [classmode setValue:[NSArray arrayWithArray:[dic valueForKey:str[0]]] forKey:str[0]];
            }
            if ([srrrt rangeOfString:@"NSDictionary"].length >0) {
                [classmode setValue:[NSDictionary dictionaryWithDictionary:[dic valueForKey:str[0]]] forKey:str[0]];
            }
        }
        [classModearry addObject:classmode];
    }
    return classModearry;
}


@end
