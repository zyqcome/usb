//
//  CommodityController.m
//  TinyShop
//
//  Created by 韩舟昱 on 2016/12/24.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import "CommodityController.h"
#import "MyScrollView.h"
#import "SQMenuShowView.h"
#import "BarView.h"
#import "ColorDefine.h"

#define BASE_TAG 20130

@interface CommodityController ()<UIButtonSelectedDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *segmentTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *segmentWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *segmentHeight;

@property (nonatomic,strong)  MyScrollView * scollView;
@property (nonatomic,strong) NSArray *TitleLableArray;
@property (nonatomic,strong)  NSArray * colorArray;


@property (strong, nonatomic)  SQMenuShowView *showView;
@property (nonatomic,strong)  UIButton * coverBtn;
@property (nonatomic,assign)  BOOL  isShow;

//@property (nonatomic, strong) NSArray *colors;
//@property (nonatomic, strong) NSArray *types;
@property (nonatomic, strong) BarView *barChartView;
@end

@implementation CommodityController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(void)setupUI{
    //添加导航栏
    [self addNavigtionUI];
    //添加segment
    [self addSegment];
    //添加滚动视图
    [self addScollView];
    //添加弹窗视图
    [self addPopView];
    [self createBarChartView];
}

#pragma mark - 导航栏ui
-(void)addNavigtionUI{
    //导航栏
    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回按钮"] style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonClicked)];
    //title
    self.title = @"按天为单位统计";
}

-(void)leftButtonClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - segment
-(void)addSegment{
    //设置segment字体大小
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"AppleGothic"size:16*ScreenScale],NSFontAttributeName ,nil];
    [self.segment setTitleTextAttributes:dic forState:UIControlStateNormal];
    self.segmentTop.constant = (self.segmentTop.constant - 64) * ScreenScale +64;
    self.segmentWidth.constant = self.segmentWidth.constant*ScreenScale;
    self.segmentHeight.constant = self.segmentHeight.constant*ScreenScale;
    
    
}

- (IBAction)segmentClicked:(UISegmentedControl *)sender {
    self.segment = 0;
    
}

#pragma mark - 滚动视图
-(void)addScollView{
    _scollView = [[MyScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.segment.frame)+15,Screen_W, 75*ScreenScale)];
    [self.view addSubview:_scollView];
    
    _scollView.delegate = self;
    
    _TitleLableArray = [NSArray array];
    _TitleLableArray = @[@"川菜",@"家常菜",@"小吃",@"热菜",@"凉菜",@"汤菜",@"哈哈",@"哈哈",@"哈哈",@"哈哈"];
    _scollView.TitleLableArray = self.TitleLableArray;
    _scollView.tag = 836914;
    
    _scollView.colorArray = self.colorArray;
    
    
}

//调用代理传过来的button事件
-(void)selected:(MyScrollView *)scoll Button:(UIButton *)button{
    NSLog(@"--%ld",(long)button.tag);
    NSInteger typeIndex = button.tag ;
    
    BOOL success = [self.barChartView hiddenOrShowTyped:typeIndex hiddenSign:!button.selected];
    if (!success) {
        return;
    }
    if (button.selected == NO) {
        button.backgroundColor = [UIColor whiteColor];
    }else{
        button.backgroundColor = self.colorArray[typeIndex];
    }
    
    button.selected = !button.selected;
}

#pragma mark - 弹出视图
-(void)addPopView{
    //更多
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClicked)];
    self.navigationItem.rightBarButtonItem = rightButton;
    //    __weak typeof(self) weakSelf = self;
    [self.showView selectBlock:^(SQMenuShowView *view, NSInteger index) {
        [self dismissViewClicked];
        
        switch (index) {
            case 0:
                NSLog(@"1");
                break;
            case 1:
                NSLog(@"2");
                break;
            default:
                NSLog(@"3");
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

#pragma mark - 弹出视图懒加载
- (SQMenuShowView *)showView{
    if (!_showView) {
        _showView = [[SQMenuShowView alloc]initWithFrame:(CGRect){Screen_W-(130*ScreenScale),(64+5),120*ScreenScale,0} items:@[@"选择店铺",@"选择日期",@"选择种类"] showPoint:(CGPoint){Screen_W-25,10}];
        _showView.sq_backGroundColor = [UIColor whiteColor];
        _showView.itemTextColor = [UIColor grayColor];
    }
    return _showView;
}


#pragma mark - 柱状图

-(NSArray *)colorArray
{
    if (!_colorArray) {
        _colorArray = [CommodityController colorStoreByCount:self.TitleLableArray.count];
    }
    return _colorArray;
}

#pragma mark- Color
+ (NSArray *)colorStoreByCount:(NSInteger)count
{
    NSArray *moreColors =@[Color_RGBA(241, 54, 44, 1),Color_RGBA(23, 181, 249, 1),Color_RGBA(28, 130, 186, 1),Color_RGBA(254, 193, 32, 1),Color_RGBA(94, 183, 131, 1),Color_RGBA(71, 61, 144, 1),Color_RGBA(161, 85, 179, 1),Color_RGBA(225, 79, 54, 1),Color_RGBA(29, 209, 4, 1),Color_RGBA(199, 76, 254, 1)];
    
    NSMutableArray *colorStore = [NSMutableArray array];
    NSInteger num = count / moreColors.count;
    NSInteger dis = count % moreColors.count;
    while (num) {
        [colorStore addObjectsFromArray:moreColors];
        num--;
    }
    if (dis == 1) {
        [colorStore addObject:moreColors[1]];
    }else{
        [colorStore addObjectsFromArray:[moreColors subarrayWithRange:NSMakeRange(0, dis)]];
    }
    
    return colorStore;
}

- (void)createBarChartView
{
    self.barChartView = [[BarView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_scollView.frame)+12, Screen_W, Screen_H-CGRectGetMaxY(_scollView.frame)-30)];
    [self.view addSubview:self.barChartView];
    self.barChartView.titleStore = @[@"2016-11-11",@"2016-11-12"];
    CGAffineTransform transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -5);
    transform = CGAffineTransformRotate(transform, M_PI*0.25);
    self.barChartView.labelTransform = transform;
    self.barChartView.bottomMargin = 25;
    self.barChartView.incomeBottomMargin = 0;
    self.barChartView.brefixStr = @"份数";
    //self.barChartView.suffixStr = @"后缀";

 
    self.barChartView.incomeStore = @[@{_TitleLableArray[0]:@"10",_TitleLableArray[1]:@"5",@"小吃":@"1",@"热菜":@"0",@"凉菜":@"0",@"汤菜":@"8",@"哈哈":@"3",@"哈哈":@"0",@"哈哈":@"0",@"哈哈":@"3"},@{@"川菜":@"1",@"家常菜":@"3",@"小吃":@"0",@"热菜":@"5",@"凉菜":@"2",@"汤菜":@"0",@"哈哈":@"0",@"哈哈":@"0",@"哈哈":@"0",@"哈哈":@"6"}];
    self.barChartView.allTypes = self.TitleLableArray;
    self.barChartView.colorStore = self.colorArray;
    [self.view addSubview:self.barChartView];
    self.barChartView.topTitleCallBack = ^NSString *(CGFloat sumValue){
        return [NSString stringWithFormat:@"总份数：%.0f",sumValue];
    };
    
    self.barChartView.selectCallback = ^(NSUInteger index){
        NSLog(@"选中第%@个",@(index));
    };
    [self.barChartView storkePath];
    
}





@end
