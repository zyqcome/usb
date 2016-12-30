//
//  OperationNetrequest.h
//  TinyShop
//
//  Created by 王灿 on 2016/12/27.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OperatingModel.h"

//网络请求成功回调的block
typedef void(^NetworkBlock)(BOOL a,NSArray *dateAry,NSArray *detailAry) ;

@interface OperationNetrequest : NSObject

@property(nonatomic,copy)NetworkBlock networkBlock; //网络请求之后回调

-(void)getAllOperationtype:(NSString *)type queryTime:(NSString *)queryTime;

@end
