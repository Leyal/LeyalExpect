//
//  QDSuggestDetailCell.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/24.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "QDSuggestDetailCell.h"

@implementation QDSuggestDetailCell
//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
//    {
//        //头像
//        _icon = [[UIImageView alloc]init];
//        _icon = [[UIImageView alloc]init];
//        _icon.layer.cornerRadius = 8;
//        _icon.layer.masksToBounds = YES;
//        [self.contentView addSubview:_icon];
//        [_icon mas_makeConstraints:^(MASConstraintMaker * make){
//            make.left.equalTo(self.left).offset(12*WScale);
//            make.top.equalTo(self.top).offset(15*HScale);
//            make.width.equalTo(40*WScale);
//            make.height.equalTo(40*HScale);
//        }];
//        //姓名
//        //时间
//        //标题
//        //
//        //
//    }
//}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
