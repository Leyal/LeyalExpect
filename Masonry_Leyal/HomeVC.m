//
//  HomeVC.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/5.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "HomeVC.h"
#import "TableViewCell.h"
#import "Model.h"
#import <AFNetworking.h>
#import <TZImagePickerController.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <ARKit/ARKit.h>
#import <YYModel.h>
@interface HomeVC ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate>
@property(nonatomic,strong) NSString * name;
@property(nonatomic,strong) UILabel * label1;


@property(nonatomic,strong) UILabel * nameLabel;
@property(nonatomic,strong) UILabel * contentLabel;
@property(nonatomic,strong) NSMutableArray * myArray;

@property(nonatomic,strong) UIButton * photoButton;
@property(nonatomic,strong) TZImagePickerController * imagePickerVc;
@property(nonatomic,strong) NSArray<UIImage *> * imageArray;


@property(nonatomic,strong) NSString * imgName;


//第二种请求数据的方法
@property(nonatomic,strong) NSMutableArray * dataArray;
@end
static NSString *ID = @"cell";
@implementation HomeVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor purpleColor];
    _myArray = [[NSMutableArray alloc]init];
    _dataArray = [NSMutableArray array];
    _photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_photoButton setImage:[UIImage imageNamed:@"photo_button"] forState:UIControlStateNormal];
    [_photoButton addTarget:self action:@selector(photograghButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _photoButton.frame = CGRectMake(180, 450, 64, 64);
//    [[[UIApplication sharedApplication].delegate window]addSubview:_photoButton];
    [self.view addSubview:_photoButton];
    NSLog(@"按钮的frame\n%@",NSStringFromCGRect(_photoButton.frame));
    
    
    
    
    //去除多余的cell
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self loadData];
    
//    [self upDateData];
//    [self showImg];
//    [self testAV];
//    [self getImage];
//    [self loadData2];
    
}
#pragma mark 请求数据的第二种方法
-(void)loadData2
{
    AVQuery *query = [AVQuery queryWithClassName:@"Student"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (AVObject *obj in objects) {
            NSMutableDictionary *dic = obj.dictionaryForObject;
            [dic removeObjectForKey:@"className"];
            [dic removeObjectForKey:@"createdAt"];
            [dic removeObjectForKey:@"objectId"];
            [dic removeObjectForKey:@"updatedAt"];
            [dic removeObjectForKey:@"__type"];
            [self.dataArray addObject:dic];
            NSLog(@"第二种数据请求方式：\n%@",dic);
            
//            NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:dic options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
//            NSLog(@"dict>>>\n%@",dict);
        }
        
    }];
    
}
#pragma mark 获取多张图片
-(void)getImage
{
    AVQuery * query = [AVQuery queryWithClassName:@"_File"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * objects,NSError * error){
//        NSArray * arr = [NSKeyedUnarchiver unarchiveObjectWithData:<#(nonnull NSData *)#>]
    }];
    
    
}
-(void)photograghButtonClick
{
    __weak typeof(self) weakSelf = self;
//    _imagePickerVc = [[TZImagePickerController alloc]initWithMaxImagesCount:9 delegate:self];
    _imagePickerVc = [[TZImagePickerController alloc]initWithMaxImagesCount:6 delegate:self];
    
    [_imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos,NSArray * assets,BOOL success)
     {
         _imageArray = photos;
         
         if(_imageArray.count!=0)
         {

//             [weakSelf layoutCollectionView];
             [weakSelf updateFile];
         }
         
     }];
    NSLog(@"选中图片的名字：\n%@",_imagePickerVc.photoSelImageName);
    _imgName =_imagePickerVc.photoSelImageName;
    
    [self presentViewController:_imagePickerVc animated:YES completion:nil];
}


- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    _imagePickerVc.sortAscendingByModificationDate = NO;
    _imagePickerVc.photoWidth = 1024.0;
    _imagePickerVc.photoPreviewMaxWidth = 3072.0;
    [self.navigationController presentViewController:_imagePickerVc animated:YES completion:nil];
}
#pragma mark 上传多张图片
-(void)updateFile
{
//    NSLog(@"获取的图片：\n%@",_imageArray);
//    for (int i=0;i<_imageArray.count;i++)
//    {
//
//        //上传图片
//        NSData *data = UIImagePNGRepresentation(_imageArray[i]);
//        AVFile *file = [AVFile fileWithName:@"thpic.png" data:data];
//        [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//            // 成功或失败处理...
//            if(succeeded)
//            {
//                NSLog(@"文件地址是\n%@",file.url);
//            }
//            NSLog(@"上传错误信息\n%@",error);
//
//        } progressBlock:^(NSInteger percentDone) {
//            // 上传进度数据，percentDone 介于 0 和 100。
//            NSLog(@"%ld",(long)percentDone);
//
//        }];
//    }
    
    
    NSString * text = @"测试文本3";
    NSString * number = @"15";
    AVObject * obj = [AVObject objectWithClassName:@"newTable"];
    for (int i=0;i<_imageArray.count;i++)
    {
        NSData * data = UIImagePNGRepresentation(_imageArray[i]);
        AVFile * file = [AVFile fileWithData:data];
        [obj setObject:file forKey:@"img"];
    }
    AVUser * user = [AVUser currentUser];
    
    [obj setObject:text forKey:@"text"];
    [obj setObject:number forKey:@"price"];
    [obj setObject:user forKey:@"owner"];
    
    [obj saveInBackgroundWithBlock:^(BOOL successed,NSError * error)
     {
        if(successed)
        {
            NSLog(@"保存成功");
        }
        else
        {
            NSLog(@"%@",error);
        }
     }];
    

    
}
-(void)testAV
{
    AVQuery * query = [AVQuery queryWithClassName:@"People"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * response,NSError * error){
//        NSLog(@"AV查询返回结果是\n%@",response);
        NSMutableArray * arr = [[NSMutableArray alloc]init];
        for(AVObject * o in response)
        {
            NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
            
//            NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:o[@"name"] options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
//
//            NSMutableDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:o[@"content"] options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
            NSMutableDictionary * dic1 = [[NSMutableDictionary alloc]init];
            dic1 = o[@"name"];
            NSMutableDictionary * dic2 = [[NSMutableDictionary alloc]init];
            dic2 = o[@"content"];
            [dic setObject:dic1 forKey:@"name"];
            [dic setObject:dic2 forKey:@"content"];
            [arr addObject:dic];
        }
       NSLog(@"dict>>>\n%@",arr);
//        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:arr[0] options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
//        NSLog(@"AV查询结果转化为Json>>>\n%@",dict);
    }];
}
-(void)showImg
{
    //1.创建请求会话管理者
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    //2.拼接参数
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(41);
    manager.requestSerializer = [AFJSONRequestSerializer new];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    //请求头
    [manager.requestSerializer setValue:@"BA69fJYBSxVp9ty8eiWHg9f0-gzGzoHsz"forHTTPHeaderField:@"X-LC-Id"];
    [manager.requestSerializer setValue:@"6cOvO8wLMOJIOtk5kEfyazUz"forHTTPHeaderField:@"X-LC-Key"];
    [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Content-Type"];
    //3、请求数据
    [manager GET:@"https://leancloud.cn:443/1.1/classes/_File" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nullable task,id  _Nullable responseObject)
     {
         NSLog(@"返回结果%@",responseObject);
         //将返回的数据专为json字典
         NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
         NSLog(@"dict>>>\n%@",dict);
//         NSArray * temp =[Model mj_objectArrayWithKeyValuesArray:dict[@"results"]];
//         [_myArray addObjectsFromArray:temp];
         //刷新数据
//         [self.tableView reloadData];
         
     }failure:^(NSURLSessionDataTask * _Nullable task, id _Nullable error)
     {
         NSLog(@"%@",error);
         
     }];
}
-(void)upDateData
{
    AVObject * obj = [AVObject objectWithClassName:@"People"];
    [obj setObject:@"陈鹏辉" forKey:@"name"];
    [obj setObject:@"今天让你难过的事情在未来的一天，你会笑着说出来" forKey:@"content"];
    [obj saveInBackground];
}
-(void)loadData
{
    
    //1.创建请求会话管理者
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    //2.拼接参数
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(41);
    manager.requestSerializer = [AFJSONRequestSerializer new];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    //请求头
    [manager.requestSerializer setValue:@"BA69fJYBSxVp9ty8eiWHg9f0-gzGzoHsz"forHTTPHeaderField:@"X-LC-Id"];
    [manager.requestSerializer setValue:@"6cOvO8wLMOJIOtk5kEfyazUz"forHTTPHeaderField:@"X-LC-Key"];
    [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Content-Type"];
    //3、请求数据
    [manager GET:@"https://leancloud.cn:443/1.1/classes/newTable" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nullable task,id  _Nullable responseObject)
     {
         NSLog(@"返回结果%@",responseObject);
         //将返回的数据专为json字典
         NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];

         NSLog(@"results>>>>>>>>\n%@",dict[@"results"]);
//         NSArray * temp = [Model mj_keyValuesArrayWithObjectArray:dict[@"results"]];
         NSArray * temp1 = [Model mj_objectArrayWithKeyValuesArray:dict[@"results"]];
         
//         NSArray * arr =[NSArray yy_modelArrayWithClass:[Model class] json:dict[@"results"]];
//         for (Model * m in arr)
//         {
//             NSLog(@"%@",m.text);
//             NSLog(@"%@",m.img);
////             NSLog(@"%@",m.img.url);
//         }
         
         
//         NSArray * temp =[Model mj_objectArrayWithKeyValuesArray:dict[@"results"]];
//         NSLog(@"%@",temp);
//         Model * m = [Model mj_objectWithKeyValues:dict[@"results"][0]];
//         NSLog(@"单个url>>>>>>>>>>\n%@",m.user.url);
         
//         Model * model = [Model yy_modelWithJSON:dict[@"results"]];
//         NSArray * arr =[NSArray yy_modelArrayWithClass:Model json:<#(nonnull id)#>]
//         NSLog(@"%@",t);
//         NSLog(@">>>>>>>>>>>\n%@",model);
//         [_dataArray addObject:model];
         
//         [_myArray addObjectsFromArray:arr];
         [_myArray addObjectsFromArray:temp1];
         
//         [_myArray addObject:model];
//         NSLog(@"文本数据请求：\n%@",_myArray);
         //刷新数据
         [self.tableView reloadData];

     }failure:^(NSURLSessionDataTask * _Nullable task, id _Nullable error)
     {
         NSLog(@"%@",error);

     }];
    
    
