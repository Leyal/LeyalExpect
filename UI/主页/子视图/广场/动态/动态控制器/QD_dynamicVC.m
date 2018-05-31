//
//  QD_dynamicVC.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/11.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "QD_dynamicVC.h"
#import "QDDynamicTabViewCell.h"
#import <AFNetworking.h>
#import "QDDynamicTabViewCellModel.h"
#import <MJRefresh/MJRefresh.h>
#import "QDDIYHeader.h"
//#import "QDDIYHeader.h"
@interface QD_dynamicVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView * dynamicTabView;
@end

@implementation QD_dynamicVC
{
    NSArray * modelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    modelArray = [[NSMutableArray alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dynamicTabView.backgroundColor = [UIColor whiteColor];
//    self.dynamicTabView.mj_header.automaticallyChangeAlpha = YES;
    [self setLayout];
    [self loadData];
    
}
#pragma mark 下拉刷新
-(void)ReloadData
{
    NSLog(@"刷新数据");
    //1.创建请求会话管理者
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer new];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    //请求头
    [manager.requestSerializer setValue:@"BA69fJYBSxVp9ty8eiWHg9f0-gzGzoHsz"forHTTPHeaderField:@"X-LC-Id"];
    [manager.requestSerializer setValue:@"6cOvO8wLMOJIOtk5kEfyazUz"forHTTPHeaderField:@"X-LC-Key"];
    [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Content-Type"];
    //3、请求数据
    [manager GET:@"https://leancloud.cn:443/1.1/classes/Dynamic" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nullable task,id  _Nullable responseObject)
     {
         //将返回的数据专为json字典
         NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
         NSArray * temp =[QDDynamicTabViewCellModel mj_objectArrayWithKeyValuesArray:dict[@"results"]];
         NSMutableArray * a = [[NSMutableArray alloc]init];
         [a addObjectsFromArray:temp];
         modelArray = [[a reverseObjectEnumerator]allObjects];
         //         [modelArray addObjectsFromArray:temp];
         [_dynamicTabView reloadData];
         [self.dynamicTabView.mj_header endRefreshing];
         //         [_QDProgressHUD removeFromSuperview];
     }failure:^(NSURLSessionDataTask * _Nullable task, id _Nullable error)
     {
         [self.dynamicTabView.mj_header endRefreshing];
         NSLog(@"%@",error);
     }];
}
#pragma mark 加载布局
-(void)setLayout
{
    _dynamicTabView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _dynamicTabView.delegate = self;
    _dynamicTabView.dataSource = self;
//    _dynamicTabView.bounces = NO;
    _dynamicTabView.showsVerticalScrollIndicator = NO;
    _dynamicTabView.allowsSelection = NO;
//    _dynamicTabView.backgroundColor = [UIColor RGB:241 andG:121 andB:148 alpha:1];
    _dynamicTabView.backgroundColor = [UIColor whiteColor];
    _dynamicTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_dynamicTabView registerClass:[QDDynamicTabViewCell class] forCellReuseIdentifier:@"QDDynamicTabViewCell"];
    [self.view addSubview:_dynamicTabView];
    [_dynamicTabView mas_makeConstraints:^(MASConstraintMaker * make){
        make.left.equalTo(self.view.left);
        make.top.equalTo(self.view.top);
        make.width.equalTo(self.view);
        make.height.equalTo(ScreenH-140*HScale);
//        make.height.equalTo(ScreenH-200*HScale);
    }];
    self.dynamicTabView.mj_header = [QDDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.dynamicTabView.mj_header beginRefreshing];
//    self.tableView.allowsSelection = NO;
//    self.tableView.showsHorizontalScrollIndicator = NO;
//    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
//    self.tableView.backgroundColor = [UIColor lightGrayColor];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    self.tableView.bounces = NO;
//    [self.tableView registerClass:[QDDynamicTabViewCell class] forCellReuseIdentifier:@"QDDynamicTabViewCell"];
}
#pragma mark 加载数据
-(void)loadData
{
    //1.创建请求会话管理者
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    //2.拼接参数
    //    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    //    parameters[@"a"] = @"list";
    //    parameters[@"c"] = @"data";
    //    parameters[@"type"] = @(41);
    manager.requestSerializer = [AFJSONRequestSerializer new];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    //请求头
    [manager.requestSerializer setValue:@"BA69fJYBSxVp9ty8eiWHg9f0-gzGzoHsz"forHTTPHeaderField:@"X-LC-Id"];
    [manager.requestSerializer setValue:@"6cOvO8wLMOJIOtk5kEfyazUz"forHTTPHeaderField:@"X-LC-Key"];
    [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Content-Type"];
    //3、请求数据
    [manager GET:@"https://leancloud.cn:443/1.1/classes/Dynamic" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nullable task,id  _Nullable responseObject)
     {
         //将返回的数据专为json字典
         NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
         NSArray * temp =[QDDynamicTabViewCellModel mj_objectArrayWithKeyValuesArray:dict[@"results"]];
         NSMutableArray * a = [[NSMutableArray alloc]init];
         [a addObjectsFromArray:temp];
         modelArray = [[a reverseObjectEnumerator]allObjects];
//         [modelArray addObjectsFromArray:temp];
         [_dynamicTabView reloadData];
//         [_QDProgressHUD removeFromSuperview];
         [self.dynamicTabView.mj_header endRefreshing];
     }failure:^(NSURLSessionDataTask * _Nullable task, id _Nullable error)
     {
         NSLog(@"%@",error);
     }];
}
#pragma mark UITabView代理和数据源
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QDDynamicTabViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QDDynamicTabViewCell" forIndexPath:indexPath];
    cell.model = modelArray[indexPath.row];
    cell.model.cellHeight = [cell getCellHeight];
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return 100;
    QDDynamicTabViewCellModel * model = modelArray[indexPath.row];
    return model.cellHeight;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return modelArray.count;
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
