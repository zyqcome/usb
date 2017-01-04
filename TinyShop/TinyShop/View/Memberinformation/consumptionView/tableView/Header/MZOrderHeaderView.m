//
//  MZOrderHeaderView.m
//  Cell的展开和收起
//
//  Created by MrZhao on 16/12/29.
//  Copyright © 2016年 MrZhao. All rights reserved.
//

#import "MZOrderHeaderView.h"
@interface MZOrderHeaderView()

@property (nonatomic, strong)UIButton *selecButton;

@end

@implementation MZOrderHeaderView

#pragma mark- LifeCycle
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor orangeColor];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.selecButton.frame = self.bounds;
}

#pragma mark- Getter
- (UIButton *)selecButton
{
    if (!_selecButton) {
        _selecButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selecButton addTarget:self action:@selector(taped) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_selecButton];
    }
    return _selecButton;
}

#pragma mark- Action
- (void)taped
{
    if (self.didSelectSection) {
        self.didSelectSection(self.section);
    }
}


@end



















