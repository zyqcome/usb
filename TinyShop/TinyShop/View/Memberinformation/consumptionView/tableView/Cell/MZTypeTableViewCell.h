//
//  MZTypeTableViewCell.h
//  Cell的展开和收起
//
//  Created by MrZhao on 16/12/29.
//  Copyright © 2016年 MrZhao. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MZTypeModel.h"
#import "MZGoodTableViewCell.h"

@interface MZTypeTableViewCell : UITableViewCell
//类型背景
@property (nonatomic,strong) UIView *typeBackground;
//类型label
@property (nonatomic,strong) UILabel *typeLabel;
//订单详情
@property (nonatomic,strong) UILabel *detialLabel;
//对应此类型的食物tableview
@property (nonatomic,strong) UITableView *goodsTableView;
//对应的类型model
@property (nonatomic,strong) AA *typeModelAA;

@end
