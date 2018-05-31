//
//  CustomAboutTableViewCell.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/29.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "CustomAboutTableViewCell.h"

@implementation CustomAboutTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _alignRightLabel = [[UILabel alloc]init];
        _alignRightLabel.font = [UIFont systemFontOfSize:14];
        _alignRightLabel.textAlignment = NSTextAlignmentRight;
//        _alignRightLabel.textColor = [UIColor ]
        [self.contentView addSubview:_alignRightLabel];
        [_alignRightLabel mas_makeConstraints:^(MASConstraintMaker * make){
            make.centerY.equalTo(self);
            make.right.equalTo(self.right);
            make.width.equalTo(200*WScale);
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
