//
//  MyScrollView.h
//  成都生活展示
//
//  Created by 韩舟昱 on 2016/11/8.
//  Copyright © 2016年 韩舟昱. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZLineView.h"
#import "UIView+Addtions.h"
@class MyScrollView;
@protocol UIButtonSelectedDelegate <NSObject>
-(void)selected:(MyScrollView *)scoll Button:(UIButton*)button;

@end
@interface MyScrollView : UIView

//一个网格宽度
@property(nonatomic, assign) CGFloat singleWidth;

@property (nonatomic,assign)  id<UIButtonSelectedDelegate>  delegate;
@property (nonatomic,strong)  NSArray * TitleLableArray;
@property (nonatomic,strong)  NSArray * colorArray;


@end
