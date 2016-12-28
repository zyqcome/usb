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
<UITableViewDelegate,UITableViewDataSource>

//传出要赋值的表格视图的数组
@property (strong, nonatomic) NSArray *items;

@property (strong, nonatomic) UITableView *myTabelView;
@property (strong, nonatomic) NSMutableSet *choseSet;
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
    UIButton * closeButton = [[UIButton alloc]initWithFrame:CGRectMake(Screen_W-85, 8, 33, 33)];
    closeButton.tag = 1;
    [closeButton setBackgroundImage:[UIImage imageNamed:@"关闭2"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeButton];
    //全选button
    UIButton * rememberButton = [[UIButton alloc]initWithFrame:CGRectMake(Screen_W-90, CGRectGetMaxY(self.myTabelView.frame)+20, 28, 28)];
    rememberButton.tag = 2;
    [rememberButton setBackgroundImage:[UIImage imageNamed:@"记住密码"] forState:UIControlStateNormal];
    [rememberButton addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rememberButton];
    
    //全选label
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(rememberButton.frame)-10-37, rememberButton.frame.origin.y, 40, 28)];
    label.text = @"全选";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:18];
    [self addSubview:label];
    
    //确定button
    UIButton * confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(rememberButton.frame)+20,self.frame.size.width-80, 50)];
    [confirmButton setTitle:@"确         定" forState:UIControlStateNormal];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"确----定背景框"] forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    confirmButton.titleLabel.font    = [UIFont systemFontOfSize: 21];
    [self addSubview:confirmButton];
    
    
}

-(void)closeButtonClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(selectedButton:)]) {
        [self.delegate selectedButton:sender];
    }}


#pragma mark - 数据源方法

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShowStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShowStoreCell"];
    cell.titleLabel.text = self.items[indexPath.row];
    cell.titleLabel.font = [UIFont systemFontOfSize:21*ScreenScale];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//    if (indexPath.row == self.items.count - 1) {
//        cell.lineView.hidden = YES;
//    }else{
//        cell.lineView.hidden = NO;
//    }
//    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return itemHeigth;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectBlock) {
        self.selectBlock (self,indexPath.row);
    }
    if (![self.choseSet containsObject:@(indexPath.row)]) {
        [self.choseSet removeAllObjects];
        [self.choseSet addObject:@(indexPath.row)];
    }
    [self.myTabelView reloadData];
    
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
    }];
}


- (void)selectBlock:(void (^)(ShowStore *, NSInteger))block{
    self.selectBlock = block;
}

#pragma mark - 懒加载
- (NSMutableSet *)choseSet{
    if (!_choseSet) {
        _choseSet = [[NSMutableSet alloc]init];
    }
    return _choseSet;
}

- (UITableView *)myTabelView{
    if (_myTabelView) {
        return _myTabelView;
    }
    
    _myTabelView = [[UITableView alloc]initWithFrame:(CGRect){0,50,self.frame.size.width,self.frame.size.height-220}];
    _myTabelView.delegate = self;
    _myTabelView.dataSource = self;
    _myTabelView.backgroundColor = [UIColor whiteColor];
    _myTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_myTabelView];
    
    [_myTabelView registerNib:[UINib nibWithNibName:@"ShowStoreCell" bundle:nil] forCellReuseIdentifier:@"ShowStoreCell"];
    return _myTabelView;
}


@end
