//
//  UITextField+TextFieldRange.h
//  TinyShop
//
//  Created by 韩舟昱 on 2016/12/21.
//  Copyright © 2016年 Hzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (TextFieldRange)

- (NSRange)selectedRange;

- (void)setSelectedRange:(NSRange)range;

@end
