//
//  PieChartTableCell.h
//  TinyShop
//
//  Created by rimi on 16/12/29.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PieChartTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelPercent;
-(void)addviewPrecent:(CGFloat)width color:(UIColor *)color ;
@property (weak, nonatomic) IBOutlet UIView *backView;
@end
