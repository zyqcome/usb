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
#import "SQMenuShowView.h"
#import "StoreTableViewCell.h"
#import "ShowStore.h"
#import "presentView.h"
@interface MemberinformationView ()<TimeperiodProtocol,UITableViewDelegate,UITableViewDataSource>
{
    //店铺选择
    NSMutableArray<shopShow *> *shopArry;
}
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;
@property (weak, nonatomic) IBOutlet UITextField *textSearch;
@property (weak, nonatomic) IBOutlet UIView *showTableView;
@property (nonatomic, strong) NSArray<vipModel *> *vipModelArry;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

//下拉菜单三个属性
@property (strong, nonatomic)  SQMenuShowView *showView;
@property (nonatomic,strong)  UIButton * coverBtn;
@property (nonatomic,assign)  BOOL  isShow;
@property (nonatomic,strong)  ShowStore * showStore;
@property (nonatomic,strong)  UIView * coverStore;

@property (nonatomic,strong)  NSString *cashshopArry;
@end

@implementation MemberinformationView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //表格显示设置
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.tableFooterView = [[UITableView alloc] initWithFrame:CGRectZero];
    //添加导航栏
    UIBarButtonItem *one = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回按钮"] style:UIBarButtonItemStylePlain target:self action:@selector(btnBackAction)];
//    UIBarButtonItem *two = [[UIBarButtonItem alloc] initWithTitle:@"选择店铺" style:UIBarButtonItemStylePlain target:self action:@selector(btnSection)];
//    two.tintColor = [UIColor redColor];
    self.title = @"实时销售总趋势图";
    self.navigationItem.leftBarButtonItem =one;
//    self.navigationItem.rightBarButtonItem = two;
    
    //返回所有店铺名称id
    [self getAllShopArryNameId];
    
    //数据请求
    TimeperiodNethelper *timeperiodNethelper = [TimeperiodNethelper new];
    timeperiodNethelper.delege = self;
    [timeperiodNethelper getMemberinformationViewDate:shopArry[0].shopid];//157,158.311
    

    
    //弹出菜单
    [self addPopView];
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
        weakSelf.vipModelArry = [NSArray new];
        [weakSelf.tableview reloadData];
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

#pragma mark -弹出选择店铺窗口
//右边”更多“下拉菜单
-(void)addPopView{
    //更多
    UIBarButtonItem *moreBtn = [[UIBarButtonItem alloc]initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClicked)];
    
    self.navigationItem.rightBarButtonItem = moreBtn;
    __weak typeof(self) weakSelf = self;
    [self.showView selectBlock:^(SQMenuShowView *view, NSInteger index) {
        [self dismissViewClicked];
        TimeperiodNethelper *timeperiodNethelper = [TimeperiodNethelper new];
        timeperiodNethelper.delege = weakSelf;
        [timeperiodNethelper getMemberinformationViewDate:shopArry[index].shopid];
    }];
    
    // 初始化遮盖btn
    _coverBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H)];
    _coverBtn.backgroundColor = [UIColor grayColor];
    _coverBtn.alpha = 0;
    // 添加点击事件
    [_coverBtn addTarget:self action:@selector(dismissViewClicked) forControlEvents:UIControlEventTouchUpInside];
}

-(void)rightButtonClicked{
    _isShow = !_isShow;
    if (_isShow) {
        _coverBtn.alpha = 0.3;
        [self.view addSubview:_coverBtn];
        [self.showView showView];
        [self.view addSubview:_showView];
    }else{
        _coverBtn.alpha = 0;
        [_coverBtn removeFromSuperview];
        [self.showView dismissView];
    }
    
}
-(void)dismissViewClicked{
    _isShow = !_isShow;
    _coverBtn.alpha = 0;
    [_coverBtn removeFromSuperview];
    [self.showView dismissView];
}

//选择店铺view
-(void)setView{
    
    [self showStoreClicked];
    
}
#pragma mark - 选择店铺弹出视图
-(void)showStoreClicked{
    // showStore遮盖btn
    _coverStore = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H)];
    _coverStore.backgroundColor = [UIColor grayColor];
    _coverStore.alpha = 0.3;
    
//    [self.navigationController.view addSubview:_coverStore];
//    [self.showStore showStoreView];
//    [self.navigationController.view addSubview:_showStore];
}

#pragma mark -懒加载
//-(ShowStore *)showStore{
//    NSMutableArray *shaparry = [NSMutableArray new];
//    for (shopShow * sw in shopArry) { //NSMutableArray<shopShow *> *shopArry;
//        [shaparry addObject:[NSString stringWithString:sw.shopname]];
//    }
//    if (!_showStore) {
//        _showStore = [[ShowStore alloc]initWithStoreFrame:(CGRect){30,(64+5),Screen_W-60,20} items:@[@"qweewq",@"qweasd"]];//shaparry];
//        _showStore.delegate = self;
//    }
//    return _showStore;
//}
#pragma mark - 弹出视图懒加载
- (SQMenuShowView *)showView{
    if (!_showView) {
        NSMutableArray *shaparry = [NSMutableArray new];
        for (shopShow * sw in shopArry) {
            [shaparry addObject:[NSString stringWithString:sw.shopname]];
        }
        _showView = [[SQMenuShowView alloc]initWithFrame:(CGRect){
            Screen_W-(250*ScreenScale),
            (64+5),
            240*ScreenScale,
            0} items:shaparry showPoint:(CGPoint){Screen_W-25,10}];
        _showView.sq_backGroundColor = [UIColor whiteColor];
        _showView.itemTextColor = [UIColor grayColor];
    }
    return _showView;
}

#pragma mark -获取所有店铺
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

@end
