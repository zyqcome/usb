//
//  ShowStore.m
//  TinyShop
//
//  Created by 韩舟昱 on 2016/12/28.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import "ShowStore.h"
#import "ShowStoreCell.h"
#define itemHeigth     70 *ScreenScale  //每项高度
@interface ShowStore()
<UITableViewDelegate,UITableViewDataSource,redSwitchDelegate>

//传出要赋值的表格视图的数组
@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) UITableView *myTabelView;
@property (strong, nonatomic) NSMutableSet *choseSet;
@property (nonatomic,strong)  NSMutableArray * mArray;
@property (nonatomic,strong) UIButton * rememberButton;
@property (nonatomic,strong)  UIColor * titleTextColor;


@end

@implementation ShowStore

- (id)initWithStoreFrame:(CGRect)frame items:(NSArray<NSString *> *)items {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.items = items.copy;
        self.frame = CGRectMake(15, 64+5, Screen_W-30, Screen_H-69-20);
        self.alpha = 1;
        [self setNeedsDisplay];
        [self.myTabelView reloadData];
        //动画起始位置
        self.layer.anchorPoint = CGPointMake(0.9, 0);
        self.layer.position = CGPointMake(self.layer.position.x+self.frame.size.width*0.4, self.layer.position.y-self.frame.size.height*0.5);
        [self setupUI];
        self.mArray = [NSMutableArray array];
        for (int i = 0; i < self.items.count; i++) {
            [self.mArray addObject:@(i)];
        }

     }
    return self;
}
#pragma mark - 创建ui

-(void)setupUI{
    //线
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(self.myTabelView.frame), self.frame.size.width, 0.5)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:view];
    //关闭
    UIButton * closeButton = [[UIButton alloc]initWithFrame:CGRectMake(Screen_W-85*ScreenScale, 8, 33*ScreenScale, 33*ScreenScale)];
    closeButton.tag = 0;
    [closeButton setBackgroundImage:[UIImage imageNamed:@"关闭2"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeButton];
    //全选button
    UIButton * rememberButton = [[UIButton alloc]initWithFrame:CGRectMake(Screen_W-90, CGRectGetMaxY(self.myTabelView.frame)+20, 28*ScreenScale, 28*ScreenScale)];
    self.rememberButton = rememberButton;
    rememberButton.tag = 1;
    [rememberButton setBackgroundImage:[UIImage imageNamed:@"记住密码"] forState:UIControlStateNormal];
    [rememberButton addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rememberButton];
    
    //全选label
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(rememberButton.frame)-10-37, rememberButton.frame.origin.y, 40*ScreenScale, 28*ScreenScale)];
    label.text = @"全选";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:18*ScreenScale];
    [self addSubview:label];
    
    //确定button
    UIButton * confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(40*ScreenScale, CGRectGetMaxY(rememberButton.frame)+20,self.frame.size.width-80*ScreenScale, 45*ScreenScale)];
    confirmButton.tag=2;
    [confirmButton setTitle:@"确         定" forState:UIControlStateNormal];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"确----定背景框"] forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    confirmButton.titleLabel.font    = [UIFont systemFontOfSize: 21*ScreenScale];
    [self addSubview:confirmButton];
    
    
}

-(void)closeButtonClicked:(UIButton *)sender {
    if (sender.tag==0||sender.tag==2) {
        
        if ([self.delegate respondsToSelector:@selector(selectedButton:mArray:)]) {
            [self.delegate selectedButton:sender mArray:self.mArray];
        }
    }else{
        
        if (self.mArray.count != self.items.count) {
            NSMutableArray *mutarry = [NSMutableArray new];
            for (int i=0; i<self.items.count; i++) {
                [mutarry addObject:@(i)];
            }
            [self.rememberButton setBackgroundImage:[UIImage imageNamed:@"记住密码"] forState:UIControlStateNormal];
            self.mArray =mutarry;
            [self.myTabelView reloadData];
        }else{
            [self.rememberButton setBackgroundImage:[UIImage imageNamed:@"记住密码框"] forState:UIControlStateNormal];
            [self.mArray removeAllObjects];
            [self.myTabelView reloadData];
        }

    }
}


#pragma mark - 数据源方法

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShowStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShowStoreCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.items[indexPath.row];
    cell.titleLabel.font = [UIFont systemFontOfSize:21*ScreenScale];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.redSwitch.tag = indexPath.row;
    cell.delegate = self;
    cell.redSwitch.on = [self.mArray containsObject:@(indexPath.row) ];
    cell.titleLabel.textColor =   cell.redSwitch.on ? [UIColor redColor] : [UIColor grayColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return itemHeigth;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma mark - cell协议
-(void)selected:(ShowStoreCell *)cell redSwitch:(UISwitch *)redSwitch lebel:(UILabel *)titleLabel{
    self.titleTextColor = titleLabel.textColor;
    if(redSwitch.isOn){
        [self.mArray addObject:@(redSwitch.tag)];
        titleLabel.textColor = [UIColor redColor];
        if (self.mArray.count == self.items.count) {
        [self.rememberButton setBackgroundImage:[UIImage imageNamed:@"记住密码"] forState:UIControlStateNormal];
        }
    }else {
        [self.mArray removeObject:@(redSwitch.tag)];
        titleLabel.textColor = [UIColor grayColor];
        [self.rememberButton setBackgroundImage:[UIImage imageNamed:@"记住密码框"] forState:UIControlStateNormal];

    }
}

#pragma - 动画方法

- (void)showStoreView{
    
    self.alpha = 0;
    self.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    [UIView animateWithDuration:0.2 animations:^{
        
        self.transform = CGAffineTransformMakeScale(1, 1);
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismissStoreView{
    
    [UIView animateWithDuration:0.2 animations:^{
        self.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
        self.alpha = 0;
    }completion:^(BOOL finished){

    }];
}


#pragma mark - 懒加载

- (UITableView *)myTabelView{
    if (_myTabelView) {
        return _myTabelView;
    }
    
    _myTabelView = [[UITableView alloc]initWithFrame:(CGRect){0,50,self.frame.size.width,self.frame.size.height-220*ScreenScale}];
    _myTabelView.delegate = self;
    _myTabelView.dataSource = self;
    _myTabelView.backgroundColor = [UIColor whiteColor];
    _myTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_myTabelView];
    
    [_myTabelView registerNib:[UINib nibWithNibName:@"ShowStoreCell" bundle:nil] forCellReuseIdentifier:@"ShowStoreCell"];
    return _myTabelView;
}


@end
