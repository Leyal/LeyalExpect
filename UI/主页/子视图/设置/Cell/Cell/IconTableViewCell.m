//
//  IconTableViewCell.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/28.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "IconTableViewCell.h"

@implementation IconTableViewCell
//- (void)drawRect:(CGRect)rect
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
//    CGContextFillRect(context, rect);
//    
//    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0xE2/255.0f green:0xE2/255.0f blue:0xE2/255.0f alpha:1].CGColor);
//    CGContextStrokeRect(context, CGRectMake(0, rect.size.height - 1, rect.size.width, 1));
//}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self= [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
//        _titleLabel = [[UILabel alloc]init];
//        _titleLabel.textColor = [UIColor darkGrayColor];
//        _titleLabel.font = [UIFont systemFontOfSize:16];
//        _titleLabel.text = @"头像";
//        [self.contentView addSubview:_titleLabel];
//        [_titleLabel mas_makeConstraints:^(MASConstraintMaker * make){
//            make.left.equalTo(self.left).offset(12*WScale);
//            make.centerY.equalTo(self);
//        }];
        self.textLabel.text = @"头像";
        
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
//        NSString * name = [userDefaults objectForKey:@"name"];
        NSData * iconData = [userDefaults objectForKey:@"icon"];
        _icon = [[UIImageView alloc]initWithImage:[UIImage imageWithData:iconData]];
        _icon.layer.cornerRadius = 21*WScale;
        _icon.layer.masksToBounds = YES;
        [self.contentView addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker * make){
            make.left.equalTo(self.left).offset(60*WScale);
            make.centerY.equalTo(self);
            make.width.equalTo(42*WScale);
            make.height.equalTo(42*HScale);
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
