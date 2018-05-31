//
//  QDSuggestDetailVC.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/24.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "QDSuggestDetailVC.h"
#import "CustomNavigationBar.h"
#import "QDSuggestTableViewCell.h"
@interface QDSuggestDetailVC ()<CustomNavigationBarDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation QDSuggestDetailVC
{
    CustomNavigationBar * customNavigationBar;
    UITableView * QDSuggestDetailTableView;
    NSMutableArray * suggestDetailArray;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLayout];
    
    
}
#pragma mark 布局
-(void)setLayout
{
    suggestDetailArray = [[NSMutableArray alloc]init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //自定义导航栏
    customNavigationBar = [[CustomNavigationBar alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 64*HScale) backgroundColor:titleColor titleFont:[UIFont systemFontOfSize:19] title:@"建议详情"];
    customNavigationBar.delegate = self;
    [self.view addSubview:customNavigationBar];
    //
    QDSuggestDetailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64*HScale, ScreenW, ScreenH-64*HScale) style:UITableViewStylePlain];
    QDSuggestDetailTableView.delegate = self;
    QDSuggestDetailTableView.dataSource = self;
    QDSuggestDetailTableView.allowsSelection = NO;
    QDSuggestDetailTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    [QDSuggestDetailTableView registerClass:[QDSuggestTableViewCell class] forCellReuseIdentifier:@"QDSuggestTableViewCell"];
    [self.view addSubview:QDSuggestDetailTableView];

    
    
    
}
#pragma mark TableView代理和数据源
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QDSuggestTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QDSuggestTableViewCell" forIndexPath:indexPath];
    [cell.icon sd_setImageWithURL:[NSURL URLWithString:self.model.iconUrl]];
    cell.nameLabel.text = self.model.name;
    [cell.image sd_setImageWithURL:[NSURL URLWithString:self.model.imgUrl]];
    cell.timeLabel.text= self.model.time;
    cell.titleLabel.text = self.model.title;
    cell.contentLabel.text = self.model.content;
    
    NSString * cnt = self.model.content;
    NSDictionary * attr2 = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
    CGFloat x = [UIScreen mainScreen].bounds.size.width - 5;
    CGSize contentSize = [cnt boundingRectWithSize:CGSizeMake(x, MAXFLOAT) options:
                          NSStringDrawingUsesLineFragmentOrigin attributes:attr2 context:nil].size;
    CGFloat contentH = contentSize.height;
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 650;
}
#pragma mark 返回代理
-(void)transformVC
{
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
