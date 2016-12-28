//
//  SQMenuShowView.h
//  TinyShop
//
//  Created by 韩舟昱 on 2016/12/24.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQMenuShowView : UIView


- (id)initWithFrame:(CGRect)frame items:(NSArray <NSString *> *)items showPoint:(CGPoint)showPoint;



//@property (strong, nonatomic) UIColor *sq_selectColor; //选后的颜色
@property (strong, nonatomic) UIColor *sq_backGroundColor;
@property (copy, nonatomic) void(^selectBlock)(SQMenuShowView *view, NSInteger index);

@property (copy, nonatomic) UIColor *itemTextColor;


- (void)selectBlock:(void(^)(SQMenuShowView *view, NSInteger index))block;

- (void)showView;
- (void)dismissView;


@end
