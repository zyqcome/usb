//
//  MZOrderHeaderView.h
//  Cell的展开和收起
//
//  Created by MrZhao on 16/12/29.
//  Copyright © 2016年 MrZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SectionCallBack)(NSUInteger section);
@interface MZOrderHeaderView : UITableViewHeaderFooterView

@property (nonatomic, assign) NSUInteger section;

@property (nonatomic, copy) SectionCallBack didSelectSection;

@end
