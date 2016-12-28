//
//  StatisticalViewController.m
//  TinyShop
//
//  Created by 王灿 on 2016/12/22.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import "StatisticalViewController.h"
//下拉菜单
#import "PopupView.h"
#import "PopupViewCell.h"
//店铺cell
#import "StoreTableViewCell.h"
//网络请求
#import "OperationNetrequest.h"

@interface StatisticalViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *buttonImageArray; //未选中按钮图片
@property(nonatomic,strong)NSArray *buttonSelImageArray;//选中的按钮图片
@property(nonatomic,strong)NSMutableArray *buttonMutableAry;//存放按钮
@property(nonatomic,strong)UILabel *label;   //统计文字的label
@property(nonatomic,strong)UIView *backgroundView; //毛玻璃
@property(nonatomic,strong)UITableView *storeTableview; //店铺tableview
@property(nonatomic,strong)NSMutableArray *storeMtbArray; //保存店铺cell的label
@property(nonatomic,strong)NSMutableArray *allSwitchArray; //保存cell的switch
@property(nonatomic,strong)UIButton *selectBtn; //全选按钮
@property(nonatomic,strong)NSArray *dateImageArray; //日期图片(前四未选中，后四选中 )
@property(nonatomic,strong)NSMutableArray *checkBtnArray; //保存查询方式的四个按钮
@property(nonatomic,assign)NSInteger number;  //统计全选按钮
@property(nonatomic,strong)UIDatePicker *datePicker;  //时间拾取器

@end

@implementation StatisticalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self loadData];
    
    //测试网络请求
    OperationNetrequest *operation = [OperationNetrequest new];
    [operation getAllOperation];
    
}
-(void)loadData{
    
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
    //两根横线
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(150);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(Screen_W, 1));
    }];
    UIView *lineView2 = [UIView new];
    lineView2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(33);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(Screen_W, 1));
    }];
    //统计Label
    _label = [UILabel new];
    _label.text = @"总金额： 元";
//    _label.backgroundColor = [UIColor blackColor];
    _label.textColor = [UIColor redColor];
    [self.view addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(3);
        make.left.equalTo(self.view.mas_left).offset(3);
        make.size.mas_equalTo(CGSizeMake(200, 30));
    }];
    //更多
    UIBarButtonItem *moreBtn = [[UIBarButtonItem alloc]initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(rightClicked)];
    
    self.navigationItem.rightBarButtonItem = moreBtn;
    
}
//五个按钮的点击事件
-(void)statisticalClicked:(UIButton *)button{
    //先将所有按钮的图片设置为未选中
    NSInteger index = 0;
    for (UIButton *btn in self.buttonMutableAry) {
        [btn setImage:[UIImage imageNamed:self.buttonImageArray[index%5]] forState:UIControlStateNormal];
        index++;
    }
    //再将点击的按钮图片替换为选中
    [button setImage:[UIImage imageNamed:self.buttonSelImageArray[button.tag-1000]] forState:UIControlStateNormal];
    //刷新数据
    //先刷新数据，获取到数据之后再赋值
    switch (button.tag) {
        case 1000:
            self.label.text = [NSString stringWithFormat:@"总销售额：元"];
            break;
        case 1001:
            self.label.text = [NSString stringWithFormat:@"总桌数：桌"];
            break;
        case 1002:
            self.label.text = [NSString stringWithFormat:@"总人数：人"];
            break;
        case 1003:
            self.label.text = [NSString stringWithFormat:@"总人均：元"];
            break;
        default:
            self.label.text = [NSString stringWithFormat:@"总餐时：时"];
            break;
    }
}

