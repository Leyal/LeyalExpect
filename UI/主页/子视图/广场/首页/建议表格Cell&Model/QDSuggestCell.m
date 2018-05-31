//
//  QDSuggestCell.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/22.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "QDSuggestCell.h"
#import "QDSuggestModel.h"
@implementation QDSuggestCell
#pragma mark -设置cell的间距
-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 5;
    [super setFrame:frame];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
//        //分割线
//        self.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
//        self.layoutMargins = UIEdgeInsetsZero;
//        self.preservesSuperviewLayoutMargins = false;
        
        //建议图标
        _logoView = [[UIImageView alloc]init];
        _logoView.image = [UIImage imageNamed:@"suggest_logo"];
        [self.contentView addSubview:_logoView];
        [_logoView mas_makeConstraints:^(MASConstraintMaker * make){
            make.left.equalTo(self.left).offset(5*WScale);
            make.centerY.equalTo(self);
            make.width.equalTo(20*WScale);
            make.height.equalTo(14*HScale);
        }];
        //标题
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker * make){
            make.left.equalTo(_logoView.right).offset(5*WScale);
            make.centerY.equalTo(self);
            make.width.equalTo(200*WScale);
            make.height.equalTo(40*HScale);
        }];
        
        //图片
        _imgView = [[UIImageView alloc]init];
//        _imgView.layer.cornerRadius = 45*WScale/2;
//        _imgView.layer.masksToBounds = YES;
        [self.contentView addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker * make){
//            make.left.equalTo(_titleLabel.right).offset(3*WScale);
            make.width.equalTo(145*WScale);
            make.centerY.equalTo(self);
            make.right.equalTo(self.right);
            make.height.equalTo(self);
        }];
    }
    return self;
}
#pragma mark model的set方法
-(void)setModel:(QDSuggestModel *)model
{
    _model = model;
    [self loadData];
}
#pragma mark 填充数据
-(void)loadData
{
    _titleLabel.text = self.model.title;
    NSLog(@"%@",self.model.title);
    [_imgView sd_setImageWithURL:[NSURL URLWithString:self.model.imgUrl]];
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
