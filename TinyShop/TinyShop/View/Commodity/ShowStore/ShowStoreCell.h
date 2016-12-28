//
//  ShowStoreCell.h
//  TinyShop
//
//  Created by 韩舟昱 on 2016/12/28.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShowStoreCell;
@protocol redSwitchDelegate <NSObject>
-(void)selected:(ShowStoreCell * )cell redSwitch:(UISwitch*)redSwitch;


@end
@interface ShowStoreCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *redSwitch;
@property (nonatomic,assign)  id<redSwitchDelegate>  delegate;


@end
