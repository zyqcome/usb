//
//  MZGoodTableViewCell.h
//  Cell的展开和收起
//
//  Created by MrZhao on 16/12/29.
//  Copyright © 2016年 MrZhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "A.h"
//#import "MZGoodsModel.h"
@interface MZGoodTableViewCell : UITableViewCell

@property (nonatomic,strong)goodsModel *goodModel;
@property (nonatomic,strong)UIColor *leftColor;
@property (nonatomic,strong)UIColor *rightColor;

@property (nonatomic,strong)UIView *leftView;
@property (nonatomic,strong)UIView *rightView;
@property (nonatomic,strong)UILabel *goodNameLabel;
@property (nonatomic,strong)UILabel *goodUnitPriceLabel;
@property (nonatomic,strong)UILabel *goodNumLabel;
@property (nonatomic,strong)UILabel *goodTotalPriceLabel;
@property (nonatomic,assign) CGFloat goodCellHeight;
@end
