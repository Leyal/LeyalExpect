//
//  QD_homeVC.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/11.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "QD_homeVC.h"
#import "JECalourseView.h"
#import "QD_collectionCell.h"
#import <SDImageCache.h>
#import <AFNetworking.h>
#import "CollectionViewModel.h"
#import "QDDetailVC.h"
#import "QDSuggestModel.h"
#import "QDThreeDTabCell.h"
#import "QDCollectionTableViewCell.h"
#import "QDSuggestViewCell.h"
#import "QDRecommendCell.h"
#import "QDRecommendReadCell.h"
#import "UIImage+GIFImage.h"
#import "QDVideoTabViewCell.h"
#import "QDRecoomendVideoCell.h"
#import "QDSuggestDetailVC.h"
#import "QDVideoModel.h"
#import <VKVideoPlayerViewController.h>
#import "UIImage+ToData.h"
#import "TaoBaoViewController.h"
@interface QD_homeVC ()<UITableViewDelegate,UITableViewDataSource,QDCollectionViewSelectDelegate,QDSUGCellDelegate,QDVideoCollectionCellDelegate,ThreeDDelegate>
@property(nonatomic,strong) JECalourseView * verticalScrollView;
@property(nonatomic,strong) UIScrollView * homeScrollView;
@property(nonatomic,strong) UIScrollView * otherScrollView;
@property(nonatomic,strong) UIImageView * dividerLine1;
@property(nonatomic,strong) UIImageView * dividerLine2;
@property(nonatomic,strong) UICollectionView * collectionView;
@property(nonatomic,strong) NSMutableArray * adImageArray;
@property(nonatomic,strong) UIImageView * recommendView;
@property(nonatomic,strong) NSMutableArray * objectIdArray;
@property(nonatomic,strong) UIImageView * suggestView;
@property(nonatomic,strong) UITableView * suggestTableView;

@property(nonatomic,strong) NSMutableArray * suggestArray;
@property(nonatomic,strong) NSMutableArray * videoArray;


@property(nonatomic,strong) UITableView * homeTabView;

@property(nonatomic,strong) UIImageView * QDProgressHUD;
@end

@implementation QD_homeVC
static NSString *ID = @"cell";
-(void)TotaoBao
{
    TaoBaoViewController * vc = [[TaoBaoViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _QDProgressHUD = [[UIImageView alloc]initWithImage:[UIImage imageWithGIFNamed:@"gif"]];
    _QDProgressHUD.frame = self.view.bounds;
    [[[UIApplication sharedApplication].delegate window]addSubview:_QDProgressHUD];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLayout];
    [self loadImageUrl];
    [self loadSuggestData];
    [self loadVideoData];
//    [self setUserDefaults];
    _adImageArray = [[NSMutableArray alloc]init];
    _suggestArray = [[NSMutableArray alloc]init];
    _videoArray = [[NSMutableArray alloc]init];
//    [self performSelector:@selector(removeQDProgressHUD) withObject:nil afterDelay:2];
}
-(void)setUserDefaults
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * name = @"绣斑猫";
    UIImage * icon = [UIImage imageNamed:@"3dimg2"];
    [userDefaults setObject:name forKey:@"name"];
    NSData * iconData = UIImageJPEGRepresentation(icon, 100);
//    [userDefaults setObject:[UIImage getDataFromImage:icon] forKey:@"icon"];
    [userDefaults setObject:iconData forKey:@"icon"];
    [userDefaults synchronize];
}
//[userDefaults synchronize];}
/**
 
 *取出指定类型用户信息到userDefaults
 
 */

