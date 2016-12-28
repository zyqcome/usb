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
@property (nonatomic,assign)BOOL showIs;
@end


@interface presentView : UIView

/** 表格选择数组 */
@property (nonatomic,strong)NSArray<shopShow *> *shopshowArry;
-(void)ViewInit;

@end
