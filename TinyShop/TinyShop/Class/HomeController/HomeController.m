//
//  HomeController.m
//  TinyShop
//
//  Created by 韩舟昱 on 2016/12/22.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import "HomeController.h"

#import "DrawerController.h"
//日常运营分析
#import "StatisticalViewController.h"
//时段收入分析
#import "TimeperiodVC.h"
@interface HomeController ()
@property (nonatomic,strong) DrawerController *leftVc;
@property (nonatomic,strong) UIButton *coverBtn;
@property (nonatomic,assign) CGPoint beginP;
@property (nonatomic,strong) UIImageView *imageV;
@property (nonatomic,strong)  NSArray * dataArray;


@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}
    //    // 开机启动画面
    //    _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(-SCREEN_W, 0, SCREEN_W*2, SCREEN_H)];
    //    _imageV.image = [UIImage imageNamed:@"启动"];
    //    [self.view addSubview:_imageV];
    //    [self.view bringSubviewToFront:_imageV];
    //    [UIView animateWithDuration:1 animations:^{
    //        _imageV.frame = CGRectMake(0, 0, SCREEN_W*2, SCREEN_H);
    //    }];
    //    [_imageV removeFromSuperview];
    
    
//    // 初始化遮盖btn
//    _coverBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, Screen_W, Screen_H)];
//    _coverBtn.backgroundColor = [UIColor grayColor];
//    _coverBtn.alpha = 0;
//    // 添加点击事件
//    if (self.leftVc.view.frame.origin.x == 0) {
//        [_coverBtn addTarget:self action:@selector(leftAnimation) forControlEvents:UIControlEventTouchUpInside];
//    }
//    
//    
//    // 拖拽手势初始化
//    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
//    
//    [self.view addGestureRecognizer:panGesture];
//    
//    // 添加子控制器
//    [self addChildVc];
//    // 调用代码块方法
//    //[self changeFrame];
//    
//}
//
//
//
//#pragma mark - 改变状态栏颜色，只能在最外层控制器更改
//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
//}
//
//#pragma mark - 拖拽手势事件回调方法
//- (void)panGesture:(UIPanGestureRecognizer *)gesture {
//    if (self.leftVc.view.frame.origin.x > - LeftVcOffSet) {
//        if (gesture.state == UIGestureRecognizerStateChanged) {
//            // 获得当前移动点
//            CGPoint offSet = [gesture translationInView:gesture.view];
//            CGFloat newX = LeftVcOffSet + offSet.x;
//            
//            if (newX >= LeftVcOffSet) {
//                //                [self rightAnimation];
//                
//                return;
//            }
//            
//            if (newX <= 0) {
//                //                [self leftAnimation];
//                return;
//            }
//            
//            self.view.frame = CGRectMake(newX, 0, Screen_W, Screen_H);
//            
//            self.leftVc.view.frame = CGRectMake(offSet.x, 0, LeftVcOffSet, Screen_H);
//        }else if (gesture.state == UIGestureRecognizerStateEnded) {
//            if (self.view.frame.origin.x < Screen_W/2) {
//                [self leftAnimation];
//            }else {
//                [self rightAnimation];
//            }
//        }
//    }
//}
//
//#pragma mark - 代码块回调改变frame
////- (void)changeFrame {
////  __weak typeof(self) weakSelf = self;
////weakSelf.self.block = ^() {
////    if (self.tbc.view.frame.origin.x == 0) {
//// 右边动画效果
////      [self rightAnimation];
////  }else {
//// 左边动画效果
////       [self leftAnimation];
////}
////   };
////}
//
//#pragma mark - 动画效果
//// 左边动画
//- (void)leftAnimation {
//    [UIView animateWithDuration:0.2 animations:^{
//        // 标签控制器偏移
//        self.view.frame = CGRectMake(0, 0, Screen_W, Screen_H);
//        // 左边视图偏移
//        self.leftVc.view.frame = CGRectMake(- LeftVcOffSet, 0, LeftVcOffSet, Screen_H);
//        // 移除遮盖btn
//        [_coverBtn removeFromSuperview];
//    }];
//}
//
//// 右边动画
//- (void)rightAnimation {
//    // 添加遮盖btn
//    [self.view addSubview:_coverBtn];
//    
//    [UIView animateWithDuration:0.2 animations:^{
//        // 标签控制器偏移
//        self.view.frame = CGRectMake(LeftVcOffSet, 0, Screen_W, Screen_H);
//        // 左边视图偏移
//        self.leftVc.view.frame = CGRectMake(0, 0, LeftVcOffSet, Screen_H);
//        // 遮盖btn透明度
//        _coverBtn.alpha = 0.02;
//    }];
//}
//
//#pragma mark - 添加子控制器
//- (void)addChildVc {
//    // 初始化左边控制器
//    DrawerController *leftVc = [[DrawerController alloc] init];
//    self.leftVc = leftVc;
//    //    leftVc.view.backgroundColor = [UIColor orangeColor];
//    // 设置左边视图frame
//    leftVc.view.frame = CGRectMake(- LeftVcOffSet, 0, LeftVcOffSet, Screen_H);
//    // 添加
//    [self addChildViewController:leftVc];
//    [self.view addSubview:leftVc.view];
//    
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
//
//}

#pragma mark - 数据源方法

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
    switch (indexPath.row) {
        case 0:
        {
            TimeperiodVC *svc = [TimeperiodVC new];
            [self.navigationController pushViewController:svc animated:YES];
        }
            break;
        case 1:
        {
            StatisticalViewController *svc = [StatisticalViewController new];
            [self.navigationController pushViewController:svc animated:YES];
        }
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
        
            break;
        default
            :
            break;
    }
}




@end
