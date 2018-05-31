//
//  QD_SettingVC.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/15.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "QD_SettingVC.h"
#import "IconTableViewCell.h"
#import "NameTableViewCell.h"
#import "GYLClearCacheCell.h"
#import "AboutTableVIewCell.h"
#import <TZImagePickerController.h>
#import "NameViewController.h"
#import "QDDIYHeader.h"
#import "AboutViewController.h"
@interface QD_SettingVC ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate>

@end

@implementation QD_SettingVC
{
    UITableView * tabView;
    TZImagePickerController * imagePicker;
    NSString * updataName;
    NSArray * iconArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [tabView reloadData];
    iconArray = [NSArray array];
    self.view.backgroundColor = [UIColor purpleColor];
    self.navigationController.navigationBar.barTintColor =titleColor;
    //修改导航栏颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    //    self.navigationController.navigationBar.hidden = YES;
    [self setLayout];
}
-(void)setLayout
{
    tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-(44*HScale)) style:UITableViewStyleGrouped];
    tabView.delegate = self;
    tabView.dataSource = self;
    tabView.scrollEnabled = YES;
    tabView.backgroundColor = [UIColor RGB:244 andG:244 andB:244 alpha:1];
    //    tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tabView];
    tabView.mj_header = [QDDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateData)];
//    [tabView.mj_header beginRefreshing];
    [tabView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        if(indexPath.row == 0)
        {
            [tableView registerClass:[IconTableViewCell class] forCellReuseIdentifier:@"IconTableViewCell"];
            IconTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"IconTableViewCell" forIndexPath:indexPath];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            //            IconTableViewCell * cell= [[IconTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IconTableViewCell"];
            return cell;
        }
        else if (indexPath.row ==1)
        {
            [tableView registerClass:[NameTableViewCell class] forCellReuseIdentifier:@"NameTableViewCell"];
            NameTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NameTableViewCell" forIndexPath:indexPath];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
//            cell.nameLabel.text = updataName;
            return cell;
        }
        
        
    }
    else if (indexPath.section == 1)
    {
        if(indexPath.row == 0)
        {
            [tableView registerClass:[GYLClearCacheCell class] forCellReuseIdentifier:@"GYLClearCacheCell"];
            GYLClearCacheCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GYLClearCacheCell" forIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
    }
    else if (indexPath.section == 2)
    {
        [tableView registerClass:[AboutTableVIewCell class] forCellReuseIdentifier:@"AboutTableVIewCell"];
        AboutTableVIewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AboutTableVIewCell" forIndexPath:indexPath];
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    return nil;
}
-(void)updateData
{
    [tabView reloadData];
    [tabView.mj_header endRefreshing];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 2;
    }
    else if (section == 1)
    {
        return 1;
    }
    else
    {
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        switch (indexPath.row) {
            case 0:
                return 50*HScale;
                break;
            case 1:
                return 50*HScale;
                break;
            default:
                break;
        }
        
    }
    else if (indexPath.section == 1)
    {
        switch (indexPath.row) {
            case 0:
                return 50*HScale;
                break;
                
            default:
                break;
        }
    }
    else if (indexPath.section == 2)
    {
        switch (indexPath.row) {
            case 0:
                return 50*HScale;
                break;
                
            default:
                break;
        }
    }
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        if(indexPath.row == 0)
        {
            //头像
            __weak typeof(self) weakSelf = self;//弱引用
            imagePicker = [[TZImagePickerController alloc]initWithMaxImagesCount:1 delegate:self];
            [imagePicker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos,NSArray * assets,BOOL success)
             {
                 iconArray = photos;
                 //                 NSData * data = UIImageJPEGRepresentation(photos[0], 100);
                 //                 //获取头像姓名
                 //                 NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
                 ////                 NSString * name = [userDefaults objectForKey:@"name"];
                 ////                 NSData * iconData = [userDefaults objectForKey:@"icon"];
                 //                 [userDefaults setObject:data forKey:@"icon"];
                 //                 [userDefaults synchronize];
                 ////                 [ reloadData];
                 [weakSelf updataIcon];
             }];
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
        
        else if(indexPath.row == 1)
        {
            //昵称
            NameViewController * nameVC = [[NameViewController alloc]init];
            NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
            NSString * name = [userDefaults objectForKey:@"name"];
            nameVC.name =name;
            NSLog(@"PRIMARY_NAME\n%@",name);
            nameVC.changeName = ^(NSString * s){
                updataName = s;
                NSLog(@"UPDATE_NAME\n%@",s);
            };
            //            [self.navigationController pushViewController:nameVC animated:YES];
            [self presentViewController:nameVC animated:YES completion:nil];
            [tabView reloadData];
        }
    }
    else if (indexPath.section == 1)
    {
        //清理缓存
        //===============清除缓存==============
        //获取路径
        NSString*cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)objectAtIndex:0];
        
        //返回路径中的文件数组
        NSArray*files = [[NSFileManager defaultManager]subpathsAtPath:cachePath];
        
        NSLog(@"文件数：%ld",[files count]);
        for(NSString *p in files){
            NSError*error;
            
            NSString*path = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",p]];
            
            if([[NSFileManager defaultManager]fileExistsAtPath:path])
            {
                BOOL isRemove = [[NSFileManager defaultManager]removeItemAtPath:path error:&error];
                if(isRemove) {
                    NSLog(@"清除成功");
                    [tabView reloadData];
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"清理成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        //            [alertController dismissViewControllerAnimated:YES completion:nil];
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }];
                    [alertController addAction:action];
                    [self presentViewController:alertController animated:YES completion:nil];
                    //这里发送一个通知给外界，外界接收通知，可以做一些操作（比如UIAlertViewController）
                    
                }else{
                    
                    NSLog(@"清除失败");
                    
                }
            }
        }
    }
    else if(indexPath.section == 2)
    {
        if(indexPath.row == 0)
        {
            //关于期待
            AboutViewController * aboutVc = [[AboutViewController alloc]init];
//            [self.navigationController pushViewController:aboutVc animated:YES];
            [self presentViewController:aboutVc animated:YES completion:nil];
        }
    }
}
//- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
//    imagePicker.sortAscendingByModificationDate = NO;
//    imagePicker.photoWidth = 1024.0;
//    imagePicker.photoPreviewMaxWidth = 3072.0;
//    [self presentViewController:imagePicker animated:YES completion:nil];
//}
-(void)updataIcon
{
    NSData * data = UIImageJPEGRepresentation(iconArray[0], 100);
    NSLog(@"图片是否存在%@",iconArray[0]);
    //获取头像姓名
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    //                 NSString * name = [userDefaults objectForKey:@"name"];
    //                 NSData * iconData = [userDefaults objectForKey:@"icon"];
    [userDefaults setObject:data forKey:@"icon"];
    [userDefaults synchronize];
    [tabView reloadData];
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
