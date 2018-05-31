//
//  GYLClearCacheCell.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/29.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "GYLClearCacheCell.h"
#import <SDImageCache.h>
#import <SVProgressHUD.h>
@implementation GYLClearCacheCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 设置加载视图
//        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        [loadingView startAnimating];
//        self.accessoryView = loadingView;
        
        self.textLabel.text = @"清理缓存";
        //        [self.textLabel setTextColor:[UIColor blueColor]];
        CGFloat folderSize = 0.0;
        
        //获取路径
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)firstObject];
        
        //获取所有文件的数组
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
        
        NSLog(@"文件数：%ld",files.count);
        
        for(NSString *path in files) {
            
            NSString*filePath = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",path]];
            
            //累加
            folderSize += [[NSFileManager defaultManager]attributesOfItemAtPath:filePath error:nil].fileSize;
        }
        //转换为M为单位
        CGFloat sizeM = folderSize /1024.0/1024.0;
        
        _label = [[UILabel alloc]init];
        _label.font = [UIFont systemFontOfSize:16];
        _label.textColor = [UIColor darkGrayColor];
        int a;
        a = (int)sizeM;
        _label.text =[NSString stringWithFormat:@"%dM",a];
        [self.contentView addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker * make){
            make.right.equalTo(self.right).offset(-50*WScale);
            make.centerY.equalTo(self);
        }];
        
    }
        
    
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
