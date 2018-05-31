//
//  QDDetailCollectionViewCell.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/19.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "QDDetailCollectionViewCell.h"
#import "QDHimageView.h"
@implementation QDDetailCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        _img = [[QDHimageView alloc]init];
        _img.userInteractionEnabled = YES;
        _img.ifCheckBigImage = YES;
//        _img.layer.cornerRadius = 20;
//        _img.layer.masksToBounds = YES;
        _img.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:_img];
        [_img mas_makeConstraints:^(MASConstraintMaker * make){
            make.left.equalTo(self);
            make.width.equalTo(self);
            make.top.equalTo(self);
            make.height.equalTo(self);
        }];
    }
    return self;
    
}
@end
