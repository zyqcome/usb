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
@interface HomeController ()
@property (nonatomic,strong)  HomeController * homeVc;
@property (nonatomic,strong) DrawerController *leftVc;
@property (nonatomic,strong) UIButton *coverBtn;
@property (nonatomic,assign) CGPoint beginP;


//约束
@end

@implementation HomeController

-(void)viewDidLoad{
    [super viewDidLoad];


}



#pragma mark - 数据源方法

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
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




@end
