//
//  NetworkTools.h
//  TiTi音乐
//
//  Created by 韩舟昱 on 16/9/6.
//  Copyright © 2016年 韩舟昱. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef enum : NSUInteger {
    GET,
    POST,
} requestMethod;

typedef void(^networkCallback)(id data, NSError *error);

@interface NetworkTools : AFHTTPSessionManager

+ (instancetype)sharedTooles;
- (void)requestMethod:(requestMethod)method isJson:(BOOL)json WithUrl:(NSString *)url parematers:(id)param finished:(networkCallback)finish;


@end
