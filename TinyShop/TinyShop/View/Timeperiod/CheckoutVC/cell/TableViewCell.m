//
//  TableViewCell.m
//  TinyShop
//
//  Created by rimi on 16/12/28.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import "TableViewCell.h"


@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)btnSelectAction:(id)sender {
    _Blseleclt = ( _Blseleclt ? false : true );
    [self.btn setImage:[UIImage imageNamed:( _Blseleclt ? @"选中" : @"未选中")] forState:UIControlStateNormal];
}

@end
