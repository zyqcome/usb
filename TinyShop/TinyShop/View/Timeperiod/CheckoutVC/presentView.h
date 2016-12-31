//
//  presentView.h
//  TinyShop
//
//  Created by rimi on 16/12/27.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface shopShow : NSObject
@property (nonatomic,strong)NSString *shopname;
@property (nonatomic,strong)NSString *shopid;
@property (nonatomic,assign)BOOL showIs;
@end


@interface presentView : UIView


/** 表格选择数组 */
@property (nonatomic,strong)NSArray<shopShow *> *shopshowArry;

/**
 显示初始化

 @param arry 店铺数组
 */
-(void)ViewInit:(NSArray *)arry;

@end
