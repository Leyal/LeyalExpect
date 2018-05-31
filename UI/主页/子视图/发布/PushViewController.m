//
//  PushViewController.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/25.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "PushViewController.h"
#import "PushDynamicVC.h"
#import "PushSuggestVC.h"
@interface PushViewController ()

@end

@implementation PushViewController
{
    UIView * pushNavigationBar;
    UIButton * backButton;
    UIButton * dynamicButton;
    UIButton * suggestButton;
    UIView * separatorLine;
    UIButton * pushButton;
    UIScrollView * homeScroll;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLayout];
}
#pragma mark 设置布局
-(void)setLayout
{
    self.view.backgroundColor = [UIColor whiteColor];
    //自定义导航栏
    pushNavigationBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 64*HScale)];
//    pushNavigationBar.backgroundColor = [UIColor RGB:200 andG:200 andB:200 alpha:1];
    pushNavigationBar.backgroundColor = titleColor;
    [self.view addSubview:pushNavigationBar];
    //返回按钮
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [pushNavigationBar addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker * make){
        make.top.equalTo(pushNavigationBar.top).offset(30*HScale);
        make.left.equalTo(pushNavigationBar.left).offset(9*WScale);
        make.width.equalTo(24*WScale);
        make.height.equalTo(17*WScale);
    }];
    //分割线
    separatorLine = [[UIView alloc]init];
    separatorLine.backgroundColor = [UIColor whiteColor];
    [pushNavigationBar addSubview:separatorLine];
    [separatorLine mas_makeConstraints:^(MASConstraintMaker * make){
        make.centerX.equalTo(pushNavigationBar);
        make.centerY.equalTo(backButton);
        make.width.equalTo(1*WScale);
        make.height.equalTo(17*HScale);
    }];
    
    //动态按钮
    dynamicButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [dynamicButton setTitle:@"动态" forState:UIControlStateNormal];
    [dynamicButton setTitle:@"动态" forState:UIControlStateSelected];
    dynamicButton.selected = YES;
    [dynamicButton addTarget:self action:@selector(dynamicButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [dynamicButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [dynamicButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    dynamicButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [pushNavigationBar addSubview:dynamicButton];
    [dynamicButton mas_makeConstraints:^(MASConstraintMaker * make){
        make.right.equalTo(separatorLine.left).offset(-10*WScale);
        make.centerY.equalTo(separatorLine);
        make.width.equalTo(38*WScale);
        make.height.equalTo(26*HScale);
    }];
    //建议按钮
    suggestButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [suggestButton setTitle:@"建议" forState:UIControlStateNormal];
    [suggestButton setTitle:@"建议" forState:UIControlStateSelected];
    [suggestButton addTarget:self action:@selector(suggestButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [suggestButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [suggestButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    suggestButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [pushNavigationBar addSubview:suggestButton];
    [suggestButton mas_makeConstraints:^(MASConstraintMaker * make){
        make.left.equalTo(separatorLine.right).offset(10*WScale);
        make.centerY.equalTo(separatorLine);
        make.width.equalTo(38*WScale);
        make.height.equalTo(26*HScale);
    }];
//    //发布按钮
//    pushButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [pushButton setTitle:@"发布" forState:UIControlStateNormal];
//    [pushButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [pushButton addTarget:self action:@selector(clickPushButton) forControlEvents:UIControlEventTouchUpInside];
//    pushButton.titleLabel.font = [UIFont systemFontOfSize:16];
//    [pushNavigationBar addSubview:pushButton];
//    [pushButton mas_makeConstraints:^(MASConstraintMaker * make){
//        make.right.equalTo(pushNavigationBar.right).offset(-5*WScale);
//        make.centerY.equalTo(separatorLine);
//        make.width.equalTo(38*WScale);
//        make.height.equalTo(26*HScale);
//    }];
   
    
    //添加子控制器
    PushDynamicVC * pushDynaicVC = [[PushDynamicVC alloc]init];
    [self addChildViewController:pushDynaicVC];
    
    PushSuggestVC * pushSuggestVC = [[PushSuggestVC alloc]init];
    [self addChildViewController:pushSuggestVC];
    
    //homeScroll
    homeScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64*HScale, ScreenW, ScreenH-64*HScale)];
    homeScroll.pagingEnabled = YES;
    homeScroll.showsVerticalScrollIndicator = NO;
    homeScroll.showsHorizontalScrollIndicator = NO;
    homeScroll.bounces = NO;
    homeScroll.scrollEnabled = NO;
    homeScroll.contentSize = CGSizeMake(ScreenW*2, 0);
    [self.view addSubview:homeScroll];
    
    //将子控制器的视图添加到scroll
//    for(int i=0;i<3;i++)
//    {
//        self.childViewControllers[i].view.frame = CGRectMake(i*ScreenW, 0, ScreenW, ScreenH);
//        [_contentScrollView addSubview:self.childViewControllers[i].view];
//    }
    for(int i = 0;i<2;i++)
    {
        self.childViewControllers[i].view.frame = CGRectMake(i*ScreenW, 0, ScreenW, ScreenH);
        [homeScroll addSubview:self.childViewControllers[i].view];
    }
}

#pragma mark 点击返回按钮
-(void)backButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 点击发布按钮
-(void)clickPushButton
{
    NSLog(@"代理点击");
    [self.delegate pushButtonClick];
}
#pragma mark 点击动态按钮
-(void)dynamicButtonClick
{
    dynamicButton.selected = YES;
    suggestButton.selected = NO;
    homeScroll.contentOffset = CGPointMake(0, 0);
}
#pragma mark 点击建议按钮
-(void)suggestButtonClick
{
    suggestButton.selected = YES;
    dynamicButton.selected = NO;
    homeScroll.contentOffset = CGPointMake(ScreenW, 0);
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
