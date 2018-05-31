//
//  QD_suggestVC.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/11.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "QD_suggestVC.h"
#import "QDSuggestTableViewCell.h"
#import <AFNetworking.h>
#import "QDSuggestTabviewModel.h"
#import "QDDIYHeader.h"
@interface QD_suggestVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView * suggestTableView;
@property(nonatomic,strong) NSArray * suggestArray;
@end

@implementation QD_suggestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLayout];
    [self loadData];
    // Do any additional setup after loading the view.
}
#pragma mark 设置布局
-(void)setLayout
{
    _suggestArray = [[NSMutableArray alloc]init];
    
    _suggestTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _suggestTableView.backgroundColor= [UIColor RGB:234 andG:234 andB:234 alpha:1];
    _suggestTableView.delegate = self;
    _suggestTableView.dataSource = self;
    _suggestTableView.allowsSelection = NO;
    _suggestTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.suggestTableView.mj_header = [QDDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.suggestTableView.mj_header beginRefreshing];
    [_suggestTableView registerClass:[QDSuggestTableViewCell class] forCellReuseIdentifier:@"QDSuggestTableViewCell"];
    [self.view addSubview:_suggestTableView];
    [_suggestTableView mas_makeConstraints:^(MASConstraintMaker * make){
        make.left.equalTo(self.view.left);
        make.top.equalTo(self.view.tag);
        make.width.equalTo(ScreenW);
        make.height.equalTo(ScreenH-135*HScale);
    }];
}
#pragma mark TableView代理和数据源
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QDSuggestTableViewCell * cell  = [[QDSuggestTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QDSuggestTableViewCell"];
    cell.model = _suggestArray[indexPath.row];
    cell.model.cellHeight = [cell getCellHeight];
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QDSuggestTabviewModel * model = _suggestArray[indexPath.row];
    return model.cellHeight;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _suggestArray.count;
}
#pragma mark 请求数据
-(void)loadData
{
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
    [manager GET:@"https://leancloud.cn:443/1.1/classes/QDHomeSuggest" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nullable task,id  _Nullable responseObject)
     {
//         NSLog(@"返回结果%@",responseObject);
         //将返回的数据专为json字典
         NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
//         NSLog(@"Suggest>>>\n%@",dict);
         NSArray * temp =[QDSuggestTabviewModel mj_objectArrayWithKeyValuesArray:dict[@"results"]];
         NSMutableArray * a = [[NSMutableArray alloc]init];
         [a addObjectsFromArray:temp];
         _suggestArray = [[a reverseObjectEnumerator]allObjects];
         [_suggestTableView reloadData];
         [self.suggestTableView.mj_header endRefreshing];
     }failure:^(NSURLSessionDataTask * _Nullable task, id _Nullable error)
     {
         [self.suggestTableView.mj_header endRefreshing];
         NSLog(@"%@",error);
     }];
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
