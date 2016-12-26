//
//  CommodityController.m
//  TinyShop
//
//  Created by 韩舟昱 on 2016/12/24.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import "CommodityController.h"
#import "MyScrollView.h"
#import "PopupView.h"
@interface CommodityController ()<UIButtonSelectedDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *segmentTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *segmentWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *segmentHeight;

@property (nonatomic,assign)  BOOL  isColorA;
@property (nonatomic,assign)  BOOL  isColorB;
@property (nonatomic,assign)  BOOL  isColorC;
@property (nonatomic,assign)  BOOL  isColorD;
@property (nonatomic,assign)  BOOL  isColorE;
@property (nonatomic,assign)  BOOL  isColorF;
@property (nonatomic,assign)  BOOL  isColorG;
@property (nonatomic,assign)  BOOL  isColorH;
@property (nonatomic,assign)  BOOL  isColorI;
@property (nonatomic,assign)  BOOL  isColorJ;

@property (nonatomic,strong) NSArray *TitleLableArray;

@end

@implementation CommodityController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(void)setupUI{
    //导航栏
    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回按钮"] style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonClicked)];
    //更多
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClicked)];
    self.navigationItem.rightBarButtonItem = rightButton;
    //title
    self.title = @"按天为单位统计";
    //设置segment字体大小
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"AppleGothic"size:16*ScreenScale],NSFontAttributeName ,nil];
    [self.segment setTitleTextAttributes:dic forState:UIControlStateNormal];
    self.segmentTop.constant = (self.segmentTop.constant - 64) * ScreenScale +64;
    self.segmentWidth.constant = self.segmentWidth.constant*ScreenScale;
    self.segmentHeight.constant = self.segmentHeight.constant*ScreenScale;
    
    MyScrollView * scrollView = [[MyScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.segment.frame)+15, Screen_W, 75*ScreenScale)];
    [self.view addSubview:scrollView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    scrollView.delegate = self;
    //scollview
    _TitleLableArray = [NSArray array];
    _TitleLableArray = @[@"川菜",@"家常菜",@"小吃",@"热菜",@"凉菜",@"汤菜",@"哈哈",@"哈哈",@"哈哈",@"哈哈"];
    scrollView.TitleLableArray = self.TitleLableArray;
}


-(void)selected:(MyScrollView *)scoll Button:(UIButton *)button Label:(UILabel *)caiLabel{
    
    switch (button.tag) {
        case 0:
            _isColorA = !_isColorA;
            if (!_isColorA) {
                [button setBackgroundColor:Color_RGBA(241, 54, 44, 1)];
            }else{
                [button setBackgroundColor:[UIColor whiteColor]];
            }
            break;
        case 1:
            _isColorB = !_isColorB;
            if (!_isColorB) {
                [button setBackgroundColor:Color_RGBA(23, 181, 249, 1)];
            }else{
                [button setBackgroundColor:[UIColor whiteColor]];
            }
            break;
        case 2:
            _isColorC = !_isColorC;
            if (!_isColorC) {
                [button setBackgroundColor:Color_RGBA(28, 130, 186, 1)];
            }else{
                [button setBackgroundColor:[UIColor whiteColor]];
            }
            break;
        case 3:
            _isColorD = !_isColorD;
            if (!_isColorD) {
                [button setBackgroundColor:Color_RGBA(254, 193, 32, 1)];
            }else{
                [button setBackgroundColor:[UIColor whiteColor]];
            }
            break;
        case 4:
            _isColorE = !_isColorE ;
            if (!_isColorE) {
                [button setBackgroundColor:Color_RGBA(94, 183, 131, 1)];
            }else{
                [button setBackgroundColor:[UIColor whiteColor]];
            }
            break;
        case 5:
            _isColorF = !_isColorF;
            if (!_isColorF) {
                [button setBackgroundColor:Color_RGBA(71, 61, 144, 1)];
            }else{
                [button setBackgroundColor:[UIColor whiteColor]];
            }
            break;
        case 6:
            _isColorG = !_isColorG;
            if (!_isColorG) {
                [button setBackgroundColor:Color_RGBA(161, 85, 179, 1)];
            }else{
                [button setBackgroundColor:[UIColor whiteColor]];
            }
            break;
        case 7:
            _isColorH = !_isColorH;
            if (!_isColorH) {
                [button setBackgroundColor:Color_RGBA(225, 79, 54, 1)];
            }else{
                [button setBackgroundColor:[UIColor whiteColor]];
            }
            break;
        case 8:
            _isColorI = !_isColorI;
            if (!_isColorI) {
                [button setBackgroundColor:Color_RGBA(29, 209, 4, 1)];
            }else{
                [button setBackgroundColor:[UIColor whiteColor]];
            }
            break;
        default:
            _isColorJ = !_isColorJ;
            if (!_isColorJ) {
                [button setBackgroundColor:Color_RGBA(199, 76, 254, 1)];
            }else{
                [button setBackgroundColor:[UIColor whiteColor]];
            }
            break;
    }
}


-(void)rightButtonClicked{
    [PopupView addCellWithIcon:[UIImage imageNamed:@"点"] text:@"选择店铺" action:^{
        
    }];
    [PopupView addCellWithIcon:[UIImage imageNamed:@"点"] text:@"选择时间" action:^{
        NSLog(@"");
    }];
    [PopupView popupView];
}

-(void)leftButtonClicked{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)segmentClicked:(UISegmentedControl *)sender {
    self.segment = 0;
}



@end
