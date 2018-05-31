//
//  QDDetailVC.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/19.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "QDDetailVC.h"
#import "CollectionViewModel.h"
#import "QDDetailCollectionViewCell.h"
#import "CustomNavigationBar.h"
#import "NSString+Time.h"
@interface QDDetailVC ()<UICollectionViewDelegate,UICollectionViewDataSource,CustomNavigationBarDelegate>

@end

@implementation QDDetailVC
{
    CustomNavigationBar * customNavigationBar;
    UILabel * titleLabel;
    UILabel * timeLabel;
    UIScrollView * backGroundView;
    UIButton * backButton;
    UIImageView * icon;
    UILabel * nameLabel;
    UILabel * contentLabel;
    UICollectionView * collectionView;
    NSMutableArray * imgModelArray;
    NSInteger imgCount;
    UILabel * lookTimeLabel;
    UIButton * goodButton;
    BOOL isGoodButtonCLick;
    UICollectionViewFlowLayout * layout;
    UILabel * likeLabel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLayout];
    [self loadData];
    [self addLookCount];
    
}
#pragma makr 浏览次数加1
-(void)addLookCount
{
    AVObject * object = [AVObject objectWithClassName:@"Leyal" objectId:self.model.objectId];
    int currentLookCount = [self.model.lookcount intValue];
    int nowLookCount = currentLookCount +1;
    NSString * sNowLookCount = [NSString stringWithFormat:@"%d",nowLookCount];
    [object setObject:sNowLookCount forKey:@"lookcount"];
    [object saveInBackground];
}
#pragma mark 自定义导航栏代理
-(void)transformVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 设置布局
-(void)setLayout
{
    //自定义导航栏
    customNavigationBar = [[CustomNavigationBar alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 64*HScale) backgroundColor:titleColor titleFont:[UIFont systemFontOfSize:19] title:@"推荐详情"];
    customNavigationBar.delegate = self;
    [self.view addSubview:customNavigationBar];
    //设置边框
//    customNavigationBar.layer.borderColor = [UIColor RGB:222 andG:115 andB:196 alpha:1].CGColor;
//    customNavigationBar.layer.borderWidth = 1;
    //返回按钮
//    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//    [customNavigationBar addSubview:backButton];
//    [backButton mas_makeConstraints:^(MASConstraintMaker * make){
//        make.left.equalTo(customNavigationBar.left).offset(14*WScale);
//        make.top.equalTo(customNavigationBar.top).offset(30*HScale);
//        make.width.equalTo(21*WScale);
//        make.height.equalTo(21*HScale);
//    }];
//    //titleView标题
//    titleLabel = [[UILabel alloc]init];
//    titleLabel.textColor = [UIColor blackColor];
//    titleLabel.font = [UIFont systemFontOfSize:18];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.text = @"详情";
//    [customNavigationBar addSubview:titleLabel];
//    [titleLabel mas_makeConstraints:^(MASConstraintMaker * make){
//        make.centerX.equalTo(customNavigationBar);
//        make.centerY.equalTo(backButton);
//        make.width.equalTo(50*WScale);
//        make.height.equalTo(10*HScale);
//    }];
    
    //背景滚动视图
    backGroundView = [[UIScrollView alloc]init];
    backGroundView.frame = CGRectMake(0, 64*HScale, ScreenW, ScreenH-64*HScale);
    backGroundView.backgroundColor = [UIColor whiteColor];
    backGroundView.contentSize = CGSizeMake(ScreenW, ScreenH+100*HScale);
    [self.view addSubview:backGroundView];
    //头像
    icon = [[UIImageView alloc]init];
    icon.layer.cornerRadius = 8;
    icon.layer.masksToBounds = YES;
    [backGroundView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker * make){
        make.left.equalTo(backGroundView.left).offset(12*WScale);
        make.top.equalTo(backGroundView.top).offset(15*HScale);
        make.width.equalTo(40*WScale);
        make.height.equalTo(40*HScale);
    }];
    //昵称
    nameLabel = [[UILabel alloc]init];
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = [UIColor RGB:35 andG:41 andB:138 alpha:1];
    [backGroundView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker * make){
        make.left.equalTo(icon.right).offset(15*WScale);
        make.top.equalTo(icon.top).offset(3*HScale);
        make.width.equalTo(200*WScale);
        make.height.equalTo(10*HScale);
    }];
    //时间
    timeLabel = [[UILabel alloc]init];
    timeLabel.font = [UIFont systemFontOfSize:14];
    timeLabel.textColor = [UIColor blackColor];
    [backGroundView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker * make){
        make.left.equalTo(nameLabel);
        make.bottom.equalTo(icon.bottom).offset(-3*HScale);
        make.width.equalTo(200*WScale);
        make.height.equalTo(10*HScale);
    }];
    //正文
    contentLabel = [[UILabel alloc]init];
    contentLabel.font = [UIFont systemFontOfSize:16];
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = [UIColor darkGrayColor];
    [backGroundView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker * make){
        make.left.equalTo(backGroundView.left).offset(12*WScale);
        make.top.equalTo(icon.bottom).offset(15*HScale);
//        make.right.equalTo(backGroundView.right).offset(-12*WScale);
        make.width.equalTo(354*WScale);
//        make.height.equalTo(100*HScale);
    }];
    //图片数量
    imgCount = [self.model.imgcount integerValue];
    imgModelArray = [[NSMutableArray alloc]init];
   
    if(imgCount == 1)
    {
        [imgModelArray addObject:self.model.url0];
    }else if (imgCount == 2)
    {
        [imgModelArray addObject:self.model.url0];
        [imgModelArray addObject:self.model.url1];

    }
    else if (imgCount == 3)
    {
        [imgModelArray addObject:self.model.url0];
        [imgModelArray addObject:self.model.url1];
        [imgModelArray addObject:self.model.url2];
    }
    else if (imgCount == 4)
    {
        [imgModelArray addObject:self.model.url0];
        [imgModelArray addObject:self.model.url1];
        [imgModelArray addObject:self.model.url2];
        [imgModelArray addObject:self.model.url3];
    }
    else if (imgCount == 5)
    {
        [imgModelArray addObject:self.model.url0];
        [imgModelArray addObject:self.model.url1];
        [imgModelArray addObject:self.model.url2];
        [imgModelArray addObject:self.model.url3];
        [imgModelArray addObject:self.model.url4];
    }else
    {
        [imgModelArray addObject:self.model.url0];
        [imgModelArray addObject:self.model.url1];
        [imgModelArray addObject:self.model.url2];
        [imgModelArray addObject:self.model.url3];
        [imgModelArray addObject:self.model.url4];
        [imgModelArray addObject:self.model.url5];
    }
   
    //flowLaout
    layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    layout.minimumInteritemSpacing = .3f;
    if(imgCount == 1)
    {
        layout.itemSize = CGSizeMake(354*WScale, 380*HScale);
    }
    else if (imgCount == 2)
    {
        layout.itemSize = CGSizeMake(175*WScale, 150*HScale);
    }
    else
    {
        layout.itemSize = CGSizeMake(110*WScale, 115*WScale);
    }
    collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0,0,0) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.scrollEnabled = NO;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.bounces = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.dataSource = self;
    [collectionView registerClass:[QDDetailCollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    [backGroundView addSubview:collectionView];
    if(imgCount == 1)
    {
        [collectionView mas_remakeConstraints:^(MASConstraintMaker * make){
            make.left.equalTo(backGroundView.left).offset(12*WScale);
            make.width.equalTo(351*WScale);
            make.top.equalTo(contentLabel.bottom).offset(15*HScale);
            make.height.equalTo(380*HScale);
        }];
    }
    else if(imgCount == 2)
    {
        [collectionView mas_remakeConstraints:^(MASConstraintMaker * make){
            make.left.equalTo(backGroundView.left).offset(12*WScale);
            make.width.equalTo(351*WScale);
            make.top.equalTo(contentLabel.bottom).offset(15*HScale);
            make.height.equalTo(150*HScale);
        }];
    }
    else
    {
        [collectionView mas_remakeConstraints:^(MASConstraintMaker * make){
            make.left.equalTo(backGroundView.left).offset(12*WScale);
            make.width.equalTo(351*WScale);
            make.top.equalTo(contentLabel.bottom).offset(15*HScale);
            make.height.equalTo(130*HScale);
        }];
    }

    [collectionView reloadData];
    //浏览次数
    lookTimeLabel = [[UILabel alloc]init];
    lookTimeLabel.font = [UIFont systemFontOfSize:14];
    lookTimeLabel.textColor = [UIColor grayColor];
    lookTimeLabel.text = [NSString stringWithFormat:@"浏览次数%d次",[self.model.lookcount intValue]];
    [backGroundView addSubview:lookTimeLabel];
    [lookTimeLabel mas_makeConstraints:^(MASConstraintMaker * make){
        make.left.equalTo(backGroundView.left).offset(12*WScale);
        make.top.equalTo(collectionView.bottom).offset(20*HScale);
        make.width.equalTo(100*WScale);
        make.height.equalTo(20*HScale);
    }];
    
    //点赞按钮
    goodButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [goodButton setImage:[UIImage imageNamed:@"good_button_n"] forState:UIControlStateNormal];
    [goodButton setImage:[UIImage imageNamed:@"good_button_h"] forState:UIControlStateSelected];
//    goodButton.selected = NO;
    if([self.model.isGood intValue] == 1)
    {
        goodButton.selected = YES;
    }
    else
    {
        goodButton.selected = NO;
//        isGoodButtonCLick = !isGoodButtonCLick;
    }
    [goodButton addTarget:self action:@selector(goodButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:goodButton];
    [goodButton mas_makeConstraints:^(MASConstraintMaker * make){
        make.right.equalTo(lookTimeLabel.right).offset(185*WScale);
        make.width.equalTo(36*WScale);
        make.height.equalTo(36*HScale);
        make.centerY.equalTo(lookTimeLabel);
    }];
    //点赞label
    likeLabel = [[UILabel alloc]init];
    likeLabel.font = [UIFont systemFontOfSize:15];
    likeLabel.textColor = [UIColor RGB:115 andG:111 andB:111 alpha:1];
    likeLabel.text = @"赞";
    [backGroundView addSubview:likeLabel];
    [likeLabel mas_makeConstraints:^(MASConstraintMaker * make){
        make.left.equalTo(goodButton.right).offset(5*WScale);
        make.centerY.equalTo(goodButton);
        make.width.equalTo(20*WScale);
    }];
    
    //右划手势
    UISwipeGestureRecognizer * rightPanGesture = [[UISwipeGestureRecognizer alloc]init];
    rightPanGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [rightPanGesture addTarget:self action:@selector(rightSwip)];
    [self.view addGestureRecognizer:rightPanGesture];
    
}
#pragma mark UICollectionview DataSource delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return imgCount;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    QDDetailCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
//    [cell.img sd_setImageWithURL:[NSURL URLWithString:imgModelArray[indexPath.row]]];
    [cell.img sd_setImageWithURL:[NSURL URLWithString:imgModelArray[indexPath.row]] completed:^(UIImage * image,NSError * error,SDImageCacheType cachetype,NSURL * imageUrl){
        CGFloat imgW = CGImageGetWidth(image.CGImage);
        CGFloat imgH = CGImageGetHeight(image.CGImage);
        if(imgCount == 1)
        {
            layout.itemSize = CGSizeMake(354*WScale, 354*HScale/(imgW/imgH));
        }
        else if(imgCount == 2)
        {
            layout.itemSize = CGSizeMake(175*WScale, 175*HScale/(imgW/imgH));
        }
        else
        {
            layout.itemSize = CGSizeMake(110*WScale, 110*HScale/(imgW/imgH));
        }

    }];
    
    return cell;
}
////设置每个item的尺寸
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(123*WScale, 153*HScale);
//}
#pragma mark 加载数据
-(void)loadData
{
//    CollectionViewModel * model = self.model;
    [icon sd_setImageWithURL:[NSURL URLWithString:self.model.iconUrl]];
    nameLabel.text = self.model.name;
    timeLabel.text = [NSString compareCurrentTime:self.model.pushtime];
    contentLabel.text = self.model.text;
}
#pragma mark 点击返回按钮
-(void)backButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 右划手势
-(void)rightSwip
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 点击点赞按钮
-(void)goodButtonClick
{
    if(!isGoodButtonCLick)
    {
        goodButton.selected = YES;
        likeLabel.textColor = [UIColor redColor];
        //点赞数加1  浏览次数
        AVObject * object = [AVObject objectWithClassName:@"ADImage" objectId:self.model.objectId];
        int currentGoodCount = [self.model.lookcount intValue];
        int nowGoodCount = currentGoodCount +1;
        NSString * sNowGoodCount = [NSString stringWithFormat:@"%d",nowGoodCount];
        [object setObject:sNowGoodCount forKey:@"lookcount"];
        [object setObject:@"1" forKey:@"isgood"];
        [object saveInBackground];
        NSLog(@"点赞");
        isGoodButtonCLick = ! isGoodButtonCLick;
    }
    else
    {
        NSLog(@"已经点过赞了");
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
