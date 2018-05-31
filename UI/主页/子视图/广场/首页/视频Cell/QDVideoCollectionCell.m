//
//  QDVideoCollectionCell.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/23.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "QDVideoCollectionCell.h"
#import "QDVideoModel.h"
@implementation QDVideoCollectionCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        //图片
        _firstImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_firstImageView];
        [_firstImageView mas_makeConstraints:^(MASConstraintMaker * make){
            make.left.equalTo(self);
            make.top.equalTo(self);
            make.width.equalTo(self);
            make.height.equalTo(174*HScale);
        }];
        
        //视频logo
        _lookCountImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"video_look_count"]];
        [_firstImageView addSubview:_lookCountImageView];
        [_lookCountImageView mas_makeConstraints:^(MASConstraintMaker * make){
            make.right.equalTo(_firstImageView.right).offset(-30*WScale);
            make.top.equalTo(_firstImageView.top).offset(5*HScale);
            make.width.equalTo(17*WScale);
            make.height.equalTo(14*HScale);
        }];
        
        //标题
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
//        _titleLabel.textColor = [UIColor RGB:240 andG:121 andB:153 alpha:1];
        _titleLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker * make){
            make.left.equalTo(self.left).offset(10*WScale);
            make.top.equalTo(_firstImageView.bottom).offset(5*HScale);
            make.width.equalTo(self);
            make.height.equalTo(20*HScale);
        }];
        
        //浏览次数
        _lookCountLabel = [[UILabel alloc]init];
        _lookCountLabel.textColor = [UIColor whiteColor];
        _lookCountLabel.font = [UIFont systemFontOfSize:10];
        [_firstImageView addSubview:_lookCountLabel];
        [_lookCountLabel mas_makeConstraints:^(MASConstraintMaker * make){
            make.centerY.equalTo(_lookCountImageView);
            make.left.equalTo(_lookCountImageView.right).offset(3*WScale);
            make.width.equalTo(20*WScale);
            make.height.equalTo(20*HScale);
        }];
        
    }
    return self;
}

-(void)setModel:(QDVideoModel *)model
{
    _model = model;
    [self loadData];
}
-(void)loadData
{
//    [_firstImageView sd_setImageWithURL:[NSURL URLWithString:self.model.firstImgUrl] completed:^(UIImage * image,NSError * error,SDImageCacheType cachetype,NSURL * imageUrl){
//        CGFloat imgW = CGImageGetWidth(image.CGImage);
//        CGFloat imgH = CGImageGetHeight(image.CGImage);
////        if(imgCount == 1)
////        {
////            layout.itemSize = CGSizeMake(354*WScale, 354*HScale/(imgW/imgH));
////        }
//    }];
    [_firstImageView sd_setImageWithURL:[NSURL URLWithString:self.model.firstImgUrl]];
    _lookCountLabel.text = self.model.lookCount;
    _titleLabel.text = self.model.title;
    
}
@end
