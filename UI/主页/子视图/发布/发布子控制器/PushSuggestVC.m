//
//  PushSuggestVC.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/25.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "PushSuggestVC.h"
#import <TZImagePickerController.h>
#import "QDDetailCollectionViewCell.h"
#import "PushViewController.h"
@interface PushSuggestVC ()<TZImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UITextViewDelegate,PushButtonDelegate>

@end

@implementation PushSuggestVC
{
    UITextView * dynamicTextView;
    UIButton * photoButton;
    UICollectionView * imgView;
    TZImagePickerController * imagePicker;
    NSArray * imageArray;
    UICollectionView * collectionView;
    UILabel * placeholder;
    UILabel * placeholder1;
    UIButton * pushButton;
    UITextView * titleTextView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLayout];
}
#pragma mark 加载布局
-(void)setLayout
{
    //标题
    titleTextView = [[UITextView alloc]init];
    titleTextView.backgroundColor = [UIColor RGB:238 andG:238 andB:238 alpha:1];
    titleTextView.delegate = self;
    titleTextView.scrollEnabled = NO;
    titleTextView.tag = 1;
    titleTextView.font = [UIFont systemFontOfSize:16];
    titleTextView.textColor = [UIColor blackColor];
    [self.view addSubview:titleTextView];
    [titleTextView mas_makeConstraints:^(MASConstraintMaker * make){
        make.left.equalTo(self.view.left).offset(12*WScale);
        make.right.equalTo(self.view.right).offset(-12*WScale);
        make.top.equalTo(self.view.top).offset(5*HScale);
        make.height.equalTo(35*HScale);
    }];
    //输入框占位符
    placeholder1 = [[UILabel alloc]init];
    placeholder1.textColor = [UIColor lightGrayColor];
    placeholder1.backgroundColor = [UIColor clearColor];
    placeholder1.text = @"写入标题...";
    placeholder1.font = [UIFont systemFontOfSize:16];
    placeholder1.userInteractionEnabled = YES;
    [titleTextView addSubview:placeholder1];
    [placeholder1 mas_makeConstraints:^(MASConstraintMaker * make){
        make.left.equalTo(titleTextView.left).offset(3*WScale);
        //        make.top.equalTo(titleTextView.top).offset(8*HScale);
        make.centerY.equalTo(titleTextView);
    }];
    //输入框
    dynamicTextView = [[UITextView alloc]init];
    dynamicTextView.backgroundColor = [UIColor RGB:238 andG:238 andB:238 alpha:1];
    dynamicTextView.delegate = self;
    dynamicTextView.tag = 0;
    dynamicTextView.font = [UIFont systemFontOfSize:16];
    dynamicTextView.textColor = [UIColor blackColor];
    [self.view addSubview:dynamicTextView];
    [dynamicTextView mas_makeConstraints:^(MASConstraintMaker * make){
        make.left.equalTo(self.view.left).offset(12*WScale);
        make.right.equalTo(self.view.right).offset(-12*WScale);
        make.top.equalTo(titleTextView.bottom).offset(5*HScale);
        make.height.equalTo(170*HScale);
    }];
    //照片按钮
    photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [photoButton setImage:[UIImage imageNamed:@"add_photo_button"] forState:UIControlStateNormal];
    [photoButton addTarget:self action:@selector(photoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:photoButton];
    [photoButton mas_makeConstraints:^(MASConstraintMaker * make){
        make.left.equalTo(self.view.left).offset(12*WScale);
        make.top.equalTo(dynamicTextView.bottom).offset(10*HScale);
        make.width.equalTo(170*WScale);
        make.height.equalTo(41*HScale);
    }];
    //发布按钮
    pushButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [pushButton setImage:[UIImage imageNamed:@"push_button"] forState:UIControlStateNormal];
    [pushButton addTarget:self action:@selector(clickPushButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton];
    [pushButton mas_makeConstraints:^(MASConstraintMaker * make){
        make.centerY.equalTo(photoButton);
        make.right.equalTo(self.view.right).offset(-12*WScale);
        make.width.equalTo(170*WScale);
        make.height.equalTo(41*HScale);
    }];
    //输入框占位符
    placeholder = [[UILabel alloc]init];
    placeholder.textColor = [UIColor lightGrayColor];
    placeholder.backgroundColor = [UIColor clearColor];
    placeholder.text = @"写点什么吧...";
    placeholder.font = [UIFont systemFontOfSize:16];
    placeholder.userInteractionEnabled = YES;
    
    [dynamicTextView addSubview:placeholder];
    [placeholder mas_makeConstraints:^(MASConstraintMaker * make){
        make.left.equalTo(dynamicTextView.left).offset(3);
        make.top.equalTo(dynamicTextView.top).offset(8);
    }];
    //自定义键盘
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(2, 5, 50, 25);
    [btn addTarget:self action:@selector(dismissKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    //    [btn setImage:[UIImage imageNamed:@"done_button"] forState:UIControlStateNormal];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    NSArray * buttonsArray = [NSArray   arrayWithObjects:btnSpace,doneBtn,nil];
    [topView setItems:buttonsArray];
    [dynamicTextView setInputAccessoryView:topView];
    
}
-(void)clickPushButton
{
    
    AVObject * obj = [AVObject objectWithClassName:@"QDHomeSuggest"];
    //    //    AVUser * user = [AVUser currentUser];
    //    //    [obj setObject:@"雷源" forKey:@"name"];//name
    [obj setObject:dynamicTextView.text forKey:@"content"];//content
    //    // 获取系统当前时间
    NSDate * date = [NSDate date];
    NSTimeInterval sec = [date timeIntervalSinceNow];
    NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
    //
    //设置时间输出格式：
    NSDateFormatter * df = [[NSDateFormatter alloc] init ];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss.123"];
    NSString * na = [df stringFromDate:currentDate];
    //获取头像姓名
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * name = [userDefaults objectForKey:@"name"];
    NSData * iconData = [userDefaults objectForKey:@"icon"];
    [obj setObject:name forKey:@"name"];//name
    //    [obj setObject:[UIImage imageWithData:iconData] forKey:@"icon"];
    AVFile * iconFile = [AVFile fileWithData:iconData];
    [obj setObject:iconFile forKey:@"icon"];
    
    [obj setObject:@"0" forKey:@"lookcount"];
    //    [obj setObject:@"0" forKey:@"goodcount"];
    [obj setObject:na forKey:@"createtime"];//createtime
    [obj setObject:titleTextView.text forKey:@"title"];
    NSData * data = UIImagePNGRepresentation(imageArray[0]);
    AVFile * file = [AVFile fileWithData:data];//img
    [obj setObject:file forKey:@"img"];
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
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"保存成功" message:@"do something!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //            [alertController dismissViewControllerAnimated:YES completion:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark 退出键盘
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [dynamicTextView resignFirstResponder];
    
}
-(void)dismissKeyBoard
{
    [dynamicTextView resignFirstResponder];
}
#pragma mark UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView
{
    if(textView.tag == 0)
    {
        if(dynamicTextView.text.length == 0)
        {
            placeholder.text = @"写点什么吧...";
        }
        else
        {
            placeholder.text = @"";
        }
    }
    else
    {
        if(titleTextView.text.length == 0)
        {
            placeholder1.text = @"写入标题...";
        }
        else
        {
            placeholder1.text = @"";
        }
    }
}
#pragma mark 点击拍照按钮
-(void)photoButtonClick
{
    YKLog(@"...");
    __weak typeof(self) weakSelf = self;//弱引用
    imagePicker = [[TZImagePickerController alloc]initWithMaxImagesCount:1 delegate:self];
    [imagePicker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos,NSArray * assets,BOOL success)
     {
         
         imageArray = photos;
         if(imageArray.count!=0)
         {
             [weakSelf layoutCollectionView];
         }
     }];
    [self presentViewController:imagePicker animated:YES completion:nil];
}
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    imagePicker.sortAscendingByModificationDate = NO;
    imagePicker.photoWidth = 1024.0;
    imagePicker.photoPreviewMaxWidth = 3072.0;
    [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
}
#pragma mark 创建CollectionView
-(void)layoutCollectionView
{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(351*WScale, 212*WScale);
    collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 334*WScale, ScreenW-18, 111*3+100) collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[QDDetailCollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker * make){
        make.left.equalTo(self.view.left).offset(12*WScale);
        make.width.equalTo(351*WScale);
        make.top.equalTo(photoButton.bottom).offset(15*HScale);
        make.height.equalTo(260*HScale);
    }];
}

#pragma mark collectionView Delegate and dataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return imageArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QDDetailCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    [cell.img setImage:imageArray[indexPath.row]];
    return cell;
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
