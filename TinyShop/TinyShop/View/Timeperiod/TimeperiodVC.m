//
//  TimeperiodVC.m
//  TinyShop
//
//  Created by rimi on 16/12/22.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import "TimeperiodVC.h"
#import "TimeperiodNethelper.h"
#import "MZLineView.h"
#import "UIView+Addtions.h"
@interface TimeperiodVC ()
@property (weak, nonatomic) IBOutlet UIView *viewLineChart;

@end

@implementation TimeperiodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    TimeperiodNethelper *timeperiodNethelper = [TimeperiodNethelper new];
    //获取所有店铺信息
    [timeperiodNethelper getTimeperiodDate];
    
    MZLineView *lineView = [[MZLineView alloc]initWithFrame:CGRectMake(0, 0, self.viewLineChart.width,self.viewLineChart.height-60)];
    lineView.titleStore = @[@"0时",@"1时",@"2时",@"3时",@"4时",@"5时",@"6时",@"7时",@"8时",@"9时",@"10时",@"11时",@"12时",@"13时",@"14时",@"15时",@"16时",@"17时",@"18时",@"19时",@"20时",@"21时",@"22时",@"23时"];
    //lineView.titleStore = @[@"2016-11-11",@"2016-11-12",@"2016-11-13",@"2016-11-14",@"4时",@"5时",@"6时",@"7时",@"8时",@"9时",@"10时",@"11时",@"12时",@"13时",@"14时",@"15时",@"16时",@"17时",@"18时",@"19时",@"20时",@"21时",@"22时",@"23时"];
//    CGAffineTransform transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 15, 40);
//    transform = CGAffineTransformRotate(transform, M_PI*0.31);
//    lineView.labelTransform = transform;
    lineView.bottomMargin = 65;
    lineView.incomeBottomMargin = 20;
    lineView.incomeStore = @[@"50",@"50",@"50",@"50",@"50",@"0",@"50",@"50",@"50",@"50",@"50",@"50",@"50",@"50",@"50",@"50",@"50",@"50",@"50",@"50",@"50",@"0",@"50",@"50",];
    
    [self.viewLineChart addSubview:lineView];
    lineView.topTitleCallBack = ^NSString *(CGFloat sumValue){
        return [NSString stringWithFormat:@"实时总收入:%.1f元",sumValue];
    };
    
    lineView.selectCallback = ^(NSUInteger index){
        NSLog(@"选中第%@个",@(index));
    };
    [lineView storkePath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
