//
//  MyScrollView.m
//  成都生活展示
//
//  Created by 韩舟昱 on 2016/11/8.
//  Copyright © 2016年 韩舟昱. All rights reserved.
//

#import "MyScrollView.h"
#import "MZLineView.h"
#import "ColorDefine.h"
@interface MyScrollView ()<UIScrollViewDelegate>
//添加一个滚动视图全局属性
@property (nonatomic,strong)UIScrollView* scrollView;
@property (nonatomic,strong)  UILabel * caiLabel;
@property (nonatomic,strong)  UIButton * button;


@end
@implementation MyScrollView




-(void)setTitleLableArray:(NSArray *)TitleLableArray{
    _TitleLableArray = TitleLableArray;
    //添加图片
    [self addButton];
    //懒加载,添加滚动视图
    [self addSubview:self.scrollView];
    
    self.singleWidth = 60;
}

-(void)setColorArray:(NSArray *)colorArray{
    _colorArray = colorArray;
    //添加图片
    [self addButton];
}


-(void)addButton{
    _colorArray = @[Color_RGBA(241, 54, 44, 1),Color_RGBA(23, 181, 249, 1),Color_RGBA(28, 130, 186, 1),Color_RGBA(254, 193, 32, 1),Color_RGBA(94, 183, 131, 1),Color_RGBA(71, 61, 144, 1),Color_RGBA(161, 85, 179, 1),Color_RGBA(225, 79, 54, 1),Color_RGBA(29, 209, 4, 1),Color_RGBA(199, 76, 254, 1)];
    for (int idx = 0; idx < 10; idx++) {
        
        //循环添加button
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.tag = idx;
        [_button setBackgroundImage:[UIImage imageNamed:@"类别框-须自己填色"] forState:UIControlStateNormal];
        _button.adjustsImageWhenHighlighted = NO;
        _button.frame = CGRectMake((18 +72*idx)*ScreenScale , 0,67*ScreenScale, 75*ScreenScale);
        if (idx == 0) {
            _button.frame = CGRectMake(20*ScreenScale, 0, 67*ScreenScale, 75*ScreenScale);
        }
        _button.backgroundColor = self.colorArray[idx];
        [_button addTarget:self action:@selector(ButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _button.highlighted = NO;
        [_scrollView addSubview:_button];
        
        
        UILabel * tongjiLabel = [[UILabel alloc]initWithFrame:CGRectMake(_button.frame.origin.x, 40*ScreenScale, _button.frame.size.width, 16*ScreenScale)];
        tongjiLabel.text = @"统计";
        tongjiLabel.textAlignment = NSTextAlignmentCenter;
        tongjiLabel.textColor = [UIColor whiteColor];
        tongjiLabel.font = [UIFont systemFontOfSize:11*ScreenScale];
        [self.scrollView addSubview:tongjiLabel];
        
        _caiLabel = [[UILabel alloc]initWithFrame:CGRectMake(_button.frame.origin.x, 23*ScreenScale, _button.frame.size.width, 16*ScreenScale)];
        _caiLabel.textAlignment = NSTextAlignmentCenter;
        _caiLabel.text = self.TitleLableArray[idx];
        _caiLabel.tag = idx;
        _caiLabel.textColor = [UIColor whiteColor];
        _caiLabel.font = [UIFont systemFontOfSize:13*ScreenScale];
        [self.scrollView addSubview:_caiLabel];
        
    }
}

-(void)ButtonClicked:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(selected:Button:)]) {
        [self.delegate selected:self Button:sender];
    }
}


-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewDidEndDecelerating:scrollView];
}

#pragma mark - 懒加载  getter和setter  懒加载是在需要用的时候再加载
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        //获取屏幕的宽度
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_W, self.height+15)];
        _scrollView.contentSize=CGSizeMake( (72 * 10+35)*ScreenScale , 0);
        //button设置完以后的滚动范围
        _scrollView.backgroundColor=[UIColor whiteColor];
        //设置分页效果
        _scrollView.pagingEnabled=NO;
        //取消滚动条
        //        _scrollView.showsHorizontalScrollIndicator=NO;
        
        //设置滚动视图的代理
        _scrollView.delegate=self;
        //关闭弹簧效果
        _scrollView.bounces=NO;
        _scrollView.tag = 836914;
        _scrollView.backgroundColor = [UIColor clearColor];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, _scrollView.maxY-7, Screen_W, 4)];
        view.backgroundColor = LIGHTRED_COLOR;
        [self addSubview:view];
        
    }
    return _scrollView;
}






@end
