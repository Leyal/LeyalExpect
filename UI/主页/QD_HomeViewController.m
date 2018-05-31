//
//  QD_HomeViewController.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/11.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "QD_HomeViewController.h"
#import "QD_homeVC.h"
#import "QD_dynamicVC.h"
#import "QD_suggestVC.h"
#import "HomeVC.h"
@interface QD_HomeViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong) UIImageView * customNavigationBar;
@property(nonatomic,strong) UIButton * moreButton;
@property(nonatomic,strong) UIButton * addButton;
@property(nonatomic,strong) UIButton * homeButton;
@property(nonatomic,strong) UIButton * dynamicButton;
@property(nonatomic,strong) UIButton * suggestButton;
@property(nonatomic,strong) UIImageView * titleView;
@property(nonatomic,strong) UIView * indiactorView;
@property(nonatomic,strong) UIScrollView * contentScrollView;
@property(nonatomic,strong) UIImageView * dividerView;
@property(nonatomic,strong) UILabel * indiactorLabel;
@end

@implementation QD_HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    [self setLayout];
}
#pragma mark 设置布局
-(void)setLayout
{   self.view.backgroundColor = [UIColor whiteColor];
    //自定义导航栏
    _customNavigationBar = [[UIImageView alloc]init];
//    _customNavigationBar.image = [UIImage imageNamed:@"custom_navigationBar"];
    _customNavigationBar.backgroundColor = titleColor;
//    _customNavigationBar.backgroundColor = [UIColor whiteColor];
    _customNavigationBar.userInteractionEnabled = YES;
    _customNavigationBar.frame = CGRectMake(0, 0, ScreenW, 94*HScale);
    
    //某一边加边框
    CALayer * boderLayer = [CALayer layer];
    boderLayer.frame = CGRectMake(0, 93.9*HScale, ScreenW, 0.1*HScale);
    boderLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    [_customNavigationBar.layer addSublayer:boderLayer];
    
    
    //贝塞尔曲线
//    UIBezierPath * bezier = [UIBezierPath bezierPathWithRoundedRect:_customNavigationBar.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(20, 20)];
//    CAShapeLayer * layer = [[CAShapeLayer alloc]init];
//    layer.frame = _customNavigationBar.bounds;
//    layer.path = bezier.CGPath;
//    _customNavigationBar.layer.mask = layer;
    [self.view addSubview:_customNavigationBar];
    
    
    //logo
    _titleView = [[UIImageView alloc]init];
    _titleView.image = [UIImage imageNamed:@"title_view"];
    [_customNavigationBar addSubview:_titleView];
    [_titleView mas_makeConstraints:^(MASConstraintMaker * make){
//        make.centerX.equalTo(_customNavigationBar);
        make.left.equalTo(_customNavigationBar.left).offset(11*WScale);
//        make.centerY.equalTo(_moreButton);
        make.top.equalTo(_customNavigationBar.top).offset(23*HScale);
        make.width.equalTo(24*WScale);
        make.height.equalTo(24*HScale);
    }];
    //指示文字
    _indiactorLabel = [[UILabel alloc]init];
    _indiactorLabel.textColor = [UIColor whiteColor];
    _indiactorLabel.text = @"首页";
    _indiactorLabel.font = [UIFont systemFontOfSize:14];
    [_customNavigationBar addSubview:_indiactorLabel];
    [_indiactorLabel mas_makeConstraints:^(MASConstraintMaker * make){
        make.left.equalTo(_titleView.right).offset(5*WScale);
        make.width.equalTo(40*WScale);
        make.centerY.equalTo(_titleView);
    }];
    //期待
    _dividerView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_logo"]];
    [_customNavigationBar addSubview:_dividerView];
    [_dividerView mas_makeConstraints:^(MASConstraintMaker * make){
        //        make.left.equalTo(_customNavigationBar.left);
//        make.centerX.equalTo(_customNavigationBar);
        make.right.equalTo(_customNavigationBar.right).offset(-11*WScale);
        make.width.equalTo(39*WScale);
        make.height.equalTo(18*HScale);
        make.centerY.equalTo(_titleView);
    }];
    //首页按钮
    _homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_homeButton setImage:[UIImage imageNamed:@"home_button"] forState:UIControlStateNormal];
