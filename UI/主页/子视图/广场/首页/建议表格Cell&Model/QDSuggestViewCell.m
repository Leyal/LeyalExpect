//
//  QDSuggestViewCell.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/22.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "QDSuggestViewCell.h"
#import "QDSuggestCell.h"
#import <AFNetworking.h>
#import "QDSuggestModel.h"
@interface QDSuggestViewCell()<UITableViewDelegate,UITableViewDataSource,QDSUGCellDelegate>
@property(nonatomic,strong) NSMutableArray * suggestArray;
@end
@implementation QDSuggestViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    _suggestArray = [[NSMutableArray alloc]init];
    [self loadSuggestData];
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor blackColor];
        _tabView = [[UITableView alloc]init];
        _tabView.delegate = self;
        _tabView.dataSource = self;
//        _tabView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//        _tabView.separatorInset = UIEdgeInsetsZero;
        _tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
//        _tabView.allowsSelection = NO;
//        _tabView.frame = self.bounds;
        [_tabView registerClass:[QDSuggestCell class] forCellReuseIdentifier:@"cell"];
        [self.contentView addSubview:_tabView];
        [_tabView mas_makeConstraints:^(MASConstraintMaker * make){
            make.left.equalTo(self);
            make.top.equalTo(self);
            make.width.equalTo(self);
            make.height.equalTo(self);
        }];
    }
    return self;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate QDSuggestVCTransform:indexPath];
}
//// 自绘分割线
//- (void)drawRect:(CGRect)rect
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//
//    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
//    CGContextFillRect(context, rect);
//
//    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0xE2/255.0f green:0xE2/255.0f blue:0xE2/255.0f alpha:1].CGColor);
//    CGContextStrokeRect(context, CGRectMake(0, rect.size.height - 1, rect.size.width, 1));
//}

#pragma mark 加载建议数据
-(void)loadSuggestData
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
    [manager GET:@"https://leancloud.cn:443/1.1/classes/Suggest" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nullable task,id  _Nullable responseObject)
     {
         NSLog(@"返回结果%@",responseObject);
         //将返回的数据专为json字典
         NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
         NSLog(@"Suggest>>>\n%@",dict);
         NSArray * temp =[QDSuggestModel mj_objectArrayWithKeyValuesArray:dict[@"results"]];
         [_suggestArray addObjectsFromArray:temp];
         [_tabView reloadData];
         
     }failure:^(NSURLSessionDataTask * _Nullable task, id _Nullable error)
     {
         NSLog(@"%@",error);
     }];
}
#pragma mark tabView代理和数据眼
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QDSuggestCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    cell.model = self.suggestArray[indexPath.row];
    cell.model = self.suggestArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = AppMainColor;
    NSLog(@"%@",_suggestArray);
    return cell;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70*HScale;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"建议数组元素个数\n%ld",_suggestArray.count);
    return _suggestArray.count;
//    return 3;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
