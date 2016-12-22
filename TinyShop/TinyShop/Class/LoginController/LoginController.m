//
//  LoginController.m
//  TinyShop
//
//  Created by 韩舟昱 on 2016/12/21.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import "LoginController.h"
#import "NetworkTools.h"

@interface LoginController ()
//iphone7为110
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logoTop;
//94
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstRedViewTop;
//60
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *SecondRedViewTop;
//60
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *thirdRedViewTop;
//loginButton约束
//50
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LoginHeight;
//325
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LoginWidth;

//logo约束 150*110
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logoWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logoHeight;

//三个label
@property (weak, nonatomic) IBOutlet UILabel *storeLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;

//记住密码 font 16    25*25
@property (weak, nonatomic) IBOutlet UILabel *rememberLabel;
@property (weak, nonatomic) IBOutlet UIButton *rememberButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rememberButtonWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rememberButtonHeight;


//查看宽高  30*18
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lookHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lookWidth;
//输入框
@property (weak, nonatomic) IBOutlet UITextField *stroeTextField;
@property (weak, nonatomic) IBOutlet UITextField *jobNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;



@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
}
#pragma mark - ui设置约束
//约束设置颜色
-(void)setupUI{
    _stroeTextField.textColor = Color_RGBA(240, 0, 0, 1);
    _jobNumberTextField.textColor = Color_RGBA(240, 0, 0, 1);
    _passwordTextField.textColor = Color_RGBA(240, 0, 0, 1);
    
    
    if (Screen_W == 320){
        //高度设置
        _logoTop.constant = 80;
        _firstRedViewTop.constant = 85;
        _SecondRedViewTop.constant = 50;
        _thirdRedViewTop.constant = 50;
        //字体大小设置
        _storeLabel.font = [UIFont systemFontOfSize:19];
        _jobNumberLabel.font = [UIFont systemFontOfSize:19];
        _passwordLabel.font = [UIFont systemFontOfSize:19];
        _rememberLabel.font = [UIFont systemFontOfSize:14];
        //按钮图片大小设置
        _LoginHeight.constant = 43;
        _LoginWidth.constant = 270;
        _logoWidth.constant = 130;
        _logoHeight.constant = 90;
        _lookWidth.constant = 25;
        _lookHeight.constant = 15;
        _rememberButtonWidth.constant = 22;
        _rememberButtonHeight.constant = 22;
        //设置输入框字体大小
        _stroeTextField.font = [UIFont systemFontOfSize:19];
        _jobNumberTextField.font = [UIFont systemFontOfSize:19];
        _passwordTextField.font = [UIFont systemFontOfSize:19];
        
    }
    
    if (Screen_W == 414) {
        //高度设置
        _logoTop.constant = 110;
        _firstRedViewTop.constant = 100;
        _SecondRedViewTop.constant = 65;
        _thirdRedViewTop.constant = 65;
        //字体大小设置
        _storeLabel.font = [UIFont systemFontOfSize:24];
        _jobNumberLabel.font = [UIFont systemFontOfSize:24];
        _passwordLabel.font = [UIFont systemFontOfSize:24];
        _rememberLabel.font = [UIFont systemFontOfSize:18];
        //按钮图片大小设置
        _LoginHeight.constant = 56;
        _LoginWidth.constant = 360;
        _logoWidth.constant = 170;
        _logoHeight.constant = 130;
        _lookWidth.constant = 35;
        _lookHeight.constant = 20;
        _rememberButtonWidth.constant = 30;
        _rememberButtonHeight.constant = 30;
        //设置输入框字体大小
        _stroeTextField.font = [UIFont systemFontOfSize:24];
        _jobNumberTextField.font = [UIFont systemFontOfSize:24];
        _passwordTextField.font = [UIFont systemFontOfSize:24];
    }
}

#pragma mark - 登录按钮
- (IBAction)loginButtonClicked:(UIButton *)sender {
    [self netRequest];
    
}


#pragma mark - 网络请求

-(void)netRequest{
    NSDictionary * dict = @{@"client_type":@"ios",@"client_version":@"2.0",@"client_token":@"2a8242f0858bbbde9c5dcbd0a0008e5a",@"shop_account":@"ymtxtshg",@"user_account":@"001",@"user_password":@"12345678"};
    
    [[NetworkTools sharedTooles]requestMethod:POST isJson:YES WithUrl:LoginUrl parematers:dict finished:^(id data, NSError *error) {
    if (error) {
        NSLog(@"%@",error);
        return ;
    }
    NSLog(@"%@",data);
    }];
    
    
    
    
    
}



@end
