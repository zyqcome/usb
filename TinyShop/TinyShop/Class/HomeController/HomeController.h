//
//  HomeController.h
//  TinyShop
//
//  Created by 韩舟昱 on 2016/12/22.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import <UIKit/UIKit.h>
//1，定义block 类型
typedef void(^leftBtnBlock)();

@interface HomeController : UITableViewController
@property (nonatomic,copy)  leftBtnBlock  leftBtnBlock;
//@property (nonatomic,strong)  UINavigationController * navigationVC;

@end
