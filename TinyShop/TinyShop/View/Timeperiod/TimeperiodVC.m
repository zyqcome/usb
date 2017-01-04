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
#import "ShowStore.h"
#import "PieChartView.h"
@interface TimeperiodVC ()<TimeperiodProtocol,ShowShoreDelegate>
{
    presentView *vw;
    NSArray<linePointModel *> *linChartArry;
    MZLineView *lineView;
    //店铺选择
    NSMutableArray<shopShow *> *shopArry;
}
@property (weak, nonatomic) IBOutlet UIView *viewLineChart;
@property (nonatomic,strong)  ShowStore * showStore;

@property (nonatomic,strong)  UIView * coverNoTouch;

@property (nonatomic,strong)  NSString *cashshopArry;

@end

@implementation TimeperiodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TimeperiodNethelper *timeperiodNethelper = [TimeperiodNethelper new];
    timeperiodNethelper.delege =self;
    //获取所有店铺信息
    [timeperiodNethelper getTimeperiodDate];
    
    //返回所有店铺名称id
    [self getAllShopArryNameId];
    
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

 @param titleStore 横轴数组
 @param incomeStore 纵轴数组
 */
-(void)showLineChartTitleStore:(NSArray *)titleStore  IncomeStore:(NSArray *)incomeStore{
    //显现显示折线图
    
    lineView = [[MZLineView alloc]initWithFrame:CGRectMake(0, 0, self.viewLineChart.width,self.viewLineChart.height-80)];
    lineView.titleStore =titleStore;
    lineView.bottomMargin = 50;
    lineView.incomeBottomMargin = 65;
    lineView.incomeStore = incomeStore;
    
    [self.viewLineChart addSubview:lineView];
    lineView.topTitleCallBack = ^NSString *(CGFloat sumValue){
        return [NSString stringWithFormat:@"实时总收入:%.1f元",sumValue];
    };
    __weak typeof(self) weakSelf = self;
    lineView.selectCallback = ^(NSUInteger index){
#pragma mark -折线图点击相应
        NSLog(@"选中第%@个",@(index));
        
        //时间日期设置
        //获取当前时间
        NSDate *date= [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"hh"];
        NSString *hhString = [dateFormatter stringFromDate:date];
        //判断当前小时
        if ([linChartArry[index].time intValue] < [hhString intValue]) {
            //选择的时间不现在的时间 早，说明是今天的数据
            //date = [NSDate dateWithTimeIntervalSinceNow:-1*24*60*60]; //一天前
        } else {
            //选择的时间不现在的时间 晚，说明是昨天的数据
            date = [NSDate dateWithTimeIntervalSinceNow:-1*24*60*60]; //一天前
        }
        [dateFormatter setDateFormat:@"yyyy-MM-dd "];
        NSString *dateString = [dateFormatter stringFromDate:date];
        dateString = [dateString stringByAppendingString:[NSString stringWithFormat:@"%02lu",(unsigned long)index]];
        
        PieChartView *svc = [PieChartView new];
        svc.displayshoplist = weakSelf.cashshopArry;
        svc.displayshopdate = dateString;
        [weakSelf.navigationController pushViewController:svc animated:YES];
        
    };
    [lineView storkePath];
    
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

/**
 -(NSArray *)strAllShopListArry {
 //数据模拟
 LoginViewMode *loginViewMode = [LoginViewMode shareUserInfo];
 NSMutableArray *resultArry = [NSMutableArray new];
 //获取-所有分店
 shopShow *sw = [shopShow new];
 NSString *mutStr = loginViewMode.shop.shop_id;
 //加上登陆店铺本身
 [resultArry addObject:mutStr];
 for (int i=0; i< loginViewMode.shop.subs.count; i++) {
 ShopSubModel *shopsubModel = loginViewMode.shop.subs[i];
 NSString *str = [NSString stringWithString:shopsubModel.shop_id];
 [resultArry addObject:str];
 }
 return resultArry;
 }
 */

- (void)btnSection {
//    vw = [[presentView alloc] initWithFrame:CGRectMake(50, 50, 200, 400)];
//    vw.backgroundColor = [UIColor whiteColor];
////    NSMutableArray *arry = [NSMutableArray new];
////    for (int i =0; i <10; i++) {
////        shopShow *sw = [shopShow new];
////        sw.shopname = @"OK";
////        sw.showIs = true;
////        [arry addObject:sw];
////    }
//    [vw ViewInit:shopArry];
//    [self.view addSubview:vw];
    
    [self showStoreClicked];
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
        [lineView removeFromSuperview];
        NSMutableArray *titleArry = [NSMutableArray new];
        NSMutableArray *incomeArry = [NSMutableArray new];
        for (linePointModel *lm in linChartArry) {
            [titleArry addObject:[lm.time stringByAppendingString:@"时"]];
            [incomeArry addObject:lm.value];
        }
        
        [self showLineChartTitleStore:titleArry IncomeStore:incomeArry];
    }
    
}

