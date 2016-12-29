//
//  PieChartView.h
//  TinyShop
//
//  Created by rimi on 16/12/29.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dishModel : NSObject
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *value;
@end

@interface PieChartModel:NSObject
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *value;
@property (nonatomic, assign)CGFloat maxDishAddValue;//所有菜单经营和值
@property (nonatomic, strong)NSArray<dishModel *> *dishArry;
@end
@interface PieChartView : UIViewController

@end
