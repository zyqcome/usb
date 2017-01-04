//
//  StatisticalViewController.m
//  TinyShop
//
//  Created by 王灿 on 2016/12/22.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import "StatisticalViewController.h"
//模型
#import "OperatingModel.h"
//下拉菜单
#import "SQMenuShowView.h"
#import "presentView.h"
//店铺cell
#import "StoreTableViewCell.h"
#import "ShowStore.h"
//网络请求
#import "OperationNetrequest.h"
//折线图
#import "MZLineView.h"
#import "UIView+Addtions.h"

//饼状图界面
#import "SecondPieChartViewController.h"
//自定义pickerView
#import "CustomPickerView.h"
//登录后获得的数据模型
#import "LoginViewMode.h"


@interface StatisticalViewController ()<ShowShoreDelegate>
{
    //店铺选择
    NSMutableArray<shopShow *> *shopArry;
}
@property(nonatomic,strong)NSArray *buttonImageArray; //未选中按钮图片
@property(nonatomic,strong)NSArray *buttonSelImageArray;//选中的按钮图片
@property(nonatomic,strong)NSMutableArray *buttonMutableAry;//存放按钮
@property(nonatomic,strong)UIView *backgroundView; //毛玻璃
@property(nonatomic,strong)NSMutableArray *storeLabelMtbArray; //保存店铺cell的label
@property(nonatomic,strong)NSArray *dateImageArray; //日期图片(前四未选中，后四选中 )


//下拉菜单属性
@property (nonatomic,strong)  ShowStore * showStore;
@property (strong, nonatomic)  SQMenuShowView *showView;
@property (nonatomic,strong)  UIButton * coverBtn;
@property (nonatomic,strong)  UIView * coverNoTouch;
@property (nonatomic,assign)  BOOL  isShow;

@property(nonatomic,strong)MZLineView *lineView;//折线图
@property(nonatomic,strong)NSMutableArray *timeMutableArray;//保存底部时间

@property(nonatomic,strong)NSString *brefixStr; //前缀
@property(nonatomic,strong)NSString *sumValueStr;  //统计label文字
@property(nonatomic,strong)NSString *unitStr; //单位

@property(nonatomic, strong)CustomPickerView *datePickerView; //自定义时间拾取器
@property(nonatomic,strong)NSMutableArray *storeMtbAry; //店铺数组
@property(nonatomic,strong)NSMutableArray *selectStoreMtbAry; //存放所有的店铺id
@property(nonatomic, strong)NSMutableArray *selectStoreIDMtbAry; //存放选择的店铺ID

@end