#pragma mark -获取状态
-(void)getAllShopArryNameId {
    LoginViewMode *loginViewMode = [LoginViewMode shareUserInfo];
    shopArry = [NSMutableArray new];
    
    shopShow *sw = [shopShow new];
    sw.shopname = [NSString stringWithString:loginViewMode.shop.shop_name];
    sw.shopid = [NSString stringWithString:loginViewMode.shop.shop_id];
    sw.showIs = true;
    [shopArry addObject:sw];
    
    for (int i=0; i< loginViewMode.shop.subs.count; i++) {
        ShopSubModel *shopsubModel = loginViewMode.shop.subs[i];
        sw = [shopShow new];
        sw.shopname = [NSString stringWithString:shopsubModel.shop_name];
        sw.shopid = [NSString stringWithString:shopsubModel.shop_id];
        sw.showIs = true;
        [shopArry addObject:sw];
    }
    TimeperiodNethelper *timeperiodNethelper = [TimeperiodNethelper new];
    _cashshopArry = [timeperiodNethelper strAllShopList];
}


#pragma mark - 选择店铺弹出视图
-(void)showStoreClicked{
    // showStore遮盖btn
    _coverNoTouch = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H)];
    _coverNoTouch.backgroundColor = [UIColor grayColor];
    _coverNoTouch.alpha = 0.3;
    
    [self.navigationController.view addSubview:_coverNoTouch];
    [self.showStore showStoreView];
    [self.navigationController.view addSubview:_showStore];
}

-(void)selectedButton:(UIButton *)button{
    _coverNoTouch.alpha = 0;
    [_coverNoTouch removeFromSuperview];
    [self.showStore dismissStoreView];
}

-(ShowStore *)showStore{
    NSMutableArray *shaparry = [NSMutableArray new];
    for (shopShow * sw in shopArry) { //NSMutableArray<shopShow *> *shopArry;
        [shaparry addObject:[NSString stringWithString:sw.shopname]];
    }
    if (!_showStore) {
        _showStore = [[ShowStore alloc]initWithStoreFrame:(CGRect){30,(64+5),Screen_W-60,20} items:shaparry];
        _showStore.delegate = self;
    }
    return _showStore;
}

-(void)selectedButton:(UIButton *)button mArray:(NSMutableArray *)mArray{
    NSLog(@"%@",mArray);
    _coverNoTouch.alpha = 0;
    [_coverNoTouch removeFromSuperview];
    [self.showStore dismissStoreView];
    
    if (mArray.count >0) {
        __block NSString *shoplist = @"";
        [mArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            shoplist = [shoplist stringByAppendingString:shopArry[[obj intValue]].shopid];
            if (idx !=  (mArray.count -1)) {
                shoplist = [shoplist stringByAppendingString:@","];
            }
        }];
        self.cashshopArry = shoplist;
        TimeperiodNethelper *timeperiodNethelper = [TimeperiodNethelper new];
        timeperiodNethelper.delege =self;
        [timeperiodNethelper getTimeperiodDate:shoplist];
    } else {
        NSLog(@"至少选择一个店铺");
    }

}
@end
