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
@interface PieChartView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *valueStore;
    NSArray *textStore;
}
@property (nonatomic, strong) MZPieChartView *pieChartView;
@property (weak, nonatomic) IBOutlet UIView *viewPieChart;
@property (weak, nonatomic) IBOutlet UIView *viewtableview;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PieChartView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    valueStore=@[@"1",@"4",@"1",@"3",@"2",@"4",@"4",@"8",@"8",@"7",@"7",@"9",@"7",@"7",@"4",@"7",@"9",@"9",@"9",@"9",@"9",@"9",@"9"];
    //text
    textStore= @[@"西南大学",@"北京大学",@"清华大学",@"东京大学",@"南京大学",@"西南民族大学",@"浙江大学",@"复旦大学",@"西华大学",@"哈尔冰工业大学",@"四川大学",@"电子科技大学",@"西安科技大学",@"西南大学",@"重庆大学",@"斯坦福大学",@"哈佛",@"纽约大学",@"西南石油大学",@"云南大学",@"贵州大学",@"西北大学",@"北京邮电大学"];
    
    [self createPieChartView];
    
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
    self.pieChartView = [[MZPieChartView alloc]initWithFrame:CGRectMake(-30,-30,self.viewPieChart.width,self.viewPieChart.height)];
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

#pragma mark- Button Action

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
    return ^(NSInteger index){
        NSLog(@"选中第%ld个",index);
    };
}

/** 取消选中回调 */

- (DeselectCallBack)deselect
{
    return ^{
        NSLog(@"取消选中饼状图");
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
        [cell addviewPrecent:200 color:self.dataSet.colorStore[indexPath.row]];
    }
    /**
    cell.label.text = self.shopshowArry[indexPath.row].shopname;
    cell.Blseleclt = self.shopshowArry[indexPath.row].showIs;
    [cell.btn setImage:[UIImage imageNamed:(self.shopshowArry[indexPath.row].showIs ? @"选中" : @"未选中")] forState:UIControlStateNormal];
     */
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@",@(indexPath.row));
    [self.pieChartView selectOne:indexPath.row];
}


@end
