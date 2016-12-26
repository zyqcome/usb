//
//  LoginController.m
//  TinyShop
//
//  Created by 韩舟昱 on 2016/12/21.
//  Copyright © 2016年 cc.zyqblog. All rights reserved.
//

#import "LoginController.h"
#import "NetworkTools.h"
#import "HomeController.h"
#import "DrawerController.h"
#import "DHControllerViewController.h"
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

//记住密码image

@property (weak, nonatomic) IBOutlet UIImageView *RPasswordImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *RPImagew;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *RPImageH;

//看密码image

@property (weak, nonatomic) IBOutlet UIImageView *lookPasswordImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rpImageH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rpImageW;

@property (nonatomic,assign) BOOL isLook;
@property (nonatomic,assign) BOOL isRemember;


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


    //高度设置
    _logoTop.constant =_logoTop.constant*ScreenScale;
    _firstRedViewTop.constant = _firstRedViewTop.constant * ScreenScale;
    _SecondRedViewTop.constant = _SecondRedViewTop.constant * ScreenScale;
    _thirdRedViewTop.constant = _thirdRedViewTop.constant * ScreenScale;
    //字体大小设置
    _storeLabel.font = [UIFont systemFontOfSize:23*ScreenScale];
    _jobNumberLabel.font = [UIFont systemFontOfSize:23*ScreenScale];
    _passwordLabel.font = [UIFont systemFontOfSize:23*ScreenScale];
    _rememberLabel.font = [UIFont systemFontOfSize:16*ScreenScale];
    //按钮图片大小设置
    _LoginHeight.constant = _LoginHeight.constant * ScreenScale;
    _LoginWidth.constant = _LoginWidth.constant * ScreenScale;
    _logoWidth.constant = _logoWidth.constant * ScreenScale;
    _logoHeight.constant = _logoHeight.constant * ScreenScale;
    _lookWidth.constant = _lookWidth.constant * ScreenScale;
    _lookHeight.constant = _lookHeight.constant * ScreenScale;
    _rememberButtonWidth.constant = _rememberButtonWidth.constant * ScreenScale;
    _rememberButtonHeight.constant = _rememberButtonHeight.constant * ScreenScale;
    //设置输入框字体大小
    _stroeTextField.font = [UIFont systemFontOfSize:23*ScreenScale];
    _jobNumberTextField.font = [UIFont systemFontOfSize:23*ScreenScale];
    _passwordTextField.font = [UIFont systemFontOfSize:23*ScreenScale];
    
    //
    _RPImagew.constant =  _RPImagew.constant*ScreenScale;
    _RPImageH.constant =  _RPImageH.constant *ScreenScale;
    _rpImageW.constant = _rpImageW.constant * ScreenScale;
    _rpImageH.constant = _rpImageH.constant *ScreenScale;
    
    //获取注册的账号和密码
    InitNSUserDefaults;
    if ([userDefaults boolForKey:@"isRemember"] == YES ) {
        _isRemember = YES;
        NSString*stroeTextField = [userDefaults objectForKey:@"stroeTextField"];
        NSString*jobNumberTextField = [userDefaults objectForKey:@"jobNumberTextField"];
        NSString * passwordTextField = [userDefaults objectForKey:@"passwordTextField"];
        [userDefaults synchronize];//立即同步存储
        
        _stroeTextField.text = stroeTextField;
        _jobNumberTextField.text = jobNumberTextField;
        _passwordTextField.text = passwordTextField;
        
        self.RPasswordImage.image = [UIImage imageNamed:@"记住密码"];
    }
    
 }

#pragma mark - 登录按钮
- (IBAction)loginButtonClicked:(UIButton *)sender {
    [self netRequest];
    
}
- (IBAction)LookPassword:(UIButton *)sender {
    _isLook = !_isLook;
    if (_isLook) {
        self.lookPasswordImage.image = [UIImage imageNamed:@"显示密码图标"];
        self.passwordTextField.secureTextEntry = NO;
    }else{
        self.lookPasswordImage.image = [UIImage imageNamed:@"隐藏密码图标.png"];
        self.passwordTextField.secureTextEntry = YES;
    }
    
    
    
}
- (IBAction)rememberPassword:(id)sender {
    InitNSUserDefaults;
    if (_isRemember == NO) {
                NSLog(@"yes");
        self.RPasswordImage.image = [UIImage imageNamed:@"记住密码"];
        [userDefaults setObject:self.stroeTextField.text forKey:@"stroeTextField"];
        [userDefaults setObject:self.jobNumberTextField.text forKey:@"jobNumberTextField"];
        [userDefaults setObject:self.passwordTextField.text forKey:@"passwordTextField"];
        [userDefaults synchronize];//立即同步存储
    }
    
    if (_isRemember == YES) {
        NSLog(@"no");
         [userDefaults setBool:NO forKey:@"isRemember"];
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:NSURLNameKey];
//        [[NSUserDefaults standardUserDefaults] synchronize];
        self.RPasswordImage.image = [UIImage imageNamed:@"记住密码框"];

    }
    _isRemember = !_isRemember;

}


#pragma mark - 网络请求

-(void)netRequest{
    
      NSDictionary * dict = @{@"client_type":@"ios",
                              @"client_version":@"2.0",
                              @"client_token":@"2a8242f0858bbbde9c5dcbd0a0008e5a",
                              @"shop_account":self.stroeTextField.text,
                              @"user_account":_jobNumberTextField.text,
                              @"user_password":_passwordTextField.text};
    
    [[NetworkTools sharedTooles]requestMethod:POST isJson:YES WithUrl:LoginUrl parematers:dict finished:^(id data, NSError *error) {
    if (error) {
        NSLog(@"%@",error);
        return ;
    }
    NSLog(@"%@",data);
    LoginViewMode *loginViewMode = [LoginViewMode shareUserInfo];
    loginViewMode.shop_account = self.stroeTextField.text;
    loginViewMode.user_account = _jobNumberTextField.text;
    [loginViewMode intwithDictionary:data];
        InitNSUserDefaults;
        if ([data[@"status"] isEqual: @"0"]) {
            //登录成功
            if (_isRemember == YES ) {
                [userDefaults setBool:YES forKey:@"isRemember"];
                
            }

            
        }
        
    //创建标签控制器
    DHControllerViewController * dhVC = [[DHControllerViewController alloc]init];
    [self presentViewController:dhVC animated:NO completion:nil];

        
    }];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self removeFromParentViewController];
    [self.view removeFromSuperview];
}


@end
