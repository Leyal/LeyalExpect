//
//  AboutTableVIewCell.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/29.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "AboutTableVIewCell.h"

@implementation AboutTableVIewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.textLabel.text = @"关于期待";
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
