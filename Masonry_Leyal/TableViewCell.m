//
//  TableViewCell.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/10.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "TableViewCell.h"
#import "Model.h"
@implementation TableViewCell


-(void)setFrame:(CGRect)frame
{
    
    frame.size.height -= 8;
    [super setFrame:frame];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor =[UIColor yellowColor];
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker * make){
            make.left.equalTo(self.left).offset(10);
            make.width.equalTo(100);
        }];
        
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = [UIColor redColor];
        _contentLabel.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker * make){
            make.left.equalTo(_nameLabel.right).offset(10);
            make.width.equalTo(100);
        }];
    }
    
    return self;
}

-(void)setModel:(Model *)model
{
    _model = model;
    [self loadData];
    
}
-(void)loadData
{
    Model * model = self.model;
    self.nameLabel.text = model.text;
    NSLog(@"Cell中的模型的url%@",model.imgurl);
//    self.contentLabel.text = model.content;
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
