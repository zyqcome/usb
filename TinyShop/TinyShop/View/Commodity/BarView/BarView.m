//
//  BarView.m
//  TinyShop
//
//  Created by 韩舟昱 on 2016/12/26.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import "BarView.h"
#import "GrayWhiteView.h"
#import "UIView+Addtions.h"
#import "ColorDefine.h"
#define BARCHART_BASE_TAG 4000

@interface BarView ()
//顶部总收入
@property(nonatomic, strong) UILabel* topLabel;
//
@property(nonatomic, strong) UIScrollView *scrollview;
//网格背景图
@property(nonatomic, strong) GrayWhiteView *backGrayView;
//时间label数组
@property(nonatomic, strong) NSMutableArray *titleLabelStore;
//最大收入
@property(nonatomic, assign) CGFloat maxValue;
//总收入
@property(nonatomic, assign) CGFloat sumValue;
//收入label数组
@property(nonatomic, strong) NSMutableArray *incomeLabelStore;
//button数组
@property(nonatomic, strong) NSMutableArray *buttonStore;
//柱状图数组
@property(nonatomic, strong) NSMutableArray *barStore;
//隐藏类型下标数组 [@(1),@(0),@(3)]
@property(nonatomic, strong) NSMutableArray *hiddenTypeIndexStore;
//隐藏类型字符串数组 [@"玉米",@"板栗",@"蛋挞"]
@property(nonatomic, strong) NSMutableArray *hiddenTypeStrString;
//收入高度
@property(nonatomic, assign) CGFloat incomeHeight;
//浮点位数 @"%.2f"
@property(nonatomic, copy) NSString *floatType;
@end

@implementation BarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.singleWidth = 60;
        self.bottomMargin = 20;
        self.incomeTopMargin = 60;
        self.incomeBottomMargin= 0;
        self.labelTransform = CGAffineTransformIdentity;
        self.selectIndex = -1;
        self.brefixStr = @"收入";
        self.suffixStr = @"";
        self.floatNumber = 0;
        self.barWidthPercent = 0.55;
    }
    return self;
}

#pragma mark- Getter
-(UILabel *)topLabel
{
    
    if (!_topLabel) {
        _topLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 25)];
        _topLabel.textColor = MAIN_COLOR;
        _topLabel.font = FONT(18);
        _topLabel.text = self.topTitleCallBack(self.sumValue);
    }
    return _topLabel;
}

- (UIScrollView *)scrollview
{
    
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 45, self.width, self.height-45)];
        _scrollview.contentSize = CGSizeMake(self.titleStore.count*(self.singleWidth+1)+1, _scrollview.height);
        _scrollview.tag = noDisableHorizontalScrollTag;
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, _scrollview.maxY-7, self.width, 4)];
        view.backgroundColor = LIGHTRED_COLOR;
        [self addSubview:view];
    }
    return _scrollview;
    
}
-(GrayWhiteView *)backGrayView
{
    if (!_backGrayView) {
        _backGrayView = [[GrayWhiteView alloc]initWithFrame:CGRectMake(0, 0, self.scrollview.contentSize.width, self.scrollview.height-self.bottomMargin)
                                                singleWidth:self.singleWidth
                                                      count:self.titleStore.count];
    }
    return _backGrayView;
}