@implementation StatisticalViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    //
    //更多下拉按钮
    [self addPopView];
    
    //网络请求参数格式，时间默认设置为天  店铺默认设置为所有店铺  统计默认为销售额  开始时间设置为当前时间  结束时间设置为当前时间前十天(天)
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"day" forKey:@"queryTime"];
    [ud setObject:self.selectStoreMtbAry forKey:@"storeID"];
    [ud setObject:@"sales" forKey:@"type"];
    //获取当前时间
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [formatter stringFromDate:[NSDate date]];
    NSLog(@"%@",date);
    [ud setObject:date forKey:@"end_time"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:[NSDate new]];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:0];
    
    [adcomps setDay:-10];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:[NSDate new] options:0];
    NSString *beforDate = [formatter stringFromDate:newdate];
    [ud setObject:beforDate forKey:@"start_time"];
    NSLog(@"---前两个月 =%@",beforDate);
    
    //******网络请求
    self.brefixStr = @"收入";
    self.sumValueStr = @"实时总收入";
    self.unitStr = @"元";
    [self loadDatatype:[ud objectForKey:@"type"] queryTime:[ud objectForKey:@"queryTime"] storeIDMtbAry:[ud objectForKey:@"storeID"]];
    
    
}
//折线图
-(void)addLineViewbrefixStr:(NSString *)beforeStr sumValue:(NSString *)RTSumValue unit:(NSString *)unit titleStore:(NSArray *)modelStore incomeStore:(NSArray *)modelIncome{
    
    self.lineView = [[MZLineView alloc]initWithFrame:CGRectMake(0, 145, self.view.width,self.view.height-144)];
    [self.view addSubview:self.lineView];
    //倾斜度
    CGAffineTransform transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 15, 40);
    transform = CGAffineTransformRotate(transform, M_PI*0.31);
    self.lineView.labelTransform = transform;
    self.lineView.bottomMargin = 65;
    self.lineView.incomeBottomMargin = 30;
    //收入数据
    self.lineView.titleStore = modelStore;
    
    self.lineView.brefixStr = beforeStr;
    //    lineView.suffixStr = @"后缀";
    //底部时间
    self.lineView.incomeStore = modelIncome;
    
    self.lineView.topTitleCallBack = ^NSString *(CGFloat sumValue){
        NSString *str = [RTSumValue stringByAppendingFormat:@"：%@",@(sumValue)];
        NSLog(@"%@",str);
        return [str stringByAppendingString:unit];
    };
    __weak typeof(self) weakSelf = self;
    self.lineView.selectCallback = ^(NSUInteger index){
        NSLog(@"选中第%@个",@(index));
        SecondPieChartViewController *svc = [SecondPieChartViewController new];
        [weakSelf.navigationController pushViewController:svc animated:YES];
    };
    [self.lineView storkePath];
    
}
-(void)loadDatatype:(NSString *)type queryTime:(NSString *)queryTime storeIDMtbAry:(NSMutableArray *)storeMtbAry{
    OperationNetrequest *operation = [OperationNetrequest new];
    [operation getAllOperationtype:type queryTime:queryTime storeIDMtbAry:storeMtbAry];
    //数据请求成功之后用代码块回调
    operation.networkBlock = ^(BOOL a,NSArray *dateAry,NSArray *detailAry){
        if (a) {
            [self addLineViewbrefixStr:self.brefixStr sumValue:self.sumValueStr unit:self.unitStr titleStore:dateAry incomeStore:detailAry];
        }
    };
    
}


