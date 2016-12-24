//
//  DHControllerViewController.m
//  TinyShop
//
//  Created by 韩舟昱 on 2016/12/23.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import "DHControllerViewController.h"
#import "DrawerController.h"
#import "HomeController.h"
#import "LoginController.h"

@interface DHControllerViewController ()
@property (nonatomic,strong)  HomeController * homeVc;
@property (nonatomic,strong) DrawerController *leftVc;
@property (nonatomic,strong) UIButton *coverBtn;
@property (nonatomic,assign) CGPoint beginP;
@end

@implementation DHControllerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 添加子控制器
    [self addChildVc];
    
    // 初始化遮盖btn
    _coverBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, Screen_W, Screen_H)];
    _coverBtn.backgroundColor = [UIColor grayColor];
    _coverBtn.alpha = 0;
    // 添加点击事件
    if (self.leftVc.view.frame.origin.x == 0) {
        [_coverBtn addTarget:self action:@selector(leftAnimation) forControlEvents:UIControlEventTouchUpInside];
    }

    // 拖拽手势初始化
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    
    [self.view addGestureRecognizer:panGesture];
    
}


#pragma mark - 拖拽手势事件回调方法
- (void)panGesture:(UIPanGestureRecognizer *)gesture {
    if (self.leftVc.view.frame.origin.x > - LeftVcOffSet) {
        if (gesture.state == UIGestureRecognizerStateChanged) {
            // 获得当前移动点
            CGPoint offSet = [gesture translationInView:gesture.view];
            CGFloat newX = LeftVcOffSet + offSet.x;
            
            if (newX >= LeftVcOffSet) {
                [self rightAnimation];
                return;
            }
            if (newX <= 0) {
                [self leftAnimation];
                return;
            }
            
            self.navigationVC.view.frame = CGRectMake(newX, 0, Screen_W, Screen_H);
            
            self.leftVc.view.frame = CGRectMake(offSet.x, 0, LeftVcOffSet, Screen_H);
        }else if (gesture.state == UIGestureRecognizerStateEnded) {
            if (self.navigationVC.view.frame.origin.x < Screen_W/2) {
                [self leftAnimation];
            }else {
                [self rightAnimation];
            }
        }
    }
}

#pragma mark - 动画效果
// 左边动画
- (void)leftAnimation {
    [UIView animateWithDuration:0.2 animations:^{
        // 标签控制器偏移
        self.navigationVC.view.frame = CGRectMake(0, 0, Screen_W, Screen_H);
        // 左边视图偏移
        self.leftVc.view.frame = CGRectMake(-LeftVcOffSet, 0, LeftVcOffSet, Screen_H);
        // 移除遮盖btn
        [_coverBtn removeFromSuperview];
    }];
}

// 右边动画
- (void)rightAnimation {
    // 添加遮盖btn
    [self.homeVc.view addSubview:_coverBtn];
    
    [UIView animateWithDuration:0.2 animations:^{
        // 标签控制器偏移
        self.navigationVC.view.frame = CGRectMake(LeftVcOffSet, 0, Screen_W, Screen_H);
        // 左边视图偏移
        self.leftVc.view.frame = CGRectMake(0, 0, LeftVcOffSet, Screen_H);
        // 遮盖btn透明度
        _coverBtn.alpha = 0.02;
    }];
}


#pragma mark - 添加子控制器
- (void)addChildVc {
    // 初始化左边控制器
    self.leftVc = [[DrawerController alloc] init];
    
    UIStoryboard * storyHomeVC = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    self.homeVc =  [storyHomeVC instantiateViewControllerWithIdentifier:@"HomeController"];
    UINavigationController * navigationVC = [[UINavigationController alloc]initWithRootViewController:self.homeVc];
    self.navigationVC = navigationVC;
    
    // 设置左边视图frame
    self.leftVc.view.frame = CGRectMake(-LeftVcOffSet, 0, LeftVcOffSet, Screen_H);
    self.homeVc.view.frame = CGRectMake(0, 64, Screen_W, Screen_H);
    self.navigationVC.view.frame = CGRectMake(0, 0, Screen_W, Screen_H);
    
    // 添加
    [self addChildViewController:self.leftVc];
    [self.view addSubview:self.leftVc.view];
    
    [self addChildViewController:navigationVC];
    [self.view addSubview:self.homeVc.view];
    
    [self addChildViewController:navigationVC];
    [self.view addSubview:navigationVC.view];
    
    UIBarButtonItem * leftBar = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"抽屉按钮"] style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBarButtonClicked)];
    
    self.homeVc.navigationItem.leftBarButtonItem = leftBar;
    
    UIBarButtonItem * rightBar = [[UIBarButtonItem alloc]initWithTitle:@"注销" style:(UIBarButtonItemStyleDone) target:self action:@selector(rightBarButtonClicked)];
    self.homeVc.navigationItem.rightBarButtonItem = rightBar;
    self.homeVc.navigationItem.rightBarButtonItem.tintColor = [UIColor redColor];
    
    
    self.homeVc.title = @"云迈天行特色火锅-销";
    self.navigationVC.view.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.navigationVC.view.layer.shadowOffset = CGSizeMake(-3, 0);
    self.navigationVC.view.layer.shadowOpacity = 0.9;
    
}

-(void)leftBarButtonClicked{
    if (_homeVc.view.frame.origin.x == 0) {
        [self rightAnimation];
    }
}

-(void)rightBarButtonClicked{
    LoginController * login = [LoginController new];
    [self presentViewController:login animated:NO completion:nil];
    
}


@end
