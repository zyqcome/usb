//
//  consumptionModel.h
//  TinyShop
//
//  Created by rimi on 17/1/4.
//  Copyright © 2017年 cc.zyqblog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "orderModel.h"

@interface AA : NSObject
@property (nonatomic, strong) NSString *kindName; // = "味碟类";
@property (nonatomic, strong) NSMutableArray<goodsModel *> *goods; // = [
@end


@interface A : NSObject
@property (nonatomic, strong) NSArray<AA *> *goods; // = [
@end
