//
//  QDSuggestTableViewCell.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/24.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "QDSuggestTableViewCell.h"
#import "QDSuggestTabviewModel.h"
#import "NSString+Time.h"
@implementation QDSuggestTableViewCell
-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 5;
    [super setFrame:frame];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //头像
        _icon = [[UIImageView alloc]init];
        _icon.layer.cornerRadius = 25;
        _icon.layer.masksToBounds = YES;
        [self.contentView addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker * make){
            make.left.equalTo(self.left).offset(5*WScale);
            make.top.equalTo(self.top).offset(15*HScale);
            make.width.equalTo(50*HScale);
            make.height.equalTo(50*HScale);
        }];
        //昵称
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:18];
        _nameLabel.textColor = [UIColor RGB:35 andG:41 andB:138 alpha:1];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker * make){
            make.left.equalTo(_icon.right).offset(15*WScale);
            make.top.equalTo(_icon.top).offset(10*HScale);
            make.width.equalTo(200*WScale);
            make.height.equalTo(10*HScale);
        }];
        //发布时间
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker * make){
            make.bottom.equalTo(_icon.bottom).offset(-8*HScale);
            make.width.equalTo(200*WScale);
            make.height.equalTo(10*HScale);
            make.left.equalTo(_nameLabel);
        }];
        //标题
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor grayColor];
//        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.font = [UIFont fontWithName:@"XinDiXiaWuChaJiBenBan-1" size:16];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker * make){
//            make.centerX.equalTo(self);
            make.left.equalTo(self.left).offset(5*WScale);
            make.width.equalTo(300*WScale);
            make.top.equalTo(_timeLabel.bottom).offset(15*HScale);
        }];
        //图片
        _image = [[QDHimageView alloc]init];
        [self.contentView addSubview:_image];
        [_image mas_makeConstraints:^(MASConstraintMaker * make){
            make.left.equalTo(self.left).offset(5*WScale);
            make.top.equalTo(_titleLabel.bottom).offset(15*HScale);
            make.width.equalTo(365*WScale);
            make.height.equalTo(150*HScale);
        }];
        //正文
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = [UIColor grayColor];
        _contentLabel.font = [UIFont systemFontOfSize:16];
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker * make){
            make.left.equalTo(self.left).offset(5*WScale);
            make.top.equalTo(_image.bottom).offset(10*HScale);
            make.width.equalTo(365*WScale);
        }];
 
    }
    return self;
}
#pragma mark model的set方法
-(void)setModel:(QDSuggestTabviewModel *)model
{
    _model = model;
    [self getCellData];
}
#pragma mark 填充cell数据
-(void)getCellData
{
    [self.icon sd_setImageWithURL:[NSURL URLWithString:self.model.iconUrl]];
    self.nameLabel.text = self.model.name;
    self.timeLabel.text = [NSString compareCurrentTime:self.model.time];
    self.titleLabel.text = self.model.title;
    self.contentLabel.text = self.model.content;
    [self.image sd_setImageWithURL:[NSURL URLWithString:self.model.imgUrl]];
}
#pragma mark 获取cell高度
-(CGFloat)getCellHeight
{
    NSString * cnt = self.contentLabel.text;
    NSDictionary * attr2 = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
    CGFloat x = [UIScreen mainScreen].bounds.size.width - 5;
    CGSize contentSize = [cnt boundingRectWithSize:CGSizeMake(x, MAXFLOAT) options:
                          NSStringDrawingUsesLineFragmentOrigin attributes:attr2 context:nil].size;
    CGFloat contentH = contentSize.height;
    return contentH + 285*HScale;
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
