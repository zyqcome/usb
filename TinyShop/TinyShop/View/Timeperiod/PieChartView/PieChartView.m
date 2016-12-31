//
//  PieChartView.m
//  TinyShop
//
//  Created by rimi on 16/12/29.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import "PieChartView.h"
#import "MZPieChartView.h"
#import "Masonry.h"
#import "PieChartTableCell.h"
#import "TimeperiodNethelper.h"
#import "TimeperiodProtocol.h"

@implementation  dishModel
@end

@implementation  PieChartModel
@end

@interface PieChartView ()<UITableViewDelegate,UITableViewDataSource,TimeperiodProtocol>
{
    NSArray *valueStore;
    NSArray *textStore;
    float maxShopAddValue;//所有店铺经营和值
    NSInteger pieChartSecelt;
}
@property (nonatomic, strong) MZPieChartView *pieChartView;
@property (weak, nonatomic) IBOutlet UIView *viewPieChart;
@property (weak, nonatomic) IBOutlet UIView *viewtableview;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray<PieChartModel *> *pieChartarry;
@end

@implementation PieChartView

- (void)viewDidLoad {
    [super viewDidLoad];
#pragma mark -数据初始化
    pieChartSecelt  = -1;

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellEditingStyleNone;
    
    TimeperiodNethelper *timeperiodNethelper = [TimeperiodNethelper new];
    timeperiodNethelper.delege = self;
    [timeperiodNethelper getApporderStatisticalDateShoplist:self.displayshoplist time:self.displayshopdate];//157,158.311
    
    //valueStore=@[@"1",@"4",@"1",@"3",@"2",@"4",@"4",@"8",@"8",@"7",@"7",@"9",@"7",@"7",@"4",@"7",@"9",@"9",@"9",@"9",@"9",@"9",@"9"];
    //text
    //textStore= @[@"西南大学",@"北京大学",@"清华大学",@"东京大学",@"南京大学",@"西南民族大学",@"浙江大学",@"复旦大学",@"西华大学",@"哈尔冰工业大学",@"四川大学",@"电子科技大学",@"西安科技大学",@"西南大学",@"重庆大学",@"斯坦福大学",@"哈佛",@"纽约大学",@"西南石油大学",@"云南大学",@"贵州大学",@"西北大学",@"北京邮电大学"];
    
    //[self createPieChartView];
    
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
- (void)createPieChartView
{
    self.pieChartView = [[MZPieChartView alloc]initWithFrame:CGRectMake(0,0,self.viewPieChart.width,self.viewPieChart.width)];
    [self.viewPieChart addSubview:self.pieChartView];
    //饼状图设置
    self.pieChartView.set = [self set];
    //饼状图数据源设置
    self.pieChartView.dataSet = [self dataSet];
    //饼状图颜色字体 设置
    self.pieChartView.fontColorSet = [self fontColorSetx];
    //选中回调
    self.pieChartView.selectOne = [self select];
    //取消选中回调
    self.pieChartView.deselect = [self deselect];
    //开始绘图
    [self.pieChartView stroke];
/**
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, self.view.height-70, 150, 45);
    button.center =  CGPointMake(self.view.width/2, self.view.height-100);
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"Select" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(selectPieChart) forControlEvents:UIControlEventTouchUpInside];
    [self.viewPieChart addSubview:button];
*/
}

#pragma mark- Piechat Action

- (void)selectPieChart
{
    NSUInteger index = (NSUInteger)random() % self.pieChartView.dataSet.valueStore.count;
    NSLog(@"手动选择第%lu个",index);
    [self.pieChartView selectOne:index];
}

#pragma mark- MZPieChartView

/** 饼状图 设置 */
- (MZPieChartSet *)set
{
    MZPieChartSet *set = [[MZPieChartSet alloc]init];
    //    //饼状图收入小数位数 默认2.
    //    set.valueFractionDigits = 2;
    //    //饼状图 绘图起始角度 默认负90度.
    //    set.startAngle = -1 * M_PI_2;
    //    //饼状图 半径比例 默认0.24
    //    set.radiusPercent = 0.24;
    //    //饼状图 扇形线宽比例 默认0.14
    //    set.lineWidthPercent = 0.14;
    //    //饼状图 扇形选中线宽比例 默认0.18
    //    set.selectLineWidthPercent = 0.18;
    //    //当扇形对应比例小于0.05，扇形上的比例文字不显示，选中扇形时，在空白区域显示
    //    set.hiddenPercent = 0.05;
    return set;
}

/** 饼状图数据 设置 */
- (MZPieChartDataSet *)dataSet
{
    MZPieChartDataSet *dataSet = [[MZPieChartDataSet alloc]init];
    //标题
    dataSet.text = @"中国";
    //收入
    dataSet.valueStore = valueStore;
    //text
    dataSet.textStore =textStore;
    //颜色
    dataSet.colorStore = [MZPieChartDataSet colorStoreByCount:dataSet.valueStore.count];
    return dataSet;
}


/** 饼状图 字体及文本颜色设置 */
-(MZPieChartFontColorSet *)fontColorSetx
{
    MZPieChartFontColorSet *fontColorSet = [[MZPieChartFontColorSet alloc]init];
    //    //文本字体
    //    fontColorSet.centerTextFont = [UIFont systemFontOfSize:10.0];
    //    //收入字体
    //    fontColorSet.centerValueFont = [UIFont systemFontOfSize:14.0];
    //    //比例文本字体
    //    fontColorSet.percentTextFont = [UIFont systemFontOfSize:15.0];
    //    //空白区域比例文本字体
    //    fontColorSet.hiddenPercentTextFont = [UIFont systemFontOfSize:15.0];
    //    //文本颜色
    //    fontColorSet.centerTextColor = [UIColor blackColor];
    //    //收入文本颜色
    //    fontColorSet.centerValueColor = [UIColor blackColor];
    //    //比例文本颜色
    //    fontColorSet.percentTextColor = [UIColor whiteColor];
    //    //空白区域比例文本颜色
    //    fontColorSet.hiddenPercentTextColor = [UIColor blackColor];
    //
    return fontColorSet;
}


/** 选中回调 */

- (SelectCallBack)select
{
    __weak typeof(self) weakSelf = self;
    return ^(NSInteger index){
        NSLog(@"选中第%ld个",index);
        pieChartSecelt = index;
        [weakSelf.tableView reloadData];
    };
}

/** 取消选中回调 */

- (DeselectCallBack)deselect
{
    __weak typeof(self) weakSelf = self;
    return ^{
        NSLog(@"取消选中饼状图");
        pieChartSecelt = -1;
        [weakSelf.tableView reloadData];
    };
}

#pragma mark -表格代理
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellPiechart";
    PieChartTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //将Custom.xib中的所有对象载入
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PieChartTableCell" owner:nil options:nil];
        cell = [nib objectAtIndex:0];
    }
    float bili =0;
    if (self.pieChartarry.count == 1) {
        bili = [self.pieChartarry[0].dishArry[indexPath.row].value floatValue]/maxShopAddValue;
        cell.labelName.text = self.pieChartarry[0].dishArry[indexPath.row].name;//stringByAppendingString:[NSString stringWithFormat:@"%f%%",bili]];
        cell.labelPercent.text = [NSString stringWithFormat:@"%d%%",(int)(bili*100)];
        [cell addviewPrecent:bili color:self.dataSet.colorStore[indexPath.row]];
    } else {
        bili = [self.pieChartarry[indexPath.row].value floatValue]/maxShopAddValue;
        cell.labelName.text = [self.pieChartarry[indexPath.row].name stringByAppendingString:[NSString stringWithFormat:@"%d%%",(int)(bili*100)]];
        cell.labelPercent.text = self.pieChartarry[indexPath.row].value;
        cell.colorBtn.backgroundColor = self.dataSet.colorStore[indexPath.row];
        [cell addviewPrecent:0 color:self.dataSet.colorStore[indexPath.row]];
        if (pieChartSecelt == indexPath.row) {
            cell.labelName.textColor = [UIColor redColor];
        } else {
            cell.labelName.textColor = [UIColor blackColor];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger row = self.pieChartarry.count == 1 ? self.pieChartarry[0].dishArry.count : self.pieChartarry.count;
    return row;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@",@(indexPath.row));
    [self.pieChartView selectOne:indexPath.row];
}

-(NSArray<PieChartModel *> *)pieChartarry {
    if (!_pieChartarry) {
        _pieChartarry = [NSArray new];
    }
    return _pieChartarry;
}

#pragma mark -数据刷新代理 
-(void)resetTimeperiod:(Received)sender Bl:(BOOL)bl message:(id)ms
{
    NSDictionary *dic = (NSDictionary *)ms;
    NSArray *shoparry = dic[@"body"][@"branch"];
    
    NSMutableArray<PieChartModel *> *mutShoparry = [NSMutableArray new];
    
    for (NSDictionary *d in shoparry) {
        PieChartModel *pieml = [PieChartModel new];
        pieml.name = [d valueForKey:@"name"];
        pieml.value = [d valueForKey:@"value"];
        [mutShoparry addObject:pieml];
    }
    
    NSDictionary *shopdishdic = dic[@"body"][@"vegetables"];//所有店铺
    //d 所有店铺的字典
    NSArray *keyarry = [shopdishdic allKeys];//获取key
    int i=0;
    for (NSString *strkey in keyarry) {
        //店铺循环
        NSArray *disharry = [shopdishdic valueForKey:strkey];//取出店铺的菜单
        NSMutableArray *mulArry = [NSMutableArray new];//缓存当前店铺的菜单
        if (disharry.count == 0) {
        } else {
            for (NSDictionary *dish in disharry) {
                dishModel *dishml = [dishModel new];
                dishml.name = [NSString stringWithFormat:@"%@",[dish valueForKey:@"name"]];
                dishml.value = [NSString stringWithFormat:@"%@",[dish valueForKey:@"value"]];
                [mulArry addObject:dishml];
            }
            mutShoparry[i].dishArry = mulArry;
            i++;
        }
    }
    //获取饼图显示数组
    self.pieChartarry = mutShoparry;
    NSMutableArray *mulvalueStore = [NSMutableArray new];
    NSMutableArray *multextStore = [NSMutableArray new];
    maxShopAddValue = 0;
    if (self.pieChartarry.count == 1) {
        [self.pieChartarry[0].dishArry enumerateObjectsUsingBlock:^(dishModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [multextStore addObject:[NSString stringWithString:obj.name]];
            [mulvalueStore addObject:[NSString stringWithString:obj.value]];
            //统计显示数据-这个是只有一个店铺，那么，统计的就是店铺中的菜品数据
            //CGFloat *maxShopAddValue;//所有店铺经营和值
            maxShopAddValue += [obj.value floatValue];
        }];
        
    } else {
        [self.pieChartarry enumerateObjectsUsingBlock:^(PieChartModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [multextStore addObject:[NSString stringWithString:obj.name]];
            [mulvalueStore addObject:[NSString stringWithString:obj.value]];
            maxShopAddValue += [obj.value floatValue];
        }];
    }
    
    valueStore=mulvalueStore;
    textStore =multextStore;
    //绘制饼图
    [self createPieChartView];
    
    pieChartSecelt  = -1;
    //刷新表格
    [self.tableView reloadData];
}

@end
