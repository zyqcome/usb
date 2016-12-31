//
//  MemberinformationView.m
//  TinyShop
//
//  Created by rimi on 16/12/31.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import "MemberinformationView.h"
#import "TimeperiodNethelper.h"
#import "vipModel.h"
#import "ReflectionClassTools.h"
#import "vipcell.h"
#import "consumptionView.h"
@interface MemberinformationView ()<TimeperiodProtocol,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;
@property (weak, nonatomic) IBOutlet UITextField *textSearch;
@property (weak, nonatomic) IBOutlet UIView *showTableView;
@property (nonatomic, strong) NSArray<vipModel *> *vipModelArry;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end

@implementation MemberinformationView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //表格显示设置
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    //添加导航栏
    UIBarButtonItem *one = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回按钮"] style:UIBarButtonItemStylePlain target:self action:@selector(btnBackAction)];
//    UIBarButtonItem *two = [[UIBarButtonItem alloc] initWithTitle:@"选择店铺" style:UIBarButtonItemStylePlain target:self action:@selector(btnSection)];
//    two.tintColor = [UIColor redColor];
    self.title = @"实时销售总趋势图";
    self.navigationItem.leftBarButtonItem =one;
//    self.navigationItem.rightBarButtonItem = two;
    
    //数据请求
    TimeperiodNethelper *timeperiodNethelper = [TimeperiodNethelper new];
    timeperiodNethelper.delege = self;
    [timeperiodNethelper getMemberinformationViewDate:@"157"];//157,158.311
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
#pragma mark -导航栏响应
- (void)btnBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -数据刷新代理
-(void)resetTimeperiod:(Received)sender Bl:(BOOL)bl message:(id)ms
{
    __weak __typeof(self)weakSelf = self;
    NSArray *dicArry = ((NSDictionary *)ms)[@"body"];
    if (dicArry.count ==0 ) {
        return;
    } else {
        weakSelf.vipModelArry = [ReflectionClassTools DicArrygetModelsArry:dicArry Class:@"vipModel"];
        NSLog(@"OK");
        [weakSelf.tableview reloadData];
    }
}

#pragma mark -表格代理
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"vipcell";
    vipcell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"vipcell" owner:nil options:nil].firstObject;
     }
    cell.vipname.text = self.vipModelArry[indexPath.row].vip_nickname;
    cell.viptell.text = self.vipModelArry[indexPath.row].vip_mobile;
    cell.vipmenry.text = self.vipModelArry[indexPath.row].uvgrade_recharge_all_money;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vipModelArry.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    consumptionView *svc = [consumptionView new];
    [self.navigationController pushViewController:svc animated:YES];
}

@end