- (NSMutableArray *)titleLabelStore
{
    if (!_titleLabelStore) {
        _titleLabelStore = [NSMutableArray array];
    }
    return _titleLabelStore;
}
-(NSMutableArray *)incomeLabelStore
{
    if (!_incomeLabelStore) {
        _incomeLabelStore = [NSMutableArray array];
    }
    return _incomeLabelStore;
}
-(NSMutableArray *)buttonStore
{
    if (!_buttonStore) {
        _buttonStore = [NSMutableArray array];
    }
    return _buttonStore;
}
-(NSMutableArray *)barStore
{
    if (!_barStore) {
        _barStore = [NSMutableArray array];
    }
    return _barStore;
}
-(NSMutableArray *)hiddenTypeStrString
{
    if (!_hiddenTypeStrString) {
        _hiddenTypeStrString = [NSMutableArray array];
    }
    return _hiddenTypeStrString;
}
-(NSMutableArray *)hiddenTypeIndexStore
{
    if (!_hiddenTypeIndexStore) {
        _hiddenTypeIndexStore = [NSMutableArray array];
    }
    return _hiddenTypeIndexStore;
}
#pragma mark- Setter
-(void)setFloatNumber:(NSUInteger)floatNumber
{
    _floatNumber = floatNumber;
    self.floatType = [NSString stringWithFormat:@"%%.%luf",self.floatNumber];
}
-(void)setAllTypes:(NSArray *)allTypes
{
    _allTypes = allTypes;
    [_hiddenTypeStrString removeAllObjects];
    [_hiddenTypeIndexStore removeAllObjects];
}
#pragma mark- calculate
- (void)calculate
{
    self.sumValue = 0;
    self.maxValue = 0;
    NSMutableArray *showType = [self.allTypes mutableCopy];
    //移除数组里的元素
    [showType removeObjectsInArray:self.hiddenTypeStrString];
    //防止循环引用
    __weak typeof(self) weakSelf = self;
    
    [self.incomeStore enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //返回字典中 对应key数组的value值，notFoundMarker如果没有找到key值 value值设置为0
        NSArray *allValues = [obj objectsForKeys:showType notFoundMarker:@"0"];
        //
        __block CGFloat sum = 0;
        //遍历 累加
        [allValues enumerateObjectsUsingBlock:^(NSString *  _Nonnull value, NSUInteger idx, BOOL * _Nonnull stop) {
            sum += value.floatValue;
        }];
        
        if (weakSelf.maxValue < sum) {
            weakSelf.maxValue = sum;
        }
        //总收入加起来
        weakSelf.sumValue += sum;
    }];
    //网格高度
    self.incomeHeight = self.backGrayView.height - self.incomeTopMargin -self.incomeBottomMargin;
}
- (CGPoint)pointByIndex:(NSUInteger)idx value:(CGFloat)value
{
    CGFloat centerX = 1+(self.singleWidth+1)*idx + self.singleWidth *0.5;
    CGFloat centerY = self.incomeTopMargin + self.incomeHeight*(1 - value/self.maxValue);
    if (self.maxValue == 0) {
    centerY = self.incomeTopMargin + self.incomeHeight;
    }
    
    return CGPointMake(centerX, centerY);
}
- (void)selectAllType
{
    [self.hiddenTypeStrString removeAllObjects];
    [self.hiddenTypeIndexStore removeAllObjects];
    [self reStrokePath];
}

//上面button隐藏下面小块
- (BOOL)hiddenOrShowTyped:(NSUInteger)typeIndex hiddenSign:(BOOL)sign
{
    if (sign) {
        if (self.hiddenTypeStrString.count + 1 == self.allTypes.count) {
            return NO;
        }
        [self.hiddenTypeStrString addObject:self.allTypes[typeIndex]];
        [self.hiddenTypeIndexStore addObject:@(typeIndex)];
    }else{
        [self.hiddenTypeStrString removeObject:self.allTypes[typeIndex]];
        [self.hiddenTypeIndexStore removeObject:@(typeIndex)];
    }
    
    [self reStrokePath];
    return YES;
}
#pragma mark- Storke
//隐藏或者显示一个类型时，重新刷新界面
- (void)reStrokePath
{
    //1。重新计算值
    [self calculate];
    //2.改变topLabel.text
    self.topLabel.text = self.topTitleCallBack(self.sumValue);
    [self.incomeStore enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger barIndex, BOOL * _Nonnull stop) {
        //3.每个b柱状图小块的高度
        __block CGFloat barIncome = 0 ;
        //每个bar所有小块的收入
        NSArray * allValues = [obj objectsForKeys:self.allTypes notFoundMarker:@"0"];
        //遍历
        [allValues enumerateObjectsUsingBlock:^(NSString *  _Nonnull value, NSUInteger typeIndex, BOOL * _Nonnull stop) {
            CGFloat height = 0;
            //如果隐藏下标数字不包含typeindex
            if (![self.hiddenTypeIndexStore containsObject:@(typeIndex)]) {
                height = [value floatValue]/self.maxValue * self.incomeHeight;
                if (self.maxValue == 0) {
                    height = 0;
                }
                barIncome += [value floatValue];
            }
            //取出对应的小块，改变高度
            UIView * view = [self.barStore[barIndex] objectAtIndex:typeIndex];
            //更新高度的约束
            [view mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(height);
            }];
        }];
        //改变收入字符串
        UILabel * label = self.incomeLabelStore[barIndex];
        NSString * type = [NSString stringWithFormat:@"%@\n%@%@",self.brefixStr,self.floatType,self.suffixStr];
        label.text = [NSString stringWithFormat:type,barIncome];
        
    }];
    
}
//绘图
- (void)storkePath
{
    [self calculate];
    //收入label
    [self addSubview:self.topLabel];
    [self addSubview:self.scrollview];
    [self.scrollview addSubview:self.backGrayView];
    //底部时间标签
    [self addTitleLabels];
    
    [self createBars];
}

#pragma mark- Storke Detial
- (void)addTitleLabels
{
    for (int i = 0; i < self.titleStore.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(1+(self.singleWidth+1)*i-10, self.backGrayView.height-30, self.singleWidth+20, 25)];
        label.text = self.titleStore[i];
        label.textColor = NORMALTEXTCOLOR;;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = FONT(14);
        label.transform = self.labelTransform;
        [self.scrollview addSubview:label];
        [self.titleLabelStore addObject:label];
    }
}

