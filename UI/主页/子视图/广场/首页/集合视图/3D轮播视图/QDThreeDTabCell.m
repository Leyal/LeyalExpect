//
//  QDThreeDTabCell.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/21.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "QDThreeDTabCell.h"
@interface QDThreeDTabCell()<SDCycleScrollViewDelegate,JECalourseViewDataSource>
@end
@implementation QDThreeDTabCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _verticalScrollView = [[JECalourseView alloc]initWithFrame:CGRectMake(127*WScale, 5*HScale, 120*WScale, 150*HScale)];
        _verticalScrollView.DataSource = self;
//        [_verticalScrollView setDataSource:self];
        [self.contentView addSubview:_verticalScrollView];
//        [_verticalScrollView mas_makeConstraints:^(MASConstraintMaker * make){
//            make.center.equalTo(self);
//            make.height.equalTo(self);
//            make.width.equalTo(self.height);
//        }];
        
//        _scrollView = [[SDCycleScrollView alloc]init];
//        _scrollView.delegate = self;
//        _scrollView.localizationImageNamesGroup = @[@"3dimg0",@"3dimg1",@"3dimg2"];
//        _scrollView.autoScrollTimeInterval = 4;
//        _scrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
//        _scrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
//        _scrollView.frame = CGRectMake(0, 0, ScreenH, 150*HScale);
//        [self.contentView addSubview:_scrollView];
        
        
    }
    return self;
}

#pragma mark 3d轮播代理
-(NSInteger)JE3DCalourseNumber
{
    return 5;
}

-(void)JE3DCalourseViewWith:(JECalourseCell *)Cell andIndex:(NSInteger)index
{

    [Cell.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"3dimg%ld",(long)index]]];
    
    //    [Cell.imageView sd_setImageWithURL:[NSURL URLWithString:]]

}
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"%ld",index);
    [self.ThreeDelegate TotaoBao];
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
