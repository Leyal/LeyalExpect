//
//  QD_collectionCell.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/11.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "QD_collectionCell.h"
#import "CollectionViewModel.h"
@implementation QD_collectionCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        _imgView = [[UIImageView alloc]init];
        _imgView.backgroundColor = [UIColor yellowColor];
        _imgView.layer.cornerRadius = _imgView.frame.size.width/2;
        _imgView.layer.masksToBounds = YES;
        
//        //贝塞尔曲线
//        UIBezierPath * bezier = [UIBezierPath bezierPathWithRoundedRect:_imgView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(20, 20)];
//        CAShapeLayer * layer = [[CAShapeLayer alloc]init];
//        layer.frame = _imgView.bounds;
//        layer.path = bezier.CGPath;
//        _imgView.layer.mask = layer;
        [self.contentView addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker * make){
            make.left.equalTo(self);
            make.width.equalTo(self.frame.size.width);
            make.height.equalTo(self.frame.size.width);
            make.top.equalTo(self);
        }];
        
        _textLabel = [[UILabel alloc]init];
        _textLabel.font = [UIFont systemFontOfSize:12];
        _textLabel.numberOfLines = 0;//自动换行
        _textLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_textLabel];
        [_textLabel mas_makeConstraints:^(MASConstraintMaker * make){
            make.left.equalTo(_imgView);
            make.width.equalTo(_imgView);
            make.top.equalTo(_imgView.bottom);
            make.height.equalTo(35*HScale);
            
        }];
        //浏览次数图片
        _eyeView = [[UIImageView alloc]init];
        _eyeView.image = [UIImage imageNamed:@"eye"];
        [_imgView addSubview:_eyeView];
        [_eyeView mas_makeConstraints:^(MASConstraintMaker * make){
            make.right.equalTo(_imgView.right).offset(-20*WScale);
            make.top.equalTo(_imgView.top).offset(5*HScale);
            make.width.equalTo(17*WScale);
            make.height.equalTo(17*HScale);
        }];
        //浏览次数
        _lookCountLabel = [[UILabel alloc]init];
        _lookCountLabel.textColor = [UIColor whiteColor];
        _lookCountLabel.font = [UIFont systemFontOfSize:12];
        [_imgView addSubview:_lookCountLabel];
        [_lookCountLabel mas_makeConstraints:^(MASConstraintMaker * make){
            make.centerY.equalTo(_eyeView);
            make.left.equalTo(_eyeView.right).offset(3*WScale);
            make.width.equalTo(20*WScale);
            make.height.equalTo(20*HScale);
        }];
        
    }
    return self;
}
-(void)setModel:(CollectionViewModel *)model
{
    _model = model;
    [self loadData];
}
-(void)loadData
{
    CollectionViewModel * Model = self.model;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:Model.url0]];
//    [_imgView sd_setImageWithURL:[NSURL URLWithString:Model.url0] completed:^(UIImage * image,NSError * error,SDImageCacheType type,NSURL * url){
//        CGFloat imgW = CGImageGetWidth(image.CGImage);
//        CGFloat imgH = CGImageGetHeight(image.CGImage);
//        CGFloat selfW = self.bounds.size.width;
//        [_imgView mas_remakeConstraints:^(MASConstraintMaker * make){
//            make.left.equalTo(self);
//            make.top.equalTo(self);
//            make.width.equalTo(self);
//            make.height.equalTo(selfW/(imgW/imgH));
//        }];
//
//    }];
    _textLabel.text = Model.text;
    _lookCountLabel.text = Model.lookcount;
}
@end
