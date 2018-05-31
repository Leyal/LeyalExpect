//
//  CustomNavigationBar.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/24.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "CustomNavigationBar.h"

@implementation CustomNavigationBar
-(instancetype)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)color titleFont:(UIFont *)font title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = color;
        
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backButton];
        [_backButton mas_makeConstraints:^(MASConstraintMaker * make){
            make.left.equalTo(self.left).offset(9*WScale);
            make.top.equalTo(self.top).offset(30);
            make.width.equalTo(24*WScale);
            make.height.equalTo(17*HScale);
        }];
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = title;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = font;
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker * make){
//            make.centerX.equalTo(self.centerX);
            make.left.equalTo(self.left).offset(153*WScale);
            make.width.equalTo(200*WScale);
            make.centerY.equalTo(_backButton);
        }];
    }
    return self;
}
-(void)backButtonClick
{
    [self.delegate transformVC];
}
@end
