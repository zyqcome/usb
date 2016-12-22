//
//  NewsListTableViewCell.m
//  L09-网路请求Demo
//
//  Created by Iracle Zhang on 9/17/15.
//  Copyright (c) 2015 Iracle Zhang. All rights reserved.
//

#import "NewsListTableViewCell.h"

@implementation NewsListTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithUserInterface];
    }
    return self;
}

- (void)initWithUserInterface {
    _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 50, 50)];
    _logoImageView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_logoImageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 10, 230, 50)];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.numberOfLines = 2;
    [self.contentView addSubview:_titleLabel];
    
}

@end