-(void)setUI{
    //背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    //五个按钮
    for (NSInteger index = 0; index < 5; index++) {
        //第一个按钮默认选中
        if (index == 0) { 
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 70, Screen_W/5, 80)];
            btn.tag = 1000;
            [btn setImage:[UIImage imageNamed:self.buttonSelImageArray[0]] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(statisticalClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.buttonMutableAry addObject:btn];
            [self.view addSubview:btn];
        }else{
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(Screen_W/5*index, 70, Screen_W/5, 80)];
        btn.tag = 1000+index;
        [btn setImage:[UIImage imageNamed:self.buttonImageArray[index]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(statisticalClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonMutableAry addObject:btn];
        [self.view addSubview:btn];
        }
    }
    //横线
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(150);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(Screen_W, 1));
    }];
    
}
//5个按钮点击事件
-(void)statisticalClicked:(UIButton *)button{
    //先将所有按钮的图片设置为未选中
    NSInteger index = 0;
    for (UIButton *btn in self.buttonMutableAry) {
        [btn setImage:[UIImage imageNamed:self.buttonImageArray[index%5]] forState:UIControlStateNormal];
        index++;
    }
    //再将点击的按钮图片替换为选中
    [button setImage:[UIImage imageNamed:self.buttonSelImageArray[button.tag-1000]] forState:UIControlStateNormal];
    //点击事件，刷新数据
    //先刷新数据，获取到数据之后再赋值
    //先移除折线图，再绘制
    [self.lineView removeFromSuperview];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    switch (button.tag) {
        case 1000:
            self.brefixStr = @"收入";
            self.sumValueStr = @"实时总收入";
            self.unitStr = @"元";
            [ud setObject:@"sales" forKey:@"type"];
            break;
        case 1001:
            self.brefixStr = @"桌数";
            self.sumValueStr = @"总桌数";
            self.unitStr = @"桌";
            [ud setObject:@"order_num" forKey:@"type"];
            break;
        case 1002:
            self.brefixStr = @"人数";
            self.sumValueStr = @"总人数";
            self.unitStr = @"人";
            [ud setObject:@"people_num" forKey:@"type"];
            break;
        case 1003:
            self.brefixStr = @"人均";
            self.sumValueStr = @"总人均";
            self.unitStr = @"元";
            [ud setObject:@"people_avg" forKey:@"type"];
            break;
        default:
            self.brefixStr = @"餐时";
            self.sumValueStr = @"总餐时";
            self.unitStr = @"时";
            [ud setObject:@"avg_meal" forKey:@"type"];
            break;
    }
    [self loadDatatype:[ud objectForKey:@"type"] queryTime:[ud objectForKey:@"queryTime"] storeIDMtbAry:[ud objectForKey:@"storeID"]];
}
//右边”更多“下拉菜单
-(void)addPopView{
    //更多
    UIBarButtonItem *moreBtn = [[UIBarButtonItem alloc]initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClicked)];
    
    self.navigationItem.rightBarButtonItem = moreBtn;
    //    __weak typeof(self) weakSelf = self;
    [self.showView selectBlock:^(SQMenuShowView *view, NSInteger index) {
        [self dismissViewClicked];
        
        switch (index) {
            case 0://加载店铺
                [self showStoreClicked];
                break;
            default://选择时间
                [self choiseTimeView];
                break;
        }
        
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

//选择时间view
-(void)choiseTimeView{
    //毛玻璃效果
    self.backgroundView = [UIView new];
    self.backgroundView.backgroundColor = Color_RGBA(42, 42, 55, 0.4);
    [self.navigationController.view addSubview:self.backgroundView];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(Screen_W, Screen_H));
    }];
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    [self.backgroundView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(90);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.bottom.equalTo(self.view.mas_bottom).offset(-5);
    }];
    //x按钮
    UIButton *removeBtn = [[UIButton alloc]init];
    [removeBtn setImage:[UIImage imageNamed:@"显示密码图标"] forState:UIControlStateNormal];
    removeBtn.backgroundColor = [UIColor yellowColor];
    [removeBtn setTintColor:[UIColor redColor]];
    [removeBtn addTarget:self action:@selector(removeClicked) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:removeBtn];
    [removeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_top).offset(3);
        make.right.equalTo(view.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    //选择查询方式
    UILabel *label = [UILabel new];
    label.text = @"选择查询方式";
    label.textColor = [UIColor redColor];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(50);
        make.top.equalTo(view.mas_top).offset(100);
        make.size.mas_equalTo(CGSizeMake(200, 40));
    }];
    //四个查询按钮
    for (NSInteger index = 0; index < 4; index++) {
        UIButton *checkButton = [UIButton new];
        if (index == 3) {
            [checkButton setImage:[UIImage imageNamed:self.dateImageArray[7]] forState:UIControlStateNormal];
            checkButton.tag = 2003;
        }else{
//            checkButton.frame = CGRectMake(80+Screen_W/6*index, 100, Screen_W/5+10, 80);
        [checkButton setImage:[UIImage imageNamed:self.dateImageArray[index]] forState:UIControlStateNormal];
            checkButton.tag = 2000+index;
        }
        [view addSubview:checkButton];
        [checkButton addTarget:self action:@selector(queryClicked:) forControlEvents:UIControlEventTouchUpInside];
    }

}
//选择日期按钮点击事件    哦
-(void)queryClicked:(UIButton *)btn{
    //先移除，再创建一个新的
    [self.datePickerView removeFromSuperview];
    self.datePickerView = [CustomPickerView new];
    [self.backgroundView addSubview:self.datePickerView];
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

-(ShowStore *)showStore{
    //将网络请求下来的店铺添加到选择店铺上
    LoginViewMode *loginMode = [LoginViewMode shareUserInfo];
    [self.storeMtbAry addObject:loginMode.shop.shop_name];
    for (NSInteger index = 0; index < loginMode.shop.subs.count; index++) {
        ShopSubModel *spml = loginMode.shop.subs[index];
        [self.storeMtbAry addObject:spml.shop_name];
    }
    NSMutableArray *shaparry = [NSMutableArray new];
    for (shopShow * sw in shopArry) { //NSMutableArray<shopShow *> *shopArry;
        [shaparry addObject:[NSString stringWithString:sw.shopname]];
    }
    if (!_showStore) {
        _showStore = [[ShowStore alloc]initWithStoreFrame:(CGRect){30,(64+5),Screen_W-60,20} items:self.storeMtbAry];//shaparry];
        _showStore.delegate = self;
    }
    return _showStore;
}
//选择店铺x按钮
-(void)selectedButton:(UIButton *)button mArray:(NSMutableArray *)mArray{
    
    if (button.tag != 0) {
        //先将折线图移除
        [self.lineView removeFromSuperview];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        //点击的是确定按钮   先将选择的店铺数组置空
        self.selectStoreIDMtbAry = nil;
        
        for (NSInteger index = 0; index < mArray.count; index++) {
            NSInteger number = [mArray[index] intValue];
            [self.selectStoreIDMtbAry addObject:self.selectStoreMtbAry[number]];
        }
//        NSLog(@"选中店铺的ID%@",self.selectStoreIDMtbAry);
        [ud setObject:self.selectStoreIDMtbAry forKey:@"storeID"];
        if (mArray.count > 0) {
            //选择的店铺数，大于1 重新请求网络数据
            [self loadDatatype:[ud objectForKey:@"type"] queryTime:[ud objectForKey:@"queryTime"] storeIDMtbAry:[ud objectForKey:@"storeID"]];
        }
    }
    _coverNoTouch.alpha = 0;
    [_coverNoTouch removeFromSuperview];
    [self.showStore dismissStoreView];
}

//选择时间x点击事件
-(void)removeClicked{
    [self.backgroundView removeFromSuperview];
}
//收到内存警告、执行的方法
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    // ------释放一些可再生资源
    //判断是否加载过
    //当view已经加载并且没有在屏幕上显示
    if (self.isViewLoaded && self.view.window == nil) {
        //释放一些可再生资源
        
    }
}
#pragma 懒加载
-(NSArray *)buttonImageArray{
    if (!_buttonImageArray) {
        _buttonImageArray = @[@"销售额-未选",@"桌数-未选",@"人数-未选",@"人均-未选",@"餐时-未选"];
    }
    return _buttonImageArray;
}
-(NSArray *)buttonSelImageArray{
    if (!_buttonSelImageArray) {
        _buttonSelImageArray = @[@"销售额-选中",@"桌数-选中-",@"人数-选中-",@"人均-选中",@"餐时-选中"];
    }
    return _buttonSelImageArray;
}
-(NSMutableArray *)buttonMutableAry{
    if (!_buttonMutableAry) {
        _buttonMutableAry = [NSMutableArray new];
    }
    return _buttonMutableAry;
}
-(NSMutableArray *)storeMtbArray{
    if (!_storeLabelMtbArray) {
        _storeLabelMtbArray = [NSMutableArray new];
    }
    return _storeLabelMtbArray;
}