//+(NSObject*)takeUserInfoToUserdefaults: (InfoTypeIndex)type{
//
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//
//    NSData *infoData;
//
//    NSObject *userInfo;
//
//    switch(type) {
//
//        case UserHeadImage:
//
//            infoData = [userDefaults dataForKey:@"UserHeadImage"];
//
//            userInfo = [UIImage imageWithData:infoData];
//
//            break;
//
//        case UserName:
//
//            infoData = [userDefaults dataForKey:@"UserName"];
//
//            userInfo = [NSKeyedUnarchiver unarchiveObjectWithData: infoData];
//
//            break;
//
//        default:
//
//            break;
//
//    }
//
//    return userInfo;}
#pragma mark 加载数据动画
-(void)removeQDProgressHUD
{
    
}
-(void)loadVideoData
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
    [manager GET:@"https://leancloud.cn:443/1.1/classes/QDVideo" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nullable task,id  _Nullable responseObject)
     {
         
         //将返回的数据专为json字典
         NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
         NSArray * temp =[QDVideoModel mj_objectArrayWithKeyValuesArray:dict[@"results"]];
         [_videoArray addObjectsFromArray:temp];
         
     }failure:^(NSURLSessionDataTask * _Nullable task, id _Nullable error)
     {
         NSLog(@"%@",error);
     }];
}
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
         //将返回的数据专为json字典
         NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
         NSArray * temp =[QDSuggestModel mj_objectArrayWithKeyValuesArray:dict[@"results"]];
         [_suggestArray addObjectsFromArray:temp];
//         [_tabView reloadData];
         
     }failure:^(NSURLSessionDataTask * _Nullable task, id _Nullable error)
     {
         NSLog(@"%@",error);
     }];
}
#pragma mark ColllectionView代理
-(void)TransformVC:(NSIndexPath *)indexPath
{
    QDDetailVC * detailVC = [[QDDetailVC alloc]init];
    detailVC.model = self.adImageArray[indexPath.row];
    detailVC.modalTransitionStyle =  UIModalTransitionStylePartialCurl;
    [self presentViewController:detailVC animated:YES completion:nil];
//    [self.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark 建议TabviewCell点击代理
-(void)QDSuggestVCTransform:(NSIndexPath *)indexPath
{
    QDSuggestDetailVC * vc = [[QDSuggestDetailVC alloc]init];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    vc.model = self.suggestArray[indexPath.row];
    [self presentViewController:vc animated:YES completion:nil];
}
-(void)transformVC:(NSIndexPath *)indexPath
{
    VKVideoPlayerViewController * vc = [[VKVideoPlayerViewController alloc]init];
    
    [self presentViewController:vc animated:YES completion:nil];
    QDVideoModel * model =_videoArray[indexPath.row];
    [vc playVideoWithStreamURL:[NSURL URLWithString:model.videoUrl]];
}
#pragma mark 设置布局
-(void)setLayout
{
    _homeTabView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _homeTabView.delegate = self;
    _homeTabView.dataSource = self;
    _homeTabView.bounces = NO;
    _homeTabView.backgroundColor = [UIColor lightGrayColor];
//    _homeTabView.bounces = NO;
    _homeTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _homeTabView.allowsSelection  = NO;
    _homeTabView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_homeTabView];
    [_homeTabView mas_makeConstraints:^(MASConstraintMaker * make){
        make.left.equalTo(self.view.left);
        make.top.equalTo(self.view.top);
        make.width.equalTo(self.view);
        make.height.equalTo(ScreenH-138*HScale);
    }];
}

