//
//  QDRecoomendVideoCell.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/23.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "QDRecoomendVideoCell.h"

@implementation QDRecoomendVideoCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _recommendView = [[UIImageView alloc]init];
        _recommendView.image = [UIImage imageNamed:@"recommend_video"];
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
