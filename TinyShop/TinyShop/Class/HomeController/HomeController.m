//
//  HomeController.m
//  TinyShop
//
//  Created by 韩舟昱 on 2016/12/22.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import "HomeController.h"
#import "DrawerController.h"
#import "DHControllerViewController.h"
#import "TimeperiodVC.h"
#import "StatisticalViewController.h"
#import "CommodityController.h"
@interface HomeController ()
@property (nonatomic,strong)  HomeController * homeVc;
@property (nonatomic,strong) DrawerController *leftVc;
@property (nonatomic,strong) UIButton *coverBtn;
@property (nonatomic,assign) CGPoint beginP;


//约束
//cell1
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ROH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ROW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *RTW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *RTH;
@property (weak, nonatomic) IBOutlet UILabel *ROL;
@property (weak, nonatomic) IBOutlet UILabel *RTL;
@property (weak, nonatomic) IBOutlet UILabel *RSL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *RVT;
//cell2
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BOW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BOH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BTH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BTW;
@property (weak, nonatomic) IBOutlet UILabel *BOL;
@property (weak, nonatomic) IBOutlet UILabel *BTL;
@property (weak, nonatomic) IBOutlet UILabel *BSL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BVT;

//cell3
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *YOH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *YOW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *YTH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *YTW;
@property (weak, nonatomic) IBOutlet UILabel *YOL;
@property (weak, nonatomic) IBOutlet UILabel *YTL;
@property (weak, nonatomic) IBOutlet UILabel *YSL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *YVT;
//cell4
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *GOW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *GOH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *GTH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *GTW;
@property (weak, nonatomic) IBOutlet UILabel *GOL;
@property (weak, nonatomic) IBOutlet UILabel *GTL;
@property (weak, nonatomic) IBOutlet UILabel *GSL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *GVT;
//cell5
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *POW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *POH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *PTW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *PTH;
@property (weak, nonatomic) IBOutlet UILabel *POL;
@property (weak, nonatomic) IBOutlet UILabel *PTL;
@property (weak, nonatomic) IBOutlet UILabel *PSL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *PVT;


@end

@implementation HomeController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self cellScale];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105 *ScreenScale;
}


#pragma mark - 数据源方法

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
    switch (indexPath.row) {
        case 0:
        {
            TimeperiodVC *svc = [TimeperiodVC new];
            [self.navigationController pushViewController:svc animated:YES];
        }
            break;
        case 1:
        {
            StatisticalViewController *svc = [StatisticalViewController new];
            [self.navigationController pushViewController:svc animated:YES];
        }
            break;
        case 2:
        {
            CommodityController * cvc = [CommodityController new];
            [self.navigationController pushViewController:cvc animated:YES];
        }
            break;
        case 3:
            
            break;
        case 4:
        
            break;
        default
            :
            break;
    }
}


-(void)cellScale{
    //1
    _ROH.constant = _ROH.constant *ScreenScale;
    _RTH.constant = _RTH.constant  *ScreenScale;
    _ROW.constant = _ROW.constant *ScreenScale;
    _RTW.constant = _RTW.constant *ScreenScale;
    _ROL.font = [UIFont systemFontOfSize:20*ScreenScale];
    _RTL.font = [UIFont systemFontOfSize:15*ScreenScale];
    _RSL.font = [UIFont systemFontOfSize:15*ScreenScale];
    _RVT.constant = _RVT.constant * ScreenScale;
    
    //2
    _BOH.constant = _BOH.constant *ScreenScale;
    _BTH.constant = _BTH.constant  *ScreenScale;
    _BOW.constant = _BOW.constant *ScreenScale;
    _BTW.constant = _BTW.constant *ScreenScale;
    _BOL.font = [UIFont systemFontOfSize:20*ScreenScale];
    _BTL.font = [UIFont systemFontOfSize:15*ScreenScale];
    _BSL.font = [UIFont systemFontOfSize:15*ScreenScale];
    _BVT.constant = _BVT.constant * ScreenScale;
    
    //3
    _YOH.constant = _YOH.constant *ScreenScale;
    _YTH.constant = _YTH.constant  *ScreenScale;
    _YOW.constant = _YOW.constant *ScreenScale;
    _YTW.constant = _YTW.constant *ScreenScale;
    _YOL.font = [UIFont systemFontOfSize:20*ScreenScale];
    _YTL.font = [UIFont systemFontOfSize:15*ScreenScale];
    _YSL.font = [UIFont systemFontOfSize:15*ScreenScale];
    _YVT.constant = _YVT.constant * ScreenScale;
    //4
    _GOH.constant = _GOH.constant *ScreenScale;
    _GTH.constant = _GTH.constant  *ScreenScale;
    _GOW.constant = _GOW.constant *ScreenScale;
    _GTW.constant = _GTW.constant *ScreenScale;
    _GOL.font = [UIFont systemFontOfSize:20*ScreenScale];
    _GTL.font = [UIFont systemFontOfSize:15*ScreenScale];
    _GSL.font = [UIFont systemFontOfSize:15*ScreenScale];
    _GVT.constant = _GVT.constant * ScreenScale;
    
    //5
    _POH.constant = _POH.constant *ScreenScale;
    _PTH.constant = _PTH.constant  *ScreenScale;
    _POW.constant = _POW.constant *ScreenScale;
    _PTW.constant = _PTW.constant *ScreenScale;
    _POL.font = [UIFont systemFontOfSize:20*ScreenScale];
    _PTL.font = [UIFont systemFontOfSize:15*ScreenScale];
    _PSL.font = [UIFont systemFontOfSize:15*ScreenScale];
    _PVT.constant = _PVT.constant * ScreenScale;
}



@end
