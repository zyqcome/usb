//
//  SelectDate.h
//  TinyShop
//
//  Created by 韩舟昱 on 2016/12/29.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SelectDate;

@protocol SelectDateDelegate <NSObject>

-(void)SelectDateButton:(UIButton*)button;
-(void)SelectDateSwitch:(UISwitch*)redSwitch;

@end

@interface SelectDate : UIView
//传出外界赋值每个cell的数组,显示的位置在哪
- (id)initWithSelectDateFrame:(CGRect)frame;
@property (nonatomic,assign)  id<SelectDateDelegate>  delegate;

- (void)showSelectDateView;
- (void)dismissSelectDateView;
@end
