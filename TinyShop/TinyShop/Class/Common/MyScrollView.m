//
//  MyScrollView.m
//  成都生活展示
//
//  Created by 韩舟昱 on 2016/11/8.
//  Copyright © 2016年 韩舟昱. All rights reserved.
//

#import "MyScrollView.h"

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
    
}


-(void)addButton{
    for (int index = 0; index < 10; index++) {
        //循环添加button
       _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.tag = index;
        _button.frame = CGRectMake((18 +72*index)*ScreenScale , 0,67*ScreenScale, 75*ScreenScale);
        if (index == 0) {
            _button.frame = CGRectMake(20*ScreenScale, 0, 67*ScreenScale, 75*ScreenScale);
        }
        [_button setBackgroundImage:[UIImage imageNamed:@"类别框-须自己填色"] forState:UIControlStateNormal];
        _button.adjustsImageWhenHighlighted = NO;
        switch (index) {
            case 0:
                [_button setBackgroundColor:Color_RGBA(241, 54, 44, 1)];
                break;
            case 1:
                [_button setBackgroundColor:Color_RGBA(23, 181, 249, 1)];
                break;
            case 2:
                [_button setBackgroundColor:Color_RGBA(28, 130, 186, 1)];
                break;
            case 3:
                [_button setBackgroundColor:Color_RGBA(254, 193, 32, 1)];
                break;
            case 4:
                [_button setBackgroundColor:Color_RGBA(94, 183, 131, 1)];
                break;
            case 5:
                [_button setBackgroundColor:Color_RGBA(71, 61, 144, 1)];
                break;
            case 6:
                [_button setBackgroundColor:Color_RGBA(161, 85, 179, 1)];
                break;
            case 7:
                [_button setBackgroundColor:Color_RGBA(225, 79, 54, 1)];
                break;
            case 8:
                [_button setBackgroundColor:Color_RGBA(29, 209, 4, 1)];
                break;
            default:
                [_button setBackgroundColor:Color_RGBA(199, 76, 254, 1)];
                break;
        }

        //添加button到滚动视图
        [self.scrollView addSubview:_button];
        [_button addTarget:self action:@selector(ButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel * tongjiLabel = [[UILabel alloc]initWithFrame:CGRectMake(_button.frame.origin.x, 40*ScreenScale, _button.frame.size.width, 16*ScreenScale)];
        tongjiLabel.text = @"统计";
        tongjiLabel.textAlignment = NSTextAlignmentCenter;
        tongjiLabel.textColor = [UIColor whiteColor];
        tongjiLabel.font = [UIFont systemFontOfSize:11*ScreenScale];
        [self.scrollView addSubview:tongjiLabel];
        
        _caiLabel = [[UILabel alloc]initWithFrame:CGRectMake(_button.frame.origin.x, 23*ScreenScale, _button.frame.size.width, 16*ScreenScale)];
        _caiLabel.textAlignment = NSTextAlignmentCenter;
        _caiLabel.text = self.TitleLableArray[index];
        _caiLabel.tag = index;
        _caiLabel.textColor = [UIColor whiteColor];
        _caiLabel.font = [UIFont systemFontOfSize:13*ScreenScale];
        [self.scrollView addSubview:_caiLabel];
        
    }
    //button设置完以后的滚动范围
    self.scrollView.contentSize=CGSizeMake( (72 * 10+35)*ScreenScale , 0);
    
   }

-(void)ButtonClicked:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(selected:Button:Label:)]) {
//        [self.delegate selected:self Button:sender];
        [self.delegate selected:self Button:sender Label:self.caiLabel];
    }
}


-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewDidEndDecelerating:scrollView];
}

#pragma mark - 懒加载  getter和setter  懒加载是在需要用的时候再加载
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        //获取屏幕的宽度
        _scrollView=[UIScrollView new];
        _scrollView.frame=CGRectMake(0, 0, Screen_W, 75*ScreenScale);
        _scrollView.backgroundColor=[UIColor whiteColor];
        //设置分页效果
        _scrollView.pagingEnabled=NO;
        //取消滚动条
        _scrollView.showsHorizontalScrollIndicator=NO;
        
        //设置滚动视图的代理
        _scrollView.delegate=self;
        //关闭弹簧效果
        _scrollView.bounces=NO;
    }
    return _scrollView;
}



@end
