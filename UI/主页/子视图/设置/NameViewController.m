//
//  NameViewController.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/29.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "NameViewController.h"

@interface NameViewController ()

@end

@implementation NameViewController
{
    UIButton * backButton;
    UIButton * setButton;
    UILabel * titleLabel;
    UIView * customNavigationBar;
    UITextField * textFiled;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    
    customNavigationBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 64*HScale)];
    customNavigationBar.backgroundColor =titleColor;
    [self.view addSubview:customNavigationBar];
    
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [customNavigationBar addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker * make){
        make.top.equalTo(customNavigationBar.top).offset(30*HScale);
        make.left.equalTo(customNavigationBar.left).offset(9*WScale);
        make.width.equalTo(24*WScale);
        make.height.equalTo(17*WScale);
    }];
    
    titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"昵称";
    titleLabel.font = [UIFont systemFontOfSize:16];
    [customNavigationBar addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker * make){
        make.centerY.equalTo(backButton);
        make.centerX.equalTo(customNavigationBar);
    }];
    
    setButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [setButton setTitle:@"修改" forState:UIControlStateNormal];
    setButton.titleLabel.textColor = [UIColor whiteColor];
    [setButton addTarget:self action:@selector(setButtonClick) forControlEvents:UIControlEventTouchUpInside];
    setButton.titleLabel.font= [UIFont systemFontOfSize:16];
    [customNavigationBar addSubview:setButton];
    [setButton mas_makeConstraints:^(MASConstraintMaker * make){
        make.centerY.equalTo(backButton);
        make.right.equalTo(customNavigationBar.right).offset(-9*WScale);
    }];
    
    textFiled = [[UITextField alloc]init];
    [self.view addSubview:textFiled];
    textFiled.placeholder = @"输入昵称";
    textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    textFiled.backgroundColor = [UIColor lightGrayColor];
    textFiled.text = _name;
    [textFiled mas_makeConstraints:^(MASConstraintMaker * make){
        make.left.equalTo(self.view.left);
        make.width.equalTo(ScreenW);
        make.height.equalTo(40);
        make.top.equalTo(customNavigationBar.bottom).offset(20*HScale);
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [textFiled resignFirstResponder];
}
-(void)backButtonClick
{
    self.changeName(textFiled.text);
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setButtonClick
{
    self.changeName(textFiled.text);
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:textFiled.text forKey:@"name"];
    [defaults synchronize];
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
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
