//
//  LoginViewController.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/12/13.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginVC.h"
#import "RegisterVC.h"
@interface LoginViewController ()
@property(nonatomic,strong) UIButton * loginButton;
@property(nonatomic,strong) UIButton * registerButton;
@property(nonatomic,strong) UIImageView * separatorLine;
@property(nonatomic,strong) UIScrollView * mainScrollView;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    [self addSubViews];
    [self setUpUI];
}
#pragma mark 懒加载
-(UIButton *)loginButton
{
    if(!_loginButton)
    {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        _loginButton.selected = YES;
        [_loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

-(UIButton *)registerButton
{
    if(!_registerButton)
    {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

-(UIView *)separatorLine
{
    if(!_separatorLine)
    {
        _separatorLine = [[UIImageView alloc]init];
        _separatorLine.image = [UIImage imageNamed:@"separatorline"];
        _separatorLine.backgroundColor = [UIColor whiteColor];
    }
    return _separatorLine;
}

-(UIScrollView *)mainScrollView
{
    if(!_mainScrollView)
    {
        _mainScrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.contentSize = CGSizeMake(ScreenW*2, 0);
        _mainScrollView.scrollEnabled = NO;
        _mainScrollView.bounces = NO;
    }
    return _mainScrollView;
}
#pragma mark 添加子视图
-(void)addSubViews
{
    //放到最顶层
    [self.view insertSubview:self.loginButton atIndex:0];
    [self.view insertSubview:self.registerButton atIndex:0];
    [self.view insertSubview:self.separatorLine atIndex:0];
    
//    [self.view addSubview:self.mainScrollView];
    [self.view insertSubview:self.mainScrollView atIndex:1];
    
    LoginVC * loginVC = [[LoginVC alloc]init];
    [self addChildViewController:loginVC];
    RegisterVC * registerVC = [[RegisterVC alloc]init];
    [self addChildViewController:registerVC];
    for(int i=0;i<2;i++)
    {
        self.childViewControllers[i].view.frame = CGRectMake(ScreenW*i, 0, ScreenW, ScreenH);
        [self.mainScrollView addSubview:self.childViewControllers[i].view];
    }
}

-(void)setUpUI
{
    [self.separatorLine mas_makeConstraints:^(MASConstraintMaker * make){
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(33*HScale);
        make.width.equalTo(1*WScale);
        make.height.equalTo(16*HScale);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker * make){
        make.centerY.equalTo(self.separatorLine);
        make.right.equalTo(self.separatorLine.left).offset(-8*WScale);
        make.width.equalTo(40*WScale);
        make.height.equalTo(28*HScale);
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker * make){
        make.centerY.equalTo(self.separatorLine);
        make.left.equalTo(self.separatorLine.right).offset(8*WScale);
        make.width.equalTo(40*WScale);
        make.height.equalTo(28*HScale);
    }];
}
#pragma mark 点击事件
-(void)loginButtonClick
{
    self.mainScrollView.contentOffset = CGPointMake(0, 0);
    self.loginButton.selected = YES;
    self.registerButton.selected = NO;
}

-(void)registerButtonClick
{
    self.mainScrollView.contentOffset = CGPointMake(ScreenW, 0);
    self.loginButton.selected = NO;
    self.registerButton.selected = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
