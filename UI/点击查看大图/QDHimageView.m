//
//  QDHimageView.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/19.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "QDHimageView.h"
#import "QDHScanImage.h"
@implementation QDHimageView
- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString*)imageName contentMode:(UIViewContentMode)contentMode ifCheckBigImage:(BOOL)ifCheckBigImage {
    self = [super init];
    if (self) {
        self.frame = frame;
        self.image = [UIImage imageNamed:imageName];
        self.contentMode = contentMode;
        self.userInteractionEnabled = ifCheckBigImage;
    }
    
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scanBigImgClick:)];
    [self addGestureRecognizer:tap];
}
- (void) scanBigImgClick:(UITapGestureRecognizer *)tap {
    UIImageView *clickedImageView = (UIImageView *)tap.view;
    [QDHScanImage scanBigImageWithImageView:clickedImageView];
}

@end
