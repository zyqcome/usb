//
//  MyScrollView.h
//  成都生活展示
//
//  Created by 韩舟昱 on 2016/11/8.
//  Copyright © 2016年 韩舟昱. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyScrollView;
@protocol UIButtonSelectedDelegate <NSObject>
-(void)selected:(MyScrollView *)scoll Button:(UIButton*)button Label:(UILabel *)caiLabel;

@end
@interface MyScrollView : UIView
@property (nonatomic,assign)  id<UIButtonSelectedDelegate>  delegate;
@property (nonatomic,strong)  NSArray * TitleLableArray;


@end
