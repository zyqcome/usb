//
//  NetworkTools.m
//  TiTi音乐
//
//  Created by 韩舟昱 on 16/9/6.
//  Copyright © 2016年 韩舟昱. All rights reserved.
//

#import "NetworkTools.h"

@implementation NetworkTools

+ (instancetype)sharedTooles{
    // 创建一个静态的类对象
    static NetworkTools * instance;
    //使用GCD多线程的一次性代码
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NetworkTools alloc]initWithBaseURL:nil];
        // 加入 text/html 解析
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    return instance;
}

//封装网络数据请求的方法
- (void)requestMethod:(requestMethod)method WithUrl:(NSString *)url parematers:(id)param finished:(networkCallback)finish{
    //直接调用AFN的方法
    if (method == GET) {
        [self GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //
            finish(responseObject,nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //
            finish(nil,error);
        }];
        
    }else{
        [self POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //
            finish(responseObject,nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //
            finish(nil,error);
        }];
    }
}


@end
