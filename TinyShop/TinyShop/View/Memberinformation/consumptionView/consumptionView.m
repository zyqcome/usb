//
//  consumptionView.m
//  TinyShop
//
//  Created by rimi on 16/12/31.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import "consumptionView.h"
#import "TimeperiodProtocol.h"
#import "MZOrderHeaderView.h"

@interface consumptionView ()<TimeperiodProtocol,UITableViewDelegate,UITableViewDataSource>
{
    NSArray<orderModel *> *orderArry;
    NSMutableArray *ordergoodsShowArrry;
}

@property (weak, nonatomic) IBOutlet UIView *displayView;
//@property (nonatomic, strong) UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation consumptionView

- (void)viewDidLoad {
    [super viewDidLoad];
    //数据请求
    TimeperiodNethelper *timeperiodNethelper = [TimeperiodNethelper new];
    timeperiodNethelper.delege = self;
    [timeperiodNethelper getconsumptionViewViewDate:self.vipmodel.shop_id VipId:self.vipmodel.vip_base_id];
    
    [self initTableView];
    
}

-(void)initTableView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //        //注册cell
    ////        [_tableView registerClass:[MZTypeTableViewCell class] forCellReuseIdentifier:@"MZTypeTableViewCell"];
    //注册section header
    [self.tableView registerClass:[MZOrderHeaderView class] forHeaderFooterViewReuseIdentifier:@"MZOrderHeaderView"];
    //section header 高度
    self.tableView.sectionHeaderHeight = 180;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
#pragma mark - 网络数据刷新
-(void)resetTimeperiod:(Received)sender Bl:(BOOL)bl message:(id)ms {
    __weak __typeof(self)weakSelf = self;
    NSArray *dicArry = ((NSDictionary *)ms)[@"body"];
//    if (dicArry.count ==0 ) {
//        weakSelf.vipModelArry = [NSArray new];
//        [weakSelf.tableview reloadData];
//        return;
//    } else {
        orderArry = [ReflectionClassTools DicArrygetModelsArry:dicArry Class:@"orderModel"];
    for (orderModel *orml in orderArry) {
        orml.goods = [ReflectionClassTools DicArrygetModelsArry:orml.goods Class:@"goodsModel"];
    }
    NSMutableArray *ary = [NSMutableArray new];
    for (int i=0; i<orderArry.count; i++) {
        [ary addObject:@(NO)];
    }
    ordergoodsShowArrry = ary;
    [weakSelf.tableView reloadData];
//    }
}

#pragma mark -tableviewdelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell        = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if ( cell == nil )
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor yellowColor];
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [ordergoodsShowArrry[section] boolValue] == true ? orderArry[section].goods.count : 0;
}

//-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
//    return 5;
//}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  orderArry.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 20;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//
//}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MZOrderHeaderView *orderHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MZOrderHeaderView"];
    orderHeaderView.section = section;
    //模型设置
    orderHeaderView.order_sn.text =  [NSString stringWithFormat:@"订单号：%@", orderArry[section].order_sn];
    orderHeaderView.order_person_num.text =  [NSString stringWithFormat:@"人数：%@", orderArry[section].order_person_num];
    orderHeaderView.time_length.text =  [NSString stringWithFormat:@"时长：%@", orderArry[section].time_length];
    orderHeaderView.order_goods_amount.text =  [NSString stringWithFormat:@"应收：%@", orderArry[section].order_goods_amount];
    orderHeaderView.order_order_amount.text =  [NSString stringWithFormat:@"实收：%@", orderArry[section].order_order_amount];
    orderHeaderView.order_waiter_account.text =  [NSString stringWithFormat:@"收营员：%@", orderArry[section].order_waiter_account];
    orderHeaderView.order_cash_money.text =  [NSString stringWithFormat:@"现金：%@", orderArry[section].order_cash_money];
    orderHeaderView.order_creditcard_money.text =  [NSString stringWithFormat:@"刷卡：%@", orderArry[section].order_creditcard_money];
    orderHeaderView.order_use_balance.text =  [NSString stringWithFormat:@"预存款：%@", orderArry[section].order_use_balance];
    orderHeaderView.shopdt_discount.text =  [NSString stringWithFormat:@"折扣：%@", orderArry[section].shopdt_discount];
    orderHeaderView.order_shopping_volume_fee.text =  [NSString stringWithFormat:@"代金券：%@", orderArry[section].order_shopping_volume_fee];
    
    orderHeaderView.order_stable_deskno.text =  [NSString stringWithFormat:@"桌号：%@", orderArry[section].order_stable_deskno];
    
    orderHeaderView.order_shipping_time.text =  [NSString stringWithFormat:@"结账时间：%@", orderArry[section].order_shipping_time];
    //_order_shipping_time	__NSCFString *	@"2016-04-25 21:05:33"
    
    orderHeaderView.order_day.text = [orderArry[section].order_shipping_time substringWithRange:NSMakeRange(8,2)];
    orderHeaderView.order_moth.text = [orderArry[section].order_shipping_time substringWithRange:NSMakeRange(0,7)];
    orderHeaderView.order_time.text = [NSString stringWithFormat:@"at:%@",[orderArry[section].order_shipping_time substringWithRange:NSMakeRange(11,8)]];

    __weak typeof(self) weakSelf = self;
    orderHeaderView.didSelectSection = ^(NSUInteger section_x){
#pragma make -表格头选择
        //MZOrderModel *orderModel = weakSelf.orderDatasource[section_x];
        //orderModel.sectionOpenSign = !orderModel.sectionOpenSign;
        //[weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:section_x] withRowAnimation:UITableViewRowAnimationFade];
        static NSUInteger last;
        if (last == section_x) {
            ordergoodsShowArrry[section] = @(NO);
        } else {
            ordergoodsShowArrry[section] = @(YES);
            ordergoodsShowArrry[last] = @(NO);
        }
        last = section_x;
        NSLog(@"OK");
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:section_x] withRowAnimation:UITableViewRowAnimationFade];
    };
    return orderHeaderView;
}

#pragma mark- Getter
//-(UITableView *)tableView
//{
//    if (!_tableView) {
//        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain ];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        //注册cell
////        [_tableView registerClass:[MZTypeTableViewCell class] forCellReuseIdentifier:@"MZTypeTableViewCell"];
//        //注册section header
////        [_tableView registerClass:[MZOrderHeaderView class] forHeaderFooterViewReuseIdentifier:@"MZOrderHeaderView"];
//        //section header 高度
//        _tableView.sectionHeaderHeight = 100;
//        //        _tableView.tableFooterView = [UIView new];
//        //        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    }
//    return _tableView;
//}
@end
