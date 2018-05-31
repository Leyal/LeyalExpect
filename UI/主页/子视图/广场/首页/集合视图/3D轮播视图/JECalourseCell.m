//
//  JECalourseCell.m
//  NSU_Time
//
//  Created by 雷源 on 2017/10/26.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//


#import "JECalourseCell.h"


@implementation JECalourseCell

-(instancetype)init
{
    if (self = [super init]) {
        UIImageView* imageView=[[UIImageView alloc]init];
        [imageView.layer setCornerRadius:6.0f];
        [imageView.layer setMasksToBounds:YES];
        [self addSubview:imageView];
        _imageView=imageView;
    }
    return self;
}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [_imageView setFrame:self.bounds];
}
@end
