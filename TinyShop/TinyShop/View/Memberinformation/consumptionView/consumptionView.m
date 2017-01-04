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

//#import "consumptionModel.h"
#import "A.h"

//#import "MZGoodTableViewCell.h"
#import "MZTypeTableViewCell.h"
@interface consumptionView ()<TimeperiodProtocol,UITableViewDelegate,UITableViewDataSource>
{
    NSArray<orderModel *> *orderArry;
    NSMutableArray *ordergoodsShowArrry;
    NSArray<A *> *consumptionArry;
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
    
    //注册cell
    [_tableView registerClass:[MZGoodTableViewCell class] forCellReuseIdentifier:@"MZGoodTableViewCell"];
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
    
    
    //折叠菜单配置
    //缓存
    NSMutableArray<A *> *mulconarry = [NSMutableArray  new];
    A *a = [A new];
    for (orderModel *or in orderArry) {
        NSMutableArray<AA *> *mulcongoodsml = [NSMutableArray new];
        for (goodsModel *gd in or.goods) {
            //遍历菜品
            //如果 菜品缓存为空
            if (mulcongoodsml.count == 0) {
                //第一个菜品 gd 声明 添加到 mulcongoodsml 中
                goodsModel *newgd = [goodsModel new];
                newgd = gd;
                AA *aa = [AA new];
                aa.kindName = newgd.kindName;
                aa.goods = [NSMutableArray new];
                [aa.goods addObject:newgd];//收录
                [mulcongoodsml addObject:aa];
            } else {
                //缓存不为空，先查找没有相同的类型
                BOOL yese = false;
                /**
                for (AA *aaa in mulcongoodsml) {
                    if ([aaa.kindName isEqualToString:gd.kindName] == true) {
                        goodsModel *newgd = [goodsModel new];
                        newgd = gd;
                        [aaa.goods addObject:newgd];
                        yese = true;
                    }
                }
                 */
                for (int i =0; i<mulcongoodsml.count; i++) {
                    AA *aaa = mulcongoodsml[i];
                    if ([aaa.kindName isEqualToString:gd.kindName] == true) {
                        goodsModel *newgd = [goodsModel new];
                        newgd = gd;
                        [aaa.goods addObject:newgd];
                        yese = true;
                    }
                }
                if (yese == false) {
                    //没有相同的类型再次新建
                    goodsModel *newgd = [goodsModel new];
                    newgd = gd;
                    AA *aa = [AA new];
                    aa.kindName = newgd.kindName;
                    aa.goods = [NSMutableArray new];
                    [aa.goods addObject:newgd];//收录
                    [mulcongoodsml addObject:aa];
                }
            }
            
        }
        //[. addObject:mulcongoodsml];
        a.goods = mulcongoodsml;
        [mulconarry addObject:a];
    }
    consumptionArry = mulconarry;
    
    [weakSelf.tableView reloadData];
//    }
}

#pragma mark -tableviewdelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    MZTypeTableViewCell *cell        = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if ( cell == nil )
    {
        cell = [[MZTypeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor yellowColor];
    }
    //cell.typeModelAA = consumptionArry[indexPath.section].goods[indexPath.row];
    [cell setTypeModel:consumptionArry[indexPath.section].goods[indexPath.row]];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [ordergoodsShowArrry[section] boolValue] == true ?  1 : 0;
}

//-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
//    return 5;
//}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  orderArry.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    float height=0;
    A *a = consumptionArry[indexPath.section];
    for (AA *aa in a.goods) {
        height = height + aa.goods.count * CELLHIGHT;
    }
    return height;
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
        if ([ordergoodsShowArrry[section] boolValue] == true) {
            ordergoodsShowArrry[section] = @(NO);
        } else {
            ordergoodsShowArrry[section] = @(YES);
        }
        NSLog(@"OK");
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:section_x] withRowAnimation:UITableViewRowAnimationFade];
    };
    return orderHeaderView;
}

#pragma mark- Getter
@end
