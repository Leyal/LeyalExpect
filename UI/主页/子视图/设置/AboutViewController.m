//
//  AboutViewController.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/29.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "AboutViewController.h"
#import "CustomAboutTableViewCell.h"
@interface AboutViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation AboutViewController
{
    UIButton * backButton;
    UIImageView * img;
    UILabel * titleLabel;
    UIView * customNavigationBar;
    UITableView * tabView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLayout];
}
-(void)setLayout
{
    self.view.backgroundColor = [UIColor whiteColor];
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
    titleLabel.text = @"关于期待";
    titleLabel.font = [UIFont systemFontOfSize:16];
    [customNavigationBar addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker * make){
        make.centerY.equalTo(backButton);
        make.centerX.equalTo(customNavigationBar);
    }];
    
    img = [[UIImageView alloc]init];
    img.image = [UIImage imageNamed:@"about_image"];
    [self.view addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker * make){
        make.left.equalTo(self.view);
        make.width.equalTo(ScreenW);
        make.height.equalTo(ScreenH-64*HScale);
        make.top.equalTo(customNavigationBar.bottom);
    }];
    
//    tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64*HScale, ScreenW, ScreenH-64*HScale) style:UITableViewStylePlain];
//    tabView.delegate = self;
//    tabView.dataSource = self;
//    tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:tabView];
//    img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"about_image"]];
//    [self.view addSubview:img];
//    [img mas_makeConstraints:^(MASConstraintMaker * make){
//        make.left.equalTo(self);
//        make.width.equalTo(ScreenW);
//        make.height.equalTo(ScreenH);
//        make.top.equalTo(self);
//    }];
}
#pragma mark tabview代理和数据源
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        [tableView registerClass:[CustomAboutTableViewCell class] forCellReuseIdentifier:@"CustomAboutTableViewCell"];
        CustomAboutTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CustomAboutTableViewCell" forIndexPath:indexPath];
        cell.textLabel.text = @"官方网址";
        cell.alignRightLabel.text = @"www.leoleyal.com";
        cell.alignRightLabel.textColor = [UIColor blueColor];
        return cell;
    }
    else if (indexPath.row == 1)
    {
        [tableView registerClass:[CustomAboutTableViewCell class] forCellReuseIdentifier:@"CustomAboutTableViewCell"];
        CustomAboutTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CustomAboutTableViewCell" forIndexPath:indexPath];
        cell.textLabel.text = @"联系电话";
        cell.alignRightLabel.text = @"17721878902";
        cell.alignRightLabel.textColor = [UIColor darkGrayColor];
        return cell;
    }
    else if (indexPath.row == 2)
    {
        [tableView registerClass:[CustomAboutTableViewCell class] forCellReuseIdentifier:@"CustomAboutTableViewCell"];
        CustomAboutTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CustomAboutTableViewCell" forIndexPath:indexPath];
        cell.textLabel.text = @"公司地址";
        cell.alignRightLabel.text = @"成都市都江堰市东软学院";
        cell.alignRightLabel.textColor = [UIColor blueColor];
        return cell;
    }
    return nil;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50*HScale;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
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
