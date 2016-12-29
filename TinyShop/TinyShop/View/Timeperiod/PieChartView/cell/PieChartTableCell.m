//
//  PieChartTableCell.m
//  TinyShop
//
//  Created by rimi on 16/12/29.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import "PieChartTableCell.h"
@interface PieChartTableCell()
{
    UIView *vw;
    CAShapeLayer *layer;
}
@end
@implementation PieChartTableCell

-(void)addviewPrecent:(CGFloat)width color:(UIColor *)color {
    vw = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, self.backView.frame.size.height)];
    vw.backgroundColor = color;
    [self.backView addSubview:vw];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
