//
//  ShowStoreCell.m
//  TinyShop
//
//  Created by 韩舟昱 on 2016/12/28.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import "ShowStoreCell.h"

@implementation ShowStoreCell

- (IBAction)redSwitchClicked:(UISwitch *)sender {
    if ([self.delegate respondsToSelector:@selector(selected:redSwitch:)]) {
        [self.delegate selected:self redSwitch:sender];
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
