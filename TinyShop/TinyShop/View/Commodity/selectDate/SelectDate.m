//
//  SelectDate.m
//  TinyShop
//
//  Created by 韩舟昱 on 2016/12/29.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import "SelectDate.h"

@implementation SelectDate

- (id)initWithSelectDateFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.frame = CGRectMake(15, 64+55, Screen_W-30, Screen_H-64-55-20);
        self.alpha = 1;
        //动画起始位置
        self.layer.anchorPoint = CGPointMake(0.9, 0);
        self.layer.position = CGPointMake(self.layer.position.x+self.frame.size.width*0.4, self.layer.position.y-self.frame.size.height*0.5);
        [self setupUI];
    }
    return self;
}
#pragma mark - 创建ui

-(void)setupUI{
    //线1
    UIView * oneView = [[UIView alloc]initWithFrame:CGRectMake(0, 50*ScreenScale, self.frame.size.width, 0.5)];
    oneView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:oneView];
    //关闭
    UIButton * closeButton = [[UIButton alloc]initWithFrame:CGRectMake(Screen_W-(85*ScreenScale), 8, 33*ScreenScale, 33*ScreenScale)];
    closeButton.tag = 1;
    [closeButton setBackgroundImage:[UIImage imageNamed:@"关闭2"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeButton];
    
    
    //选择查询label
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(35*ScreenScale, CGRectGetMaxY(oneView.frame)+8, 180*ScreenScale, 28*ScreenScale)];
    label.text = @"选择查询方式";
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:18*ScreenScale];
    [self addSubview:label];
    
    //添加一个view
    UIView * buttonBGView = [[UIView alloc]initWithFrame:CGRectMake(30*ScreenScale, CGRectGetMaxY(label.frame)+8, self.frame.size.width-50*ScreenScale, 100*ScreenScale)];
    buttonBGView.backgroundColor = [UIColor clearColor];
    [self addSubview:buttonBGView];
    
    //循环添加button
    for (int index = 0; index < 4; index++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (index == 0) {
            button.frame = CGRectMake(0, 0, buttonBGView.frame.size.width/4-10, 85*ScreenScale-12);
        }else{
            button.frame = CGRectMake(buttonBGView.frame.size.width/4*index, 0, buttonBGView.frame.size.width/4-10, 85*ScreenScale-12);
        }
    
        NSString * imageStr = [NSString stringWithFormat:@"未选%d",index];
        [button setBackgroundImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
        [buttonBGView addSubview:button];
        
        
    }
    
    //确定button
    UIButton * confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(40*ScreenScale, CGRectGetMaxY(oneView.frame)+200*ScreenScale,self.frame.size.width-(80*ScreenScale), 45*ScreenScale)];
    [confirmButton setTitle:@"确         定" forState:UIControlStateNormal];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"确----定背景框"] forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    confirmButton.titleLabel.font    = [UIFont systemFontOfSize: 21*ScreenScale];
    [self addSubview:confirmButton];
    
    //线2
    UIView * twoView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(confirmButton.frame)+10, self.frame.size.width, 0.5)];
    twoView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:twoView];
    
    //pickerView
    UIDatePicker * pickerView = [[ UIDatePicker alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(twoView.frame)+4, self.frame.size.width, self.frame.size.height-CGRectGetMaxY(twoView.frame)-8)];
    [self addSubview:pickerView];
    
}

-(void)closeButtonClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(SelectDateButton:)]) {
        [self.delegate SelectDateButton:sender];
    }
}

#pragma - 动画方法

- (void)showSelectDateView{
    
    self.alpha = 0;
    self.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    [UIView animateWithDuration:0.2 animations:^{
        
        self.transform = CGAffineTransformMakeScale(1, 1);
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismissSelectDateView{
    
    [UIView animateWithDuration:0.2 animations:^{
        self.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
        self.alpha = 0;
    }];
}






@end