//右边按钮下拉菜单
-(void)rightClicked
{
    [PopupView addCellWithIcon:[UIImage imageNamed:@"点"] text:@"选择店铺" action:^{
        [self setView];
    }];
    [PopupView addCellWithIcon:[UIImage imageNamed:@"点"] text:@"选择时间" action:^{
        [self choiseTimeView];
    }];
    [PopupView popupView];
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
    //线条
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(removeBtn.mas_bottom).offset(10);
        make.centerX.equalTo(view);
        make.size.mas_equalTo(CGSizeMake(Screen_W-20, 2));
    }];
    //选择查询方式
    UILabel *label = [UILabel new];
    label.text = @"选择查询方式";
    label.textColor = [UIColor redColor];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(50);
        make.top.equalTo(lineView.mas_top).offset(20);
        make.size.mas_equalTo(CGSizeMake(200, 40));
    }];
    //四个查询按钮
    for (NSInteger index = 0; index < 4; index++) {
        UIButton *checkButton = [UIButton new];
        if (index == 3) {
            //默认第一个选中
            [checkButton setImage:[UIImage imageNamed:self.dateImageArray[7]] forState:UIControlStateNormal];
            checkButton.tag = 2003;
            [view addSubview:checkButton];
            [checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(view.mas_left).offset(Screen_W/10+(Screen_W/5)*index);
                make.top.equalTo(label.mas_bottom).offset(5);
                make.size.mas_equalTo(CGSizeMake(Screen_W/5-5, 80));
            }];
            [self.checkBtnArray addObject:checkButton];
        }else{
        [checkButton setImage:[UIImage imageNamed:self.dateImageArray[index]] forState:UIControlStateNormal];
            checkButton.tag = 2000+index;
            [view addSubview:checkButton];
            [checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(view.mas_left).offset(Screen_W/10+(Screen_W/5)*index);
                make.top.equalTo(label.mas_bottom).offset(5);
                make.size.mas_equalTo(CGSizeMake(Screen_W/5-5, 80));
            }];
            [self.checkBtnArray addObject:checkButton];
        }
        [checkButton addTarget:self action:@selector(queryClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    //确定按钮
    UIButton *sureBtn = [UIButton new];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.backgroundColor = [UIColor redColor];
    [view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(150);
        make.centerX.equalTo(view);
        make.size.mas_equalTo(CGSizeMake(300, 50));
    }];
    [sureBtn addTarget:self action:@selector(dateSureClicked:) forControlEvents:UIControlEventTouchUpInside];
    //时间拾取器
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *time = [formatter stringFromDate:date];
    NSLog(@"%@",time);
    self.datePicker = [UIDatePicker new];
    //拾取器风格
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    //设置地区标示
    NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"];
    [self.datePicker setLocale:locale];
    //设置时区为当前时区
    [self.datePicker setTimeZone:[NSTimeZone localTimeZone]];
    //最小可选时间
//    NSDate *minDate = [NSDate new];
    //最大可选时间
    self.datePicker.maximumDate = date;
    [view addSubview:self.datePicker];
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view);
        make.right.equalTo(view);
        make.bottom.equalTo(view);
    }];
    
}
-(void)dateSureClicked:(UIButton *)btn{
    NSLog(@"%@",self.datePicker.date);
}
//选择日期按钮点击事件
-(void)queryClicked:(UIButton *)btn{
    //遍历，先将所有的按钮图片设置为未选中
    NSInteger index = 0;
    for (UIButton *btn in self.checkBtnArray) {
        [btn setImage:[UIImage imageNamed:self.dateImageArray[index]] forState:UIControlStateNormal];
        index++;
    }
    [btn setImage:[UIImage imageNamed:self.dateImageArray[btn.tag-1996]] forState:UIControlStateNormal];
    
}
//选择店铺view
-(void)setView{
    //毛玻璃效果
    self.backgroundView = [UIView new];
    self.backgroundView.backgroundColor = Color_RGBA(42, 42, 55, 0.4);
    [self.view addSubview:self.backgroundView];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(Screen_W, Screen_H+64));
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
    //tableview
    self.storeTableview = [[UITableView alloc]init];
    self.storeTableview.dataSource = self;
    self.storeTableview.delegate = self;
    //去掉底部多余线条
    self.storeTableview.tableFooterView = [[UITableView alloc]initWithFrame:CGRectZero];
    self.storeTableview.rowHeight = 50;
    [view addSubview:self.storeTableview];
    [self.storeTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(removeBtn.mas_bottom).offset(10);
        make.left.equalTo(view.mas_left);
        make.size.mas_equalTo(CGSizeMake(Screen_W-20, Screen_H*0.6));
    }];
    //全选按钮
    self.selectBtn = [UIButton new];
    [self.selectBtn setImage:[UIImage imageNamed:@"记住密码"] forState:UIControlStateNormal];
    [self.selectBtn addTarget:self action:@selector(allBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view.mas_right).offset(-50);
        make.bottom.equalTo(view.mas_bottom).offset(-100);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    //全选label
    UILabel *allLabel = [[UILabel alloc]init];
    allLabel.text = @"全选";
    [view addSubview:allLabel];
    [allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view.mas_bottom).offset(-100);
        make.right.equalTo(self.selectBtn.mas_left).offset(-5);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    
}
//全选按钮点击事件
-(void)allBtnClicked:(UIButton *)button{
   static NSInteger index = 1;
    
    if (index % 2 == 1) {
        //非全选
        for (UISwitch *sw in self.allSwitchArray) {
            sw.on = NO;
        }
        for (UILabel *label in self.storeMtbArray) {
            label.textColor = [UIColor lightGrayColor];
        }
        //全都不选，计数器设为0
        self.number = 0;
        [self.selectBtn setImage:[UIImage imageNamed:@"记住密码框"] forState:UIControlStateNormal];
    }else{
        //全选
        for (UISwitch *sw in self.allSwitchArray) {
            sw.on = YES;
        }
        for (UILabel *label in self.storeMtbArray) {
            label.textColor = [UIColor redColor];
        }
        //全选，计数器设为4（店铺数据）
        self.number = 4;
        [self.selectBtn setImage:[UIImage imageNamed:@"记住密码"] forState:UIControlStateNormal];
    }
    index++;
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
#pragma tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"StoreTableViewCell" owner:self options:nil].firstObject;
    }
    cell.storeLabel.text = @"天棒";
    cell.storeLabel.tag = 1000 + indexPath.row;
    [self.storeMtbArray addObject:cell.storeLabel];
    cell.MySwitch.on = YES;
    cell.MySwitch.tag = 1000 + indexPath.row;
    [cell.MySwitch addTarget:self action:@selector(onOrOff:) forControlEvents:UIControlEventValueChanged];
    [self.allSwitchArray addObject:cell.MySwitch];
    return cell;
}
//开关
-(void)onOrOff:(UISwitch *)MySwitch{
    NSInteger index = MySwitch.tag - 1000;
    UILabel *label = self.storeMtbArray[index];
    if (MySwitch.on == YES) {
        label.textColor = [UIColor redColor];
    }else
    label.textColor = [UIColor lightGrayColor];
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
-(NSMutableArray *)allSwitchArray{
    if (!_allSwitchArray) {
        _allSwitchArray = [NSMutableArray new];
    }
    return _allSwitchArray;
}
-(NSArray *)dateImageArray{
    if (!_dateImageArray) {
        _dateImageArray = @[@"按年-未选",@"按月-未选",@"按周-未选",@"按日-未选",@"按年-选中",@"按月-选中",@"按周-选中",@"按日-选中"];
    }
    return _dateImageArray;
}
-(NSMutableArray *)checkBtnArray{
    if (!_checkBtnArray) {
        _checkBtnArray = [NSMutableArray new];
    }
    return _checkBtnArray;
}

@end
