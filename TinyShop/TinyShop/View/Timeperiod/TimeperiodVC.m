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
#import "presentView.h"
#import "TimeperiodProtocol.h"
@interface TimeperiodVC ()<TimeperiodProtocol>
{
    presentView *vw;
    NSArray<linePointModel *> *linChartArry;
}
@property (weak, nonatomic) IBOutlet UIView *viewLineChart;
@end

@implementation TimeperiodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TimeperiodNethelper *timeperiodNethelper = [TimeperiodNethelper new];
    timeperiodNethelper.delege =self;
    //获取所有店铺信息
    [timeperiodNethelper getTimeperiodDate];
    
    //添加导航栏
    UIBarButtonItem *one = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回按钮"] style:UIBarButtonItemStylePlain target:self action:@selector(btnBackAction)];
    UIBarButtonItem *two = [[UIBarButtonItem alloc] initWithTitle:@"选择店铺" style:UIBarButtonItemStylePlain target:self action:@selector(btnSection)];
    two.tintColor = [UIColor redColor];
    self.title = @"实时销售总趋势图";
    self.navigationItem.leftBarButtonItem =one;
    self.navigationItem.rightBarButtonItem = two;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 显示折线图
 */
-(void)showLineChart {
    //显现显示折线图
    
    MZLineView *lineView = [[MZLineView alloc]initWithFrame:CGRectMake(0, 0, self.viewLineChart.width,self.viewLineChart.height-60)];
    NSMutableArray *titleArry = [NSMutableArray new];
    NSMutableArray *incomeArry = [NSMutableArray new];
    for (linePointModel *lm in linChartArry) {
        [titleArry addObject:[lm.time stringByAppendingString:@"时"]];
        [incomeArry addObject:lm.value];
    }
    lineView.titleStore = titleArry;//@[@"0时",@"1时",@"2时",@"3时",@"4时",@"5时",@"6时",@"7时",@"8时",@"9时",@"10时",@"11时",@"12时",@"13时",@"14时",@"15时",@"16时",@"17时",@"18时",@"19时",@"20时",@"21时",@"22时",@"23时"];
    lineView.bottomMargin = 50;
    lineView.incomeBottomMargin = 65;
    lineView.incomeStore = incomeArry;//@[@"50",@"50",@"50",@"50",@"50",@"0",@"50",@"50",@"50",@"50",@"50",@"50",@"50",@"50",@"50",@"50",@"50",@"50",@"50",@"50",@"50",@"0",@"50",@"50",];
    
    [self.viewLineChart addSubview:lineView];
    lineView.topTitleCallBack = ^NSString *(CGFloat sumValue){
        return [NSString stringWithFormat:@"实时总收入:%.1f元",sumValue];
    };
    
    lineView.selectCallback = ^(NSUInteger index){
        NSLog(@"选中第%@个",@(index));
    };
    [lineView storkePath];
    //[lineView removeFromSuperview];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -action
- (void)btnBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)btnSection {
    /***
    vw = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    vw.backgroundColor = [UIColor grayColor];
    UIButton *tb = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [tb addTarget:self action:@selector(tbAction) forControlEvents:UIControlEventTouchUpInside];
    tb.backgroundColor = [UIColor blackColor];
    [vw addSubview:tb];
    [self.view addSubview:vw];
     */
    vw = [[presentView alloc] initWithFrame:CGRectMake(50, 50, 200, 400)];//initWithWidth:100 Height:200];
    vw.backgroundColor = [UIColor grayColor];
    [vw ViewInit];
    [self.view addSubview:vw];
    
}

-(void)tbAction {
    [vw removeFromSuperview];
}

#pragma mark -数据刷新消息
-(void)resetTimeperiod:(Received)sender Bl:(BOOL)bl message:(id)ms {
    if (sender == Received_lineChart ) {
        //获取到linechart数据
        linChartArry = [NSArray arrayWithArray:(NSArray *)ms];
        //显示折线图
        [self showLineChart];
    }
    
}

@end
