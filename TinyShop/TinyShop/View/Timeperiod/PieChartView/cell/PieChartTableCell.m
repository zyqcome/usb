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

/**
 设置背景图

 @param width 宽度百分百
 @param color 颜色
 */
-(void)addviewPrecent:(CGFloat)width color:(UIColor *)color {
    //float i = self.backView.bounds.size.height;
    //vw = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.backView.frame.size.width * width, 18)];
    vw = [UIView new];
    if (width != 0) {
     self.backcolorView.backgroundColor  = color;
        [self.lineView setAlpha:0];
        vw.backgroundColor = color;
        [self.backView addSubview:vw];
        [vw mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.backView.mas_centerY);
            make.height.mas_equalTo(self.backView.mas_height);
            make.left.mas_equalTo(self.backView.mas_left);
            make.width.mas_equalTo(self.backView.mas_width).multipliedBy(width);
        }];
    } else {
        [self.lineView setAlpha:1];
    }
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
