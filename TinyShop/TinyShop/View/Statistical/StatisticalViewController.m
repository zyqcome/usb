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
//店铺cell
#import "StoreTableViewCell.h"
#import "ShowStore.h"
//网络请求
#import "OperationNetrequest.h"
//折线图
#import "MZLineView.h"
#import "UIView+Addtions.h"


#import "presentView.h"

@interface StatisticalViewController ()<ShowShoreDelegate>
{
    //店铺选择
    NSMutableArray<shopShow *> *shopArry;
}
@property(nonatomic,strong)NSArray *buttonImageArray; //未选中按钮图片
@property(nonatomic,strong)NSArray *buttonSelImageArray;//选中的按钮图片
@property(nonatomic,strong)NSMutableArray *buttonMutableAry;//存放按钮
@property(nonatomic,strong)UIView *backgroundView; //毛玻璃
@property(nonatomic,strong)NSMutableArray *storeMtbArray; //保存店铺cell的label
@property(nonatomic,strong)NSArray *dateImageArray; //日期图片(前四未选中，后四选中 )
@property (nonatomic,strong)  ShowStore * showStore;
@property (nonatomic,strong)  UIView * coverStore;

//下拉菜单三个属性
@property (strong, nonatomic)  SQMenuShowView *showView;
@property (nonatomic,strong)  UIButton * coverBtn;
@property (nonatomic,assign)  BOOL  isShow;

@property(nonatomic,strong)MZLineView *lineView;//折线图
@property(nonatomic,strong)NSMutableArray *timeMutableArray;//保存底部时间

@property(nonatomic,strong)NSString *brefixStr; //前缀
@property(nonatomic,strong)NSString *sumValueStr;  //统计label文字
@property(nonatomic,strong)NSString *unitStr; //单位
//addLineViewbrefixStr:@"收入" sumValue:@"实时总收入" unit:@"元"

@end

@implementation StatisticalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    
    //更多下拉按钮
    [self addPopView];
    //******网络请求
    self.brefixStr = @"收入";
    self.sumValueStr = @"实时总收入";
    self.unitStr = @"元";
    [self loadDatatype:@"sales" queryTime:@"day"];
    
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
    
    self.lineView.selectCallback = ^(NSUInteger index){
        NSLog(@"选中第%@个",@(index));
    };
    [self.lineView storkePath];
    
}
-(void)loadDatatype:(NSString *)type queryTime:(NSString *)queryTime{
    OperationNetrequest *operation = [OperationNetrequest new];
    [operation getAllOperationtype:type queryTime:queryTime];
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
//5个按钮
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
    switch (button.tag) {
        case 1000:
            self.brefixStr = @"收入";
            self.sumValueStr = @"实时总收入";
            self.unitStr = @"元";
            [self loadDatatype:@"sales" queryTime:@"day"];
            break;
        case 1001:
            self.brefixStr = @"桌数";
            self.sumValueStr = @"总桌数";
            self.unitStr = @"桌";
            [self loadDatatype:@"order_num" queryTime:@"day"];
            break;
        case 1002:
            self.brefixStr = @"人数";
            self.sumValueStr = @"总人数";
            self.unitStr = @"人";
            [self loadDatatype:@"people_num" queryTime:@"day"];
            break;
        case 1003:
            self.brefixStr = @"人均";
            self.sumValueStr = @"总人均";
            self.unitStr = @"元";
            [self loadDatatype:@"people_avg" queryTime:@"day"];
            break;
        default:
            self.brefixStr = @"餐时";
            self.sumValueStr = @"总餐时";
            self.unitStr = @"时";
            [self loadDatatype:@"avg_meal" queryTime:@"day"];
            break;
    }
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
            case 0:
                [self setView];
                break;
            default:
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
    [self.view addSubview:self.backgroundView];
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
        [checkButton setImage:[UIImage imageNamed:self.dateImageArray[index]] forState:UIControlStateNormal];
            checkButton.tag = 2000+index;
        }
        [checkButton addTarget:self action:@selector(queryClicked:) forControlEvents:UIControlEventTouchUpInside];
    }

}
//选择日期按钮点击事件
-(void)queryClicked:(UIButton *)btn{
    
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
    
    [self.navigationController.view addSubview:_coverStore];
    [self.showStore showStoreView];
    [self.navigationController.view addSubview:_showStore];
}

-(void)selectedButton:(UIButton *)button{
    _coverStore.alpha = 0;
    [_coverStore removeFromSuperview];
    [self.showStore dismissStoreView];
}

-(ShowStore *)showStore{
    NSMutableArray *shaparry = [NSMutableArray new];
    for (shopShow * sw in shopArry) { //NSMutableArray<shopShow *> *shopArry;
        [shaparry addObject:[NSString stringWithString:sw.shopname]];
    }
    if (!_showStore) {
        _showStore = [[ShowStore alloc]initWithStoreFrame:(CGRect){30,(64+5),Screen_W-60,20} items:@[@"qweewq",@"qweasd"]];//shaparry];
        _showStore.delegate = self;
    }
    return _showStore;
}

-(void)selectedSwitch:(UISwitch *)redSwitch{
    //    switch (redSwitch.tag) {
    //        case 0:
    //            NSLog(@"哈哈哈");
    //            break;
    //        case 1:
    //            NSLog(@"哈哈");
    //            break;
    //        case 2:
    //            NSLog(@"哈哈hahahah哈");
    //            break;
    //
    //        default:
    //            NSLog(@"1111hahahahha");
    //            break;
    //    }
    NSLog(@"%@",@(redSwitch.tag));
    if (redSwitch.isOn == true) {
        shopArry[redSwitch.tag].showIs = true;
        NSLog(@"打开");
    } else {
        shopArry[redSwitch.tag].showIs = true;
        NSLog(@"关闭");
    }
    
    
}

//x点击事件
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
    if (!_storeMtbArray) {
        _storeMtbArray = [NSMutableArray new];
    }
    return _storeMtbArray;
}

-(NSArray *)dateImageArray{
    if (!_dateImageArray) {
        _dateImageArray = @[@"按年-未选",@"按月-未选",@"按周-未选",@"按日-未选",@"按年-选中",@"按月-选中",@"按周-选中",@"按日-选中"];
    }
    return _dateImageArray;
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
