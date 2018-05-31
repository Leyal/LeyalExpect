//
//  PushDynamicVC.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/25.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "PushDynamicVC.h"
#import <TZImagePickerController.h>
#import "QDDetailCollectionViewCell.h"
#import "PushViewController.h"
@interface PushDynamicVC ()<UITextViewDelegate,TZImagePickerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation PushDynamicVC
{
    UITextView * dynamicTextView;
    UIButton * photoButton;
    UICollectionView * imgView;
    TZImagePickerController * imagePicker;
    NSArray * imageArray;
    UICollectionView * collectionView;
    UILabel * placeholder;
    UIButton * pushButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor redColor];
    [self setLayout];
}
#pragma mark 退出键盘
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [dynamicTextView resignFirstResponder];
}
#pragma mark 加载布局
-(void)setLayout
{

    //输入框
    dynamicTextView = [[UITextView alloc]init];
    dynamicTextView.backgroundColor = [UIColor RGB:238 andG:238 andB:238 alpha:1];
    dynamicTextView.delegate = self;
    dynamicTextView.font = [UIFont systemFontOfSize:16];
    dynamicTextView.textColor = [UIColor blackColor];
    [self.view addSubview:dynamicTextView];
    [dynamicTextView mas_makeConstraints:^(MASConstraintMaker * make){
        make.left.equalTo(self.view.left).offset(12*WScale);
        make.right.equalTo(self.view.right).offset(-12*WScale);
        make.top.equalTo(self.view.top).offset(0*HScale);
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
-(void)dismissKeyBoard
{
    [dynamicTextView resignFirstResponder];
}
#pragma mark UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView
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
#pragma mark 发布
-(void)clickPushButton
{
    AVObject * obj = [AVObject objectWithClassName:@"Dynamic"];
//    AVUser * user = [AVUser currentUser];
//    [obj setObject:@"雷源" forKey:@"name"];//name
    [obj setObject:dynamicTextView.text forKey:@"content"];//content
    // 获取系统当前时间
    NSDate * date = [NSDate date];
    NSTimeInterval sec = [date timeIntervalSinceNow];
    NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
    
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
    [obj setObject:@"0" forKey:@"goodcount"];
    [obj setObject:na forKey:@"pushtime"];//createtime
    [obj setObject:[NSString stringWithFormat:@"%lu",(unsigned long)imageArray.count] forKey:@"imgcount"];//imgcount
    [obj setObject:@"0" forKey:@"lookcount"];//lookcount
    [obj setObject:@"0" forKey:@"isgood"];
    CGFloat pushImageQuality = 100;
    if(imageArray.count == 1)
    {
        NSData * data = UIImageJPEGRepresentation(imageArray[0], pushImageQuality);
        AVFile * file = [AVFile fileWithData:data];//img
        [obj setObject:file forKey:@"imgUrl0"];
       
    }
    else if (imageArray.count == 2)
    {
        NSData * data0 = UIImageJPEGRepresentation(imageArray[0], pushImageQuality);
        AVFile * file0 = [AVFile fileWithData:data0];//img
        [obj setObject:file0 forKey:@"imgUrl0"];
        
        NSData * data1 = UIImageJPEGRepresentation(imageArray[1],pushImageQuality);
        AVFile * file1 = [AVFile fileWithData:data1];//img
        [obj setObject:file1 forKey:@"imgUrl1"];
        
    }
    else if (imageArray.count == 3)
    {
        NSData * data0 = UIImageJPEGRepresentation(imageArray[0],pushImageQuality);
        AVFile * file0 = [AVFile fileWithData:data0];//img
        [obj setObject:file0 forKey:@"imgUrl0"];
        
        NSData * data1 = UIImageJPEGRepresentation(imageArray[1],pushImageQuality);
        AVFile * file1 = [AVFile fileWithData:data1];//img
        [obj setObject:file1 forKey:@"imgUrl1"];
        
        NSData * data2 = UIImageJPEGRepresentation(imageArray[2],pushImageQuality);
        AVFile * file2 = [AVFile fileWithData:data2];//img
        [obj setObject:file2 forKey:@"imgUrl2"];
    }
    else if (imageArray.count == 4)
    {
        NSData * data0 = UIImageJPEGRepresentation(imageArray[0],pushImageQuality);
        AVFile * file0 = [AVFile fileWithData:data0];//img
        [obj setObject:file0 forKey:@"imgUrl0"];
        
        NSData * data1 = UIImageJPEGRepresentation(imageArray[1],pushImageQuality);
        AVFile * file1 = [AVFile fileWithData:data1];//img
        [obj setObject:file1 forKey:@"imgUrl1"];
        
        NSData * data2 = UIImageJPEGRepresentation(imageArray[2],pushImageQuality);
        AVFile * file2 = [AVFile fileWithData:data2];//img
        [obj setObject:file2 forKey:@"imgUrl2"];
        
        NSData * data3 = UIImageJPEGRepresentation(imageArray[3],pushImageQuality);
        AVFile * file3 = [AVFile fileWithData:data3];//img
        [obj setObject:file3 forKey:@"imgUrl3"];
    }
    else if (imageArray.count == 5)
    {
        NSData * data0 = UIImageJPEGRepresentation(imageArray[0],pushImageQuality);
        AVFile * file0 = [AVFile fileWithData:data0];//img
        [obj setObject:file0 forKey:@"imgUrl0"];
        
        NSData * data1 = UIImageJPEGRepresentation(imageArray[1],pushImageQuality);
        AVFile * file1 = [AVFile fileWithData:data1];//img
        [obj setObject:file1 forKey:@"imgUrl1"];
        
        NSData * data2 = UIImageJPEGRepresentation(imageArray[2],pushImageQuality);
        AVFile * file2 = [AVFile fileWithData:data2];//img
        [obj setObject:file2 forKey:@"imgUrl2"];
        
        NSData * data3 = UIImageJPEGRepresentation(imageArray[3],pushImageQuality);
        AVFile * file3 = [AVFile fileWithData:data3];//img
        [obj setObject:file3 forKey:@"imgUrl3"];
        
        NSData * data4 = UIImageJPEGRepresentation(imageArray[4],pushImageQuality);
        AVFile * file4 = [AVFile fileWithData:data4];//img
        [obj setObject:file4 forKey:@"imgUrl4"];
    }
    else if (imageArray.count == 6)
    {
        NSData * data0 = UIImageJPEGRepresentation(imageArray[0],pushImageQuality);
        AVFile * file0 = [AVFile fileWithData:data0];//img
        [obj setObject:file0 forKey:@"imgUrl0"];
        
        NSData * data1 = UIImageJPEGRepresentation(imageArray[1],pushImageQuality);
        AVFile * file1 = [AVFile fileWithData:data1];//img
        [obj setObject:file1 forKey:@"imgUrl1"];
        
        NSData * data2 = UIImageJPEGRepresentation(imageArray[2],pushImageQuality);
        AVFile * file2 = [AVFile fileWithData:data2];//img
        [obj setObject:file2 forKey:@"imgUrl2"];
        
        NSData * data3 = UIImageJPEGRepresentation(imageArray[3],pushImageQuality);
        AVFile * file3 = [AVFile fileWithData:data3];//img
        [obj setObject:file3 forKey:@"imgUrl3"];
        
        NSData * data4 = UIImageJPEGRepresentation(imageArray[4],pushImageQuality);
        AVFile * file4 = [AVFile fileWithData:data4];//img
        [obj setObject:file4 forKey:@"imgUrl4"];
        
        NSData * data5 = UIImageJPEGRepresentation(imageArray[5],pushImageQuality);
        AVFile * file5 = [AVFile fileWithData:data5];//img
        [obj setObject:file5 forKey:@"imgUrl5"];
    }
    else if (imageArray.count == 7)
    {
        NSData * data0 = UIImageJPEGRepresentation(imageArray[0],pushImageQuality);
        AVFile * file0 = [AVFile fileWithData:data0];//img
        [obj setObject:file0 forKey:@"imgUrl0"];
        
        NSData * data1 = UIImageJPEGRepresentation(imageArray[1],pushImageQuality);
        AVFile * file1 = [AVFile fileWithData:data1];//img
        [obj setObject:file1 forKey:@"imgUrl1"];
        
        NSData * data2 = UIImageJPEGRepresentation(imageArray[2],pushImageQuality);
        AVFile * file2 = [AVFile fileWithData:data2];//img
        [obj setObject:file2 forKey:@"imgUrl2"];
        
        NSData * data3 = UIImageJPEGRepresentation(imageArray[3],pushImageQuality);
        AVFile * file3 = [AVFile fileWithData:data3];//img
        [obj setObject:file3 forKey:@"imgUrl3"];
        
        NSData * data4 = UIImageJPEGRepresentation(imageArray[4],pushImageQuality);
        AVFile * file4 = [AVFile fileWithData:data4];//img
        [obj setObject:file4 forKey:@"imgUrl4"];
        
        NSData * data5 = UIImageJPEGRepresentation(imageArray[5],pushImageQuality);
        AVFile * file5 = [AVFile fileWithData:data5];//img
        [obj setObject:file5 forKey:@"imgUrl5"];
        
        NSData * data6 = UIImageJPEGRepresentation(imageArray[6],pushImageQuality);
        AVFile * file6 = [AVFile fileWithData:data6];//img
        [obj setObject:file6 forKey:@"imgUrl6"];
    }
    else if (imageArray.count == 8)
    {
        NSData * data0 = UIImageJPEGRepresentation(imageArray[0],pushImageQuality);
        AVFile * file0 = [AVFile fileWithData:data0];//img
        [obj setObject:file0 forKey:@"imgUrl0"];
        
        NSData * data1 = UIImageJPEGRepresentation(imageArray[1],pushImageQuality);
        AVFile * file1 = [AVFile fileWithData:data1];//img
        [obj setObject:file1 forKey:@"imgUrl1"];
        
        NSData * data2 = UIImageJPEGRepresentation(imageArray[2],pushImageQuality);
        AVFile * file2 = [AVFile fileWithData:data2];//img
        [obj setObject:file2 forKey:@"imgUrl2"];
        
        NSData * data3 = UIImageJPEGRepresentation(imageArray[3],pushImageQuality);
        AVFile * file3 = [AVFile fileWithData:data3];//img
        [obj setObject:file3 forKey:@"imgUrl3"];
        
        NSData * data4 = UIImageJPEGRepresentation(imageArray[4],pushImageQuality);
        AVFile * file4 = [AVFile fileWithData:data4];//img
        [obj setObject:file4 forKey:@"imgUrl4"];
        
        NSData * data5 = UIImageJPEGRepresentation(imageArray[5],pushImageQuality);
        AVFile * file5 = [AVFile fileWithData:data5];//img
        [obj setObject:file5 forKey:@"imgUrl5"];
        
        NSData * data6 = UIImageJPEGRepresentation(imageArray[6],pushImageQuality);
        AVFile * file6 = [AVFile fileWithData:data6];//img
        [obj setObject:file6 forKey:@"imgUrl6"];
        
        NSData * data7 = UIImageJPEGRepresentation(imageArray[7],pushImageQuality);
        AVFile * file7 = [AVFile fileWithData:data7];//img
        [obj setObject:file7 forKey:@"imgUrl7"];
    }
    else
    {
        NSData * data0 = UIImageJPEGRepresentation(imageArray[0],pushImageQuality);
        AVFile * file0 = [AVFile fileWithData:data0];//img
        [obj setObject:file0 forKey:@"imgUrl0"];
        
        NSData * data1 = UIImageJPEGRepresentation(imageArray[1],pushImageQuality);
        AVFile * file1 = [AVFile fileWithData:data1];//img
        [obj setObject:file1 forKey:@"imgUrl1"];
        
        NSData * data2 = UIImageJPEGRepresentation(imageArray[2],pushImageQuality);
        AVFile * file2 = [AVFile fileWithData:data2];//img
        [obj setObject:file2 forKey:@"imgUrl2"];
        
        NSData * data3 = UIImageJPEGRepresentation(imageArray[3],pushImageQuality);
        AVFile * file3 = [AVFile fileWithData:data3];//img
        [obj setObject:file3 forKey:@"imgUrl3"];
        
        NSData * data4 = UIImageJPEGRepresentation(imageArray[4],pushImageQuality);
        AVFile * file4 = [AVFile fileWithData:data4];//img
        [obj setObject:file4 forKey:@"imgUrl4"];
        
        NSData * data5 = UIImageJPEGRepresentation(imageArray[5],pushImageQuality);
        AVFile * file5 = [AVFile fileWithData:data5];//img
        [obj setObject:file5 forKey:@"imgUrl5"];
        
        NSData * data6 = UIImageJPEGRepresentation(imageArray[6],pushImageQuality);
        AVFile * file6 = [AVFile fileWithData:data6];//img
        [obj setObject:file6 forKey:@"imgUrl6"];
        
        NSData * data7 = UIImageJPEGRepresentation(imageArray[7],pushImageQuality);
        AVFile * file7 = [AVFile fileWithData:data7];//img
        [obj setObject:file7 forKey:@"imgUrl7"];
        
        NSData * data8 = UIImageJPEGRepresentation(imageArray[8],pushImageQuality);
        AVFile * file8 = [AVFile fileWithData:data8];//img
        [obj setObject:file8 forKey:@"imgUrl8"];
    }
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
#pragma mark 点击拍照按钮
-(void)photoButtonClick
{
    __weak typeof(self) weakSelf = self;//弱引用
    imagePicker = [[TZImagePickerController alloc]initWithMaxImagesCount:9 delegate:self];
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
    flowLayout.itemSize = CGSizeMake(110*WScale, 112*WScale);
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
        make.height.equalTo(400*HScale);
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
