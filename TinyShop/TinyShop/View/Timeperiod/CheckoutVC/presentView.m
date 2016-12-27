//
//  presentView.m
//  TinyShop
//
//  Created by rimi on 16/12/27.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import "presentView.h"
#import "TableViewCell.h"

@implementation shopShow
@end
#define MAIN_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define MAIN_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

/** 调试模式 */
#define DEBUG 1
@interface presentView()<UITableViewDelegate,UITableViewDataSource>
{
    
}
/** 关闭按键 */
@property (nonatomic,strong)UIButton *btnClose;
/** 表格视图 */
@property (nonatomic,strong)UITableView *tableview;
/** 全选按键 */
@property (nonatomic,strong)UIButton *btnSeceltAll;
/** 确定按键 */
@property (nonatomic,strong)UIButton *btnCallback;

/** 标题栏站位视图 */
@property (nonatomic,strong)UIView *viewTitle;
/** 下状态栏-占位视图 */
@property (nonatomic,strong)UIView *viewStatus;

@property (nonatomic,strong)UIView *statusChildView;

@end
@implementation presentView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    {
        
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark -部分加载
-(UIButton *)btnClose {
    if (!_btnClose) {
        _btnClose = [UIButton new];
        [_btnClose addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnClose;
}
/** 全选按键 */
-(UIButton *)btnSeceltAll {
    if (!_btnSeceltAll) {
        _btnSeceltAll = [UIButton new];
        [_btnSeceltAll addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSeceltAll;
}
/** 确定按键 */
-(UIButton *)btnCallback {
    if (!_btnCallback) {
        _btnCallback = [UIButton new];
        [_btnCallback addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnCallback;
}

#pragma mark -数据初始化
-(void)dataInit {

}
-(void)ViewInit {
    //标题栏
    self.viewTitle = [UIView new];
    [self addSubview:self.viewTitle];
#if DEBUG
    self.viewTitle.backgroundColor = [UIColor blueColor];
#endif
    [self.viewTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(self.frame.size.height/5);
        make.width.mas_equalTo(self);
        make.top.mas_equalTo(self);
    }];
    //状态栏
    self.viewStatus = [UIView new];
    [self addSubview:self.viewStatus];
#if DEBUG
    self.viewStatus.backgroundColor = [UIColor blueColor];
#endif
    [self.viewStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(self.frame.size.height/4);
        make.width.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
    //表格
    self.tableview = [UITableView new];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self addSubview:self.tableview];
#if DEBUG
    self.tableview.backgroundColor = [UIColor greenColor];
#endif
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.viewTitle.mas_bottom);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(self);
        make.bottom.mas_equalTo(self.viewStatus.mas_top);
    }];
    //关闭按键
    [self.viewTitle addSubview:self.btnClose];
    [self.btnClose setImage:[UIImage imageNamed:@"关闭icon"] forState:UIControlStateNormal];
    [self.btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.viewTitle.mas_centerY);
        make.height.mas_equalTo(self.viewTitle.mas_height);
        make.width.mas_equalTo(self.btnClose.mas_height);
        make.right.mas_equalTo(self.viewTitle.mas_right);
    }];
    
    self.statusChildView = [UIView new];
    [self.viewStatus addSubview:self.statusChildView];
#if DEBUG
    self.statusChildView.backgroundColor = [UIColor whiteColor];
#endif
    [self.statusChildView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.viewStatus);
        make.height.mas_equalTo(self.viewStatus.mas_height).multipliedBy(.5);
        make.width.mas_equalTo(self.viewStatus);
        make.top.mas_equalTo(self.viewStatus.mas_top);
    }];
    
    [self.viewStatus addSubview:self.btnCallback];
    [self.btnCallback setTitle:@"确定" forState:UIControlStateNormal];
    self.btnCallback.backgroundColor = [UIColor redColor];
    [self.btnCallback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.viewStatus);
        make.height.mas_equalTo(self.viewStatus.mas_height).multipliedBy(.3);
        make.width.mas_equalTo(self.viewStatus).multipliedBy(.5);
        make.bottom.mas_equalTo(self.viewStatus.mas_bottom).with.offset(-5);
    }];
    
//三层
    [self.statusChildView addSubview:self.btnSeceltAll];
    [self.btnSeceltAll setImage:[UIImage imageNamed:@"未全选框"] forState:UIControlStateNormal];
    [self.btnSeceltAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.statusChildView.mas_centerY);
        make.height.mas_equalTo(self.statusChildView.mas_height);
        make.width.mas_equalTo(self.btnSeceltAll.mas_height);
        make.right.mas_equalTo(self.statusChildView.mas_right);
    }];
    UILabel *label = [UILabel new];
    label.text = @"全选";
    label.textAlignment = NSTextAlignmentCenter;
#if DEBUG
    label.backgroundColor = [UIColor yellowColor];
#endif
    [self.statusChildView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.statusChildView.mas_centerY);
        make.right.mas_equalTo(self.btnSeceltAll.mas_left);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    
}

#pragma mark -按键响应
/**
 关闭整个窗口
 */
-(void)close {
    [self removeFromSuperview];
}

#pragma mark -tableview
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell; //= [UITableView ]
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

@end
