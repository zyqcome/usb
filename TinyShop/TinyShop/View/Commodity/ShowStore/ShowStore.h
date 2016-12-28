//
//  ShowStore.h
//  TinyShop
//
//  Created by 韩舟昱 on 2016/12/28.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShowStore;

@protocol ShowShoreDelegate <NSObject>
-(void)selectedButton:(UIButton*)button;
-(void)selectedSwitch:(UISwitch*)redSwitch;
@end
@interface ShowStore : UIView
//传出外界赋值每个cell的数组,显示的位置在哪
- (id)initWithStoreFrame:(CGRect)frame items:(NSArray <NSString *> *)items;
//block传出点击方法
@property (copy, nonatomic) void(^selectBlock)(ShowStore *view, NSInteger index);
@property (nonatomic,assign)  id<ShowShoreDelegate>  delegate;

- (void)selectBlock:(void(^)(ShowStore *view, NSInteger index))block;

- (void)showStoreView;
- (void)dismissStoreView;

@end