- (void)createBars
{
    [self.incomeStore enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger barIndex, BOOL * _Nonnull stop) {
        
        //1. 添加柱状图灰色背景图
        UIView *barGrayView =  [self addBarGrayView:barIndex];
        //2.添加每一个柱状图
        __block CGFloat barIncome = 0;
        //每个柱状图的小块
        NSMutableArray * singleBarStore = [NSMutableArray array];
        //第一个元素就是第一个柱状图的小块
        [self.barStore addObject:singleBarStore];
        //遍历收入
        NSArray * allValues = [obj objectsForKeys:self.allTypes notFoundMarker:@"0"];
        [allValues enumerateObjectsUsingBlock:^(NSString *   _Nonnull value, NSUInteger typeIndex, BOOL * _Nonnull stop) {
            //计算每个小块的高度
            CGFloat height = 0;
            //隐藏下标数组 不包含typeindex才显示
            if (![self.hiddenTypeIndexStore containsObject:@(typeIndex)]) {
            
                height = [value floatValue]/self.maxValue*self.incomeHeight;
                if (self.maxValue == 0) {
                    height = 0;
                }
                //记录收入
                barIncome += [value floatValue];
                
            }
            //2.1添加每个📊的小块
            [self addSingleBarWithHeight:height typeIndex:typeIndex barGrayView:barGrayView];
        }];
        
        //3. 添加收入
        [self addincomeLabel:barIncome barGrayView:barGrayView lastSingleBar:singleBarStore.lastObject];
        
        //4.添加button
        [self addButtonByIndex:barIndex];
        
    }];
}

- (UIView *)addBarGrayView:(NSUInteger)barIndex
{
    CGFloat w = self.singleWidth * self.barWidthPercent;
    CGFloat h = self.backGrayView.height-self.incomeTopMargin/2.0 - self.incomeBottomMargin;
    CGFloat centerX = 1+(self.singleWidth + 1)*barIndex + self.singleWidth *0.5;
    CGFloat y = self.incomeTopMargin/2.0;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(centerX-w/2.0, y , w , h)];
    view.backgroundColor = BACKGROUNDCOLOR;
    [self.backGrayView addSubview:view];
    return view;
}


- (void)addSingleBarWithHeight:(CGFloat)height
                     typeIndex:(NSUInteger)typeIndex
                   barGrayView:(UIView *)barGrayView
{
    //每个柱状图的小块数组
    NSMutableArray * singleBarStore = self.barStore.lastObject;
    //上一个view
    UIView * lastView = singleBarStore.lastObject;
    //
    UIView * currentView =[UIView new];
    currentView.backgroundColor = self.colorStore[typeIndex];
    [singleBarStore addObject:currentView];
    
    //添加约束
    [barGrayView addSubview:currentView];
    //添加约束
    [currentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(barGrayView.width, height));
        make.width.mas_equalTo(barGrayView);
        make.height.mas_equalTo(height);
        make.centerX.equalTo(barGrayView);
        if (typeIndex == 0) {
            make.bottom.equalTo(barGrayView);
        }else{
            make.bottom.equalTo(lastView.mas_top);
        }
    }];
}



- (void)addincomeLabel:(CGFloat)barIncome
           barGrayView:(UIView *)barGrayView
         lastSingleBar:(UIView *)lastSingleBar
{
    //1.创建
    UILabel *label = [[UILabel alloc]init];
    label.textColor = MAIN_COLOR;
    label.font = FONT(16);
    label.numberOfLines = 2;
    //收入%.2f元
    NSString *type = [NSString stringWithFormat:@"%@\n%@%@",self.brefixStr,self.floatType,self.suffixStr];
    label.text = [NSString stringWithFormat:type,barIncome];
    label.textAlignment = NSTextAlignmentCenter;
    [self.incomeLabelStore addObject:label];
    
    //添加约束
    [barGrayView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.singleWidth, 60));
        make.centerX.equalTo(barGrayView);
        make.bottom.equalTo(lastSingleBar.mas_top);
    }];
    //    label.backgroundColor = [UIColor orangeColor];
    //    barGrayView.layer.masksToBounds = YES;
    //    barGrayView.clipsToBounds = YES;
}

- (void)addButtonByIndex:(NSUInteger)index
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(1+(self.singleWidth +1)*index, 0, self.singleWidth, self.backGrayView.height+1);
    button.tag = BARCHART_BASE_TAG + index;
    [button addTarget:self action:@selector(selectForDetial:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonStore addObject:button];
    [self.backGrayView addSubview:button];
}

#pragma mark- Action

- (void)selectForDetial:(UIButton *)button
{
    self.selectIndex = button.tag - BARCHART_BASE_TAG;
    if (self.selectCallback) {
        self.selectCallback(self.selectIndex);
    }
}
@end

