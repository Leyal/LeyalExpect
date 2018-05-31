//
//  QDCollectionTableViewCell.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/22.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "QDCollectionTableViewCell.h"
#import "QD_collectionCell.h"
#import <AFNetworking.h>
#import "CollectionViewModel.h"
#import "QDDetailVC.h"
@interface QDCollectionTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource,QDCollectionViewSelectDelegate>

@end

@implementation QDCollectionTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    //初始化数组
    _adImageArray = [[NSMutableArray alloc]init];
    [self loadData];
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(123*WScale, 153*HScale);
        layout.minimumInteritemSpacing = .3f;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.bounces = NO;
        [_collectionView registerClass:[QD_collectionCell class] forCellWithReuseIdentifier:@"collectionID"];
        [self.contentView addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker * make){
            make.left.equalTo(self);
            make.width.equalTo(self);
            make.top.equalTo(self);
            make.height.equalTo(self);
        }];
    }
    return self;
}
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
    [manager GET:@"https://leancloud.cn:443/1.1/classes/Leyal" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nullable task,id  _Nullable responseObject)
     {
//         NSLog(@"返回结果%@",responseObject);
         //将返回的数据专为json字典
         NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
//         NSLog(@"dict>>>\n%@",dict);
         NSArray * temp =[CollectionViewModel mj_objectArrayWithKeyValuesArray:dict[@"results"]];
         [_adImageArray addObjectsFromArray:temp];
         [_collectionView reloadData];
         
     }failure:^(NSURLSessionDataTask * _Nullable task, id _Nullable error)
     {
         NSLog(@"%@",error);
     }];
}
#pragma mark collectionView代理、数据源
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _adImageArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    QD_collectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionID" forIndexPath:indexPath];
    //刷新数据
    cell.model = self.adImageArray[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.row);
    // 判断代理对象是否实现这个方法，没有实现会导致崩溃
    if([_delegate respondsToSelector:@selector(TransformVC:)])
    {
        [_delegate TransformVC:indexPath];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
