//
//  QDRecommendCell.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/22.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "QDRecommendCell.h"

@implementation QDRecommendCell
//-(void)setFrame:(CGRect)frame
//{
//    frame.size.height -= 1;
//    // 给cellframe赋值
//    [super setFrame:frame];
//}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _recommendView = [[UIImageView alloc]init];
        _recommendView.image = [UIImage imageNamed:@"recommend"];
        [self.contentView addSubview:_recommendView];
        [_recommendView mas_makeConstraints:^(MASConstraintMaker * make){
            make.left.equalTo(self.left).offset(2*WScale);
            make.centerY.equalTo(self);
            make.width.equalTo(79*WScale);
            make.height.equalTo(20*HScale);
        }];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