-(NSArray *)dateImageArray{
    if (!_dateImageArray) {
        _dateImageArray = @[@"按年-未选",@"按月-未选",@"按周-未选",@"按日-未选",@"按年-选中",@"按月-选中",@"按周-选中",@"按日-选中"];
    }
    return _dateImageArray;
}
-(NSMutableArray *)storeMtbAry{
    if (!_storeMtbAry) {
        _storeMtbAry = [NSMutableArray new];
    }
    return _storeMtbAry;
}
-(NSMutableArray *)selectStoreMtbAry{
    if (!_selectStoreMtbAry) {
        _selectStoreMtbAry = [NSMutableArray new];
        //将网络请求到的数据添加进数组
        LoginViewMode *loginViewMode = [LoginViewMode shareUserInfo];
        //获取总店ID
        NSString *mutStr = loginViewMode.shop.shop_id;
        [self.selectStoreMtbAry addObject:mutStr];
        for (int i=0; i< loginViewMode.shop.subs.count; i++) {
            ShopSubModel *shopsubModel = loginViewMode.shop.subs[i];
            mutStr = shopsubModel.shop_id;
            [self.selectStoreMtbAry addObject:mutStr];
        }
    }
    return _selectStoreMtbAry;
}
-(NSMutableArray *)selectStoreIDMtbAry{
    if (!_selectStoreIDMtbAry) {
        _selectStoreIDMtbAry = [NSMutableArray new];
    }
    return _selectStoreIDMtbAry;
}
#pragma mark - 弹出视图懒加载
- (SQMenuShowView *)showView{
    if (!_showView) {
        _showView = [[SQMenuShowView alloc]initWithFrame:(CGRect){Screen_W-(130*ScreenScale),(64+5),120*ScreenScale,0} items:@[@"选择店铺",@"选择日期"] showPoint:(CGPoint){Screen_W-25,10}];
        _showView.sq_backGroundColor = [UIColor whiteColor];
        _showView.itemTextColor = [UIColor grayColor];
    }
    return _showView;
}

@end
