//
//  QDRecommendReadCell.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/22.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "QDRecommendReadCell.h"

@implementation QDRecommendReadCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _recommendReadView = [[UIImageView alloc]init];
        [_recommendReadView setImage:[UIImage imageNamed:@"recommend_read"]];
        [self.contentView addSubview:_recommendReadView];
        [_recommendReadView mas_makeConstraints:^(MASConstraintMaker * make){
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