#pragma mark 建议tableView代理和数据源
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section == 0)
        {
            if(indexPath.row == 0)
            {
                [_homeTabView registerClass:[QDThreeDTabCell class] forCellReuseIdentifier:ID];
                QDThreeDTabCell * cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
//                cell.ThreeDelegate = self;
                cell.backgroundColor = AppMainColor;
//                [cell.verticalScrollView setDataSource:self];
                if(cell == nil)
                {
                    cell = [[QDThreeDTabCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
                }
//                cell.model = self.suggestArray[indexPath.row];
                return cell;
            }
            else if (indexPath.row == 1)
            {
                [_homeTabView registerClass:[QDRecommendCell class] forCellReuseIdentifier:@"QDRecommendCell"];
                QDRecommendCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QDRecommendCell" forIndexPath:indexPath];
                cell.backgroundColor = AppMainColor;
                return cell;
            }
        }
    else if (indexPath.section == 1)
    {
         if(indexPath.row == 0)
        {
            [_homeTabView registerClass:[QDCollectionTableViewCell class] forCellReuseIdentifier:@"QDCollectionTabviewCell"];
            
            QDCollectionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QDCollectionTabviewCell" forIndexPath:indexPath];
            cell.delegate = self;
            cell.backgroundColor = AppMainColor;
            return cell;
        }
        else if (indexPath.row == 1)
        {
            [_homeTabView registerClass:[QDRecommendReadCell class] forCellReuseIdentifier:@"QDRecommendCell"];
            QDRecommendReadCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QDRecommendCell" forIndexPath:indexPath];
            cell.backgroundColor = AppMainColor;
            return cell;
        }
    }
    else if(indexPath.section == 2)
    {
        if(indexPath.row ==0)
        {
            [_homeTabView registerClass:[QDSuggestViewCell class] forCellReuseIdentifier:@"QDSuggestViewCell"];
            QDSuggestViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QDSuggestViewCell" forIndexPath:indexPath];
            cell.backgroundColor = AppMainColor;
//            cell.backgroundColor = [UIColor blackColor];
            cell.delegate = self;
            return cell;
        }
        else if (indexPath.row == 1)
        {
            [_homeTabView registerClass:[QDRecoomendVideoCell class] forCellReuseIdentifier:@"QDRecoomendVideoCell"];
            QDRecoomendVideoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QDRecoomendVideoCell" forIndexPath:indexPath];
            cell.backgroundColor = AppMainColor;
            return cell;
        }
        else if (indexPath.row == 2)
        {
            [_homeTabView registerClass:[QDVideoTabViewCell class] forCellReuseIdentifier:@"QDVidelTabViewCell"];
            QDVideoTabViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QDVidelTabViewCell" forIndexPath:indexPath];
            cell.delegate = self;
            cell.backgroundColor = AppMainColor;
            return cell;
        }
    }
    return nil;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        if(indexPath.row == 0)
        {
            return 160*HScale;
        }
        else if (indexPath.row == 1)
        {
            return 40*HScale;
        }
    }
    else if (indexPath.section ==1)
    {
        if(indexPath.row == 0)
        {
            return 320*HScale;
        }
        else if (indexPath.row == 1)
        {
            return 40*HScale;
        }
    }
    else if (indexPath.section == 2)
    {
       if(indexPath.row == 0)
       {
           return 210*HScale;
       }
        else if (indexPath.row == 1)
        {
            return 40*HScale;
        }
        
        else if (indexPath.row == 2)
        {
            return 425*HScale;
        }
    }
    return 100;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return _suggestArray.count;
    if(section == 0)
    {
        return 2;
    }
    else if (section == 1)
    {
        return 2;
    }
    else if (section == 2)
    {
        return 3;
    }
    return 0;
}
-(void)loadImageUrl
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
    [manager GET:@"https://leancloud.cn:443/1.1/classes/Leyal" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nullable task,id  _Nullable responseObject)
     {
//         NSLog(@"返回结果%@",responseObject);
         //将返回的数据专为json字典
         NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
//         NSLog(@"dict>>>\n%@",dict);
         NSArray * temp =[CollectionViewModel mj_objectArrayWithKeyValuesArray:dict[@"results"]];
         [_adImageArray addObjectsFromArray:temp];
         [_homeTabView reloadData];
         [_QDProgressHUD removeFromSuperview];
     }failure:^(NSURLSessionDataTask * _Nullable task, id _Nullable error)
     {
         NSLog(@"%@",error);
     }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320,20)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
@end