//    AVQuery *query = [AVQuery queryWithClassName:@"newTable"];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        for (AVObject *obj in objects) {
//            NSMutableDictionary *dic = obj.dictionaryForObject;
//            
//            [dic removeObjectForKey:@"className"];
//            [dic removeObjectForKey:@"createdAt"];
//            [dic removeObjectForKey:@"objectId"];
//            [dic removeObjectForKey:@"updatedAt"];
//            [dic removeObjectForKey:@"__type"];
//            
//            
//            NSLog(@"%@",dic[@"img"][@"url"]);
//            [dic setObject:dic[@"img"][@"url"] forKey:@"url"];
//            NSLog(@"新的dic:\n%@",dic);
////            [self.dataArray addObject:dic];
//            NSLog(@"第二种数据请求方式：\n%@",self.dataArray);
//
//        }
//
//        NSArray *temp = [Model mj_keyValuesArrayWithObjectArray:self.dataArray];
//        [_myArray addObjectsFromArray:temp];
//        [self.tableView reloadData];
//    }];
//
//
//    NSLog(@"字典转模型的数组：\n%@",self.dataArray);
//    NSLog(@"新的模型：\n%@",_myArray);
    
   
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _myArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil)
    {
        cell = [[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.model = _myArray[indexPath.row];
//    self.nameLabel = cell.nameLabel;
//    self.contentLabel = cell.contentLabel;
    
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
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
