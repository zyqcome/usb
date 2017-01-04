//
//  consumptionView.m
//  TinyShop
//
//  Created by rimi on 16/12/31.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import "consumptionView.h"
#import "TimeperiodProtocol.h"
//#import "MZOrderHeaderView.h"
// #import "MZTypeTableViewCell.h"
//#import "MZOrderModel.h"
@interface consumptionView ()<TimeperiodProtocol>
{
    NSArray<orderModel *> *orderArry;
}
@property (weak, nonatomic) IBOutlet UIView *displayView;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation consumptionView

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"ok");
    //数据请求
    TimeperiodNethelper *timeperiodNethelper = [TimeperiodNethelper new];
    timeperiodNethelper.delege = self;
    [timeperiodNethelper getconsumptionViewViewDate:self.vipmodel.shop_id VipId:self.vipmodel.vip_base_id];
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
        NSLog(@"OK");
//        [weakSelf.tableview reloadData];
//    }
}

#pragma mark -tableviewdelegate

#pragma mark- Getter
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain ];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //注册cell
//        [_tableView registerClass:[MZTypeTableViewCell class] forCellReuseIdentifier:@"MZTypeTableViewCell"];
        //注册section header
//        [_tableView registerClass:[MZOrderHeaderView class] forHeaderFooterViewReuseIdentifier:@"MZOrderHeaderView"];
        //section header 高度
        _tableView.sectionHeaderHeight = 100;
        //        _tableView.tableFooterView = [UIView new];
        //        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
@end