//    [_homeButton setTitle:@"首页" forState:UIControlStateNormal];
//    [_homeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_homeButton setTitleColor:titleColor forState:UIControlStateSelected];
    [_homeButton setImage:[UIImage imageNamed:@"home_n"] forState:UIControlStateNormal];
    [_homeButton setImage:[UIImage imageNamed:@"home_h"] forState:UIControlStateSelected];
    [_homeButton addTarget:self action:@selector(homeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _homeButton.frame = CGRectMake(60*WScale, 55*HScale, 37*WScale, 25*HScale);
    [_customNavigationBar addSubview:_homeButton];
    
    //动态按钮
    _dynamicButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_dynamicButton setImage:[UIImage imageNamed:@"dynamic_button"] forState:UIControlStateNormal];
//    [_dynamicButton setTitle:@"动态" forState:UIControlStateNormal];
//    [_dynamicButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_dynamicButton setTitleColor:titleColor forState:UIControlStateSelected];
    [_dynamicButton setImage:[UIImage imageNamed:@"dynamic_n"] forState:UIControlStateNormal];
    [_dynamicButton setImage:[UIImage imageNamed:@"dynamic_h"] forState:UIControlStateSelected];
    [_dynamicButton addTarget:self action:@selector(dynamicButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_customNavigationBar addSubview:_dynamicButton];
    [_dynamicButton mas_makeConstraints:^(MASConstraintMaker * make){
        make.centerX.equalTo(_customNavigationBar);
        make.centerY.equalTo(_homeButton);
        make.width.equalTo(37*WScale);
        make.height.equalTo(25*HScale);
    }];
    
    //建议按钮
    _suggestButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_suggestButton setImage:[UIImage imageNamed:@"suggest_button"] forState:UIControlStateNormal];
//    [_suggestButton setTitle:@"建议" forState:UIControlStateNormal];
//    [_suggestButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_suggestButton setTitleColor:titleColor forState:UIControlStateSelected];
    [_suggestButton setImage:[UIImage imageNamed:@"suggest_n"] forState:UIControlStateNormal];
    [_suggestButton setImage:[UIImage imageNamed:@"suggest_h"] forState:UIControlStateSelected];
    [_suggestButton addTarget:self action:@selector(suggestButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _suggestButton.frame = CGRectMake(278*WScale, 55*HScale, 37*WScale, 25*HScale);
    [_customNavigationBar addSubview:_suggestButton];
    
    //指示器
    _indiactorView = [[UIView alloc]init];
//    _indiactorView.image = [UIImage imageNamed:@"indicator"];
    _indiactorView.backgroundColor = [UIColor whiteColor];
    _indiactorView.frame = CGRectMake(57*WScale, 84*HScale, 42*WScale, 1.2*HScale);
    [_customNavigationBar addSubview:_indiactorView];
    
    //子视图Scroll
    _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 94*HScale, ScreenW, ScreenH)];
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.delegate = self;
    _contentScrollView.showsVerticalScrollIndicator = NO;
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.bounces = NO;
    _contentScrollView.contentSize = CGSizeMake(ScreenW*3, 0);
    [self.view addSubview:_contentScrollView];
    
    //添加子视图
    QD_homeVC * homeVC = [[QD_homeVC alloc]init];
    [self addChildViewController:homeVC];
    
    QD_dynamicVC * dynamicVC = [[QD_dynamicVC alloc]init];
    [self addChildViewController:dynamicVC];
    
    QD_suggestVC * suggestVC = [[QD_suggestVC alloc]init];
    [self addChildViewController:suggestVC];
    
    [self scrollViewDidEndDecelerating:_contentScrollView];
    
    //将子控制器的视图添加到scroll
    for(int i=0;i<3;i++)
    {
        self.childViewControllers[i].view.frame = CGRectMake(i*ScreenW, 0, ScreenW, ScreenH);
        [_contentScrollView addSubview:self.childViewControllers[i].view];
    }
}
#pragma mark 点击更多按钮
-(void)moreButtonClick
{
    HomeVC * vc = [[HomeVC alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}
#pragma mark 点击首页按钮
-(void)homeButtonClick
{
    _homeButton.selected = YES;
    _dynamicButton.selected = NO;
    _suggestButton.selected = NO;
    [UIView animateWithDuration:0.2 animations:^{
        _indiactorView.frame = CGRectMake(57*WScale, 84*HScale, 42*WScale, 1.2*HScale);
        
    }];
    _contentScrollView.contentOffset = CGPointMake(0, 0);
    _indiactorLabel.text = @"首页";
}
#pragma mark 点击动态按钮
-(void)dynamicButtonClick
{
    _dynamicButton.selected = YES;
    _homeButton.selected = NO;
    _suggestButton.selected = NO;
    _indiactorLabel.text = @"动态";
    [UIView animateWithDuration:0.2 animations:^{
        _indiactorView.frame = CGRectMake(166*WScale, 84*HScale, 42*WScale, 1.2*HScale);
    }];
    
    _contentScrollView.contentOffset = CGPointMake(ScreenW, 0);
}
#pragma mark 点击建议按钮
-(void)suggestButtonClick
{
    _suggestButton.selected = YES;
    _homeButton.selected =NO;
    _dynamicButton.selected = NO;
    _indiactorLabel.text = @"建议";
    [UIView animateWithDuration:0.2 animations:^{
        _indiactorView.frame = CGRectMake(276*WScale, 84*HScale, 42*WScale, 1.2*HScale);
    }];
    
    _contentScrollView.contentOffset = CGPointMake(ScreenW*2, 0);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark scroll代理
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //scroll滚动到了哪个界面
    NSInteger i = scrollView.contentOffset.x/ScreenW;
    switch (i) {
        case 0:{
            _homeButton.selected = YES;
            _dynamicButton.selected = NO;
            _suggestButton.selected =NO;
            _indiactorLabel.text = @"首页";
            [UIView animateWithDuration:0.2 animations:^{
                _indiactorView.frame = CGRectMake(57*WScale, 84*HScale, 42*WScale, 1.2*HScale);
            }];
            _contentScrollView.contentOffset = CGPointMake(0, 0);}
            break;
        case 1:{
            _dynamicButton.selected = YES;
            _homeButton.selected = NO;
            _suggestButton.selected = NO;
            _indiactorLabel.text = @"动态";
            [UIView animateWithDuration:0.2 animations:^{
                _indiactorView.frame = CGRectMake(166*WScale, 84*HScale, 42*WScale, 1.2*HScale);
            }];
            _contentScrollView.contentOffset = CGPointMake(ScreenW, 0);}
            break;
        case 2:{
            _suggestButton.selected = YES;
            _homeButton.selected  =NO;
            _dynamicButton.selected  =NO;
            _indiactorLabel.text = @"建议";
            [UIView animateWithDuration:0.2 animations:^{
                _indiactorView.frame = CGRectMake(276*WScale, 84*HScale, 42*WScale, 1.2*HScale);
            }];
            _contentScrollView.contentOffset = CGPointMake(ScreenW*2, 0);
        }
            
            break;
            
        default:
            break;
    }
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
