//
//  QDDynamicTabViewCell.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/23.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "QDDynamicTabViewCell.h"
#import "QDDynamicTabViewCellModel.h"
#import "QDDetailCollectionViewCell.h"
#import "NSString+Time.h"
@interface QDDynamicTabViewCell()
//@property(nonatomic,assign)
@end
@implementation QDDynamicTabViewCell
{
    NSInteger imgCount;
    BOOL isGoodButtonCLick;
    __block CGFloat  imgH;
    __block CGFloat  imgW;
    CGFloat height;
}
#pragma mark 自定义分割线
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0xE2/255.0f green:0xE2/255.0f blue:0xE2/255.0f alpha:1].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height - 1, rect.size.width, 1));
}
-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 0.5;
    [super setFrame:frame];
}
//-(NSMutableArray *)imgModelArray
//{
//    if(_imgModelArray == nil)
//    {
//        NSMutableArray *array = [[NSMutableArray alloc]init];
//        _imgModelArray = array;
//    }
//    return _imgModelArray;
//}

//-(void)setFrame:(CGRect)frame
//{
//    frame.size.height -= 1;
//    // 给cellframe赋值
//    [super setFrame:frame];
//}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    //    _imgModelArray = [[NSMutableArray alloc]init];
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //头像
        _icon = [[UIImageView alloc]init];
        _icon.layer.cornerRadius = 25*WScale;
        _icon.layer.masksToBounds = YES;
        [self.contentView addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker * make){
            make.left.equalTo(self.left).offset(12*WScale);
            make.top.equalTo(self.top).offset(15*HScale);
            make.width.equalTo(50*HScale);
            make.height.equalTo(50*HScale);
        }];
        
        //昵称
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker * make){
            make.left.equalTo(_icon.right).offset(15*WScale);
            //            make.top.equalTo(_icon.top).offset(0*HScale);
            make.centerY.equalTo(_icon);
            make.width.equalTo(200*WScale);
            make.height.equalTo(30*HScale);
        }];
        //        //发布时间
        //        _timeLabel = [[UILabel alloc]init];
        //        _timeLabel.font = [UIFont systemFontOfSize:14];
        //        _timeLabel.textColor = [UIColor grayColor];
        //        [self.contentView addSubview:_timeLabel];
        //        [_timeLabel mas_makeConstraints:^(MASConstraintMaker * make){
        //            make.bottom.equalTo(_icon.bottom).offset(-8*HScale);
        //            make.width.equalTo(200*WScale);
        //            make.height.equalTo(10*HScale);
        //            make.left.equalTo(_nameLabel);
        //        }];
        //正文内容
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font= [UIFont systemFontOfSize:16];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker * make){
            make.left.equalTo(self.left).offset(12*WScale);
            make.top.equalTo(_icon.bottom).offset(15*HScale);
            make.width.equalTo(354*WScale);
        }];
        //        //流布局
        _layout = [[UICollectionViewFlowLayout alloc]init];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.minimumInteritemSpacing = .3f;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:_layout];
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[QDDetailCollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
        [self.contentView addSubview:_collectionView];
        [_collectionView mas_remakeConstraints:^(MASConstraintMaker * make){
            make.left.equalTo(self.left).offset(12*WScale);
            make.width.equalTo(351*WScale);
            make.top.equalTo(_contentLabel.bottom).offset(15*HScale);
            make.height.equalTo(380*HScale);
        }];
        
        //        //浏览次数
        //        _lookCountLabel = [[UILabel alloc]init];
        //        _lookCountLabel.font = [UIFont systemFontOfSize:14];
        //        _lookCountLabel.textColor = [UIColor grayColor];
        //        _lookCountLabel.text = [NSString stringWithFormat:@"浏览次数%d次",[self.model.lookcount intValue]];
        //        [self.contentView addSubview:_lookCountLabel];
        //        [_lookCountLabel mas_makeConstraints:^(MASConstraintMaker * make){
        //            make.left.equalTo(self.left).offset(12*WScale);
        //            make.bottom.equalTo(self.bottom).offset(-15*HScale);
        //            make.width.equalTo(100*WScale);
        //            make.height.equalTo(20*HScale);
        //        }];
        //
        //
        
//        //赞
//        _likeLabel = [[UILabel alloc]init];
//        _likeLabel.font = [UIFont systemFontOfSize:15];
//        _likeLabel.textColor = [UIColor RGB:115 andG:111 andB:111 alpha:1];
//        _likeLabel.text = @"赞";
//        [self.contentView addSubview:_likeLabel];
//        [_likeLabel mas_makeConstraints:^(MASConstraintMaker * make){
//            make.right.equalTo(self.right).offset(-12*WScale);
////            make.centerY.equalTo(_icon);
//            make.bottom.equalTo(_collectionView.bottom);
//            make.width.equalTo(20*WScale);
//        }];
//        //点赞按钮
//        _goodButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_goodButton setImage:[UIImage imageNamed:@"good_button_n"] forState:UIControlStateNormal];
//        [_goodButton setImage:[UIImage imageNamed:@"good_button_h"] forState:UIControlStateSelected];
//        //    goodButton.selected = NO;
//        if([self.model.isGood intValue] == 1)
//        {
//            _goodButton.selected = YES;
//        }
//        else
//        {
//            _goodButton.selected = NO;
//            //        isGoodButtonCLick = !isGoodButtonCLick;
//        }
//        [_goodButton addTarget:self action:@selector(goodButtonClick) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:_goodButton];
//        [_goodButton mas_makeConstraints:^(MASConstraintMaker * make){
//            make.right.equalTo(_likeLabel.left).offset(-3*WScale);
//            make.width.equalTo(24*WScale);
//            make.height.equalTo(24*HScale);
//            make.centerY.equalTo(_likeLabel);
//
//        }];
        //分享按钮
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setImage:[UIImage imageNamed:@"focus"] forState:UIControlStateNormal];
        [_shareButton addTarget:self action:@selector(shareButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_shareButton];
        [_shareButton mas_makeConstraints:^(MASConstraintMaker * make){
            make.right.equalTo(self.right).offset(-12*WScale);
            make.centerY.equalTo(_icon);
//            make.bottom.equalTo(_collectionView.bottom);
            make.width.equalTo(24*WScale);
            make.height.equalTo(24*HScale);
        }];
        //        //分享
        //        _shareLabel = [[UILabel alloc]init];
        //        _shareLabel.font = [UIFont systemFontOfSize:15];
        //        _shareLabel.textColor = [UIColor RGB:115 andG:111 andB:111 alpha:1];
        //        _shareLabel.text = @"分享";
        //        [self.contentView addSubview:_shareLabel];
        //        [_shareLabel mas_makeConstraints:^(MASConstraintMaker * make){
        //            make.left.equalTo(_shareButton.right).offset(5*WScale);
        //            make.centerY.equalTo(_shareButton);
        //            make.width.equalTo(50*WScale);
        //        }];
    }
    return self;
}
-(void)shareButtonClick
{
    
}
-(void)setModel:(QDDynamicTabViewCellModel *)model
{
    _model = model;
    [self loadData];
}
-(void)loadData
{
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:self.model.iconUrl]];
    NSString * a = self.model.name;
    NSString * b = [a stringByAppendingFormat:@"."];
    NSString * c = [b stringByAppendingFormat:@"%@次浏览",self.model.lookcount];
    NSString * d = [c stringByAppendingString:@"."];
    NSString * e = [d stringByAppendingString:[NSString compareCurrentTime:self.model.pushtime]];
    self.nameLabel.text = e;
    self.contentLabel.text = self.model.text;
    self.lookCountLabel.text = [NSString stringWithFormat:@"浏览次数%d",[self.model.lookcount intValue]];
    imgCount = [self.model.imgcount integerValue];
    _imgModelArray = [[NSMutableArray alloc]init];
    if(imgCount == 1)
    {
        [_imgModelArray addObject:self.model.url0];
    }else if (imgCount == 2)
    {
        [_imgModelArray addObject:self.model.url0];
        [_imgModelArray addObject:self.model.url1];
        
    }
    else if (imgCount == 3)
    {
        [_imgModelArray addObject:self.model.url0];
        [_imgModelArray addObject:self.model.url1];
        [_imgModelArray addObject:self.model.url2];
    }
    else if (imgCount == 4)
    {
        [_imgModelArray addObject:self.model.url0];
        [_imgModelArray addObject:self.model.url1];
        [_imgModelArray addObject:self.model.url2];
        [_imgModelArray addObject:self.model.url3];
    }
    else if (imgCount == 5)
    {
        [_imgModelArray addObject:self.model.url0];
        [_imgModelArray addObject:self.model.url1];
        [_imgModelArray addObject:self.model.url2];
        [_imgModelArray addObject:self.model.url3];
        [_imgModelArray addObject:self.model.url4];
    }else if(imgCount == 6)
    {
        [_imgModelArray addObject:self.model.url0];
        [_imgModelArray addObject:self.model.url1];
        [_imgModelArray addObject:self.model.url2];
        [_imgModelArray addObject:self.model.url3];
        [_imgModelArray addObject:self.model.url4];
        [_imgModelArray addObject:self.model.url5];
    }
    else if (imgCount == 7)
    {
        [_imgModelArray addObject:self.model.url0];
        [_imgModelArray addObject:self.model.url1];
        [_imgModelArray addObject:self.model.url2];
        [_imgModelArray addObject:self.model.url3];
        [_imgModelArray addObject:self.model.url4];
        [_imgModelArray addObject:self.model.url5];
        [_imgModelArray addObject:self.model.url6];
        
    }
    else if (imgCount == 8)
    {
        [_imgModelArray addObject:self.model.url0];
        [_imgModelArray addObject:self.model.url1];
        [_imgModelArray addObject:self.model.url2];
        [_imgModelArray addObject:self.model.url3];
        [_imgModelArray addObject:self.model.url4];
        [_imgModelArray addObject:self.model.url5];
        [_imgModelArray addObject:self.model.url6];
        [_imgModelArray addObject:self.model.url7];
    }
    else
    {
        [_imgModelArray addObject:self.model.url0];
        [_imgModelArray addObject:self.model.url1];
        [_imgModelArray addObject:self.model.url2];
        [_imgModelArray addObject:self.model.url3];
        [_imgModelArray addObject:self.model.url4];
        [_imgModelArray addObject:self.model.url5];
        [_imgModelArray addObject:self.model.url6];
        [_imgModelArray addObject:self.model.url7];
        [_imgModelArray addObject:self.model.url8];
    }
    [_collectionView reloadData];
}
#pragma mark 点赞按钮点击事件
-(void)goodButtonClick
{
    if(!isGoodButtonCLick)
    {
        _goodButton.selected = YES;
        
        //点赞数加1
        AVObject * object = [AVObject objectWithClassName:@"Dynamic" objectId:self.model.objectId];
        int currentLookCount = [self.model.lookcount intValue];
        int nowLookCount = currentLookCount +1;
        NSString * sNowLookCount = [NSString stringWithFormat:@"%d",nowLookCount];
        [object setObject:sNowLookCount forKey:@"lookcount"];
        [object setObject:@"1" forKey:@"isgood"];
        //        [object saveInBackground];
        [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if(succeeded)
            {
                NSLog(@"更新成功");
            }
            else
            {
                NSLog(@"%@",error);
            }
        }];
        isGoodButtonCLick = ! isGoodButtonCLick;
    }
    else
    {
        NSLog(@"已经点过赞了");
    }
}
#pragma mark UICollectionview DataSource delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return imgCount;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    QDDetailCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    //    [cell.img sd_setImageWithURL:[NSURL URLWithString:imgModelArray[indexPath.row]]];
    //    NSLog(@"图片模型%@",_imgModelArray);
    [cell.img sd_setImageWithURL:[NSURL URLWithString:_imgModelArray[indexPath.row]] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        imgW = CGImageGetWidth(image.CGImage);
        imgH = CGImageGetHeight(image.CGImage);
        
        if(imgCount == 1)
        {
            height =354*HScale/(imgW/imgH);
            NSLog(@"原始图片高度%f",height);
            //            _layout.itemSize = CGSizeMake(354*WScale, 354*HScale/(imgW/imgH));
            _layout.itemSize = CGSizeMake(154*WScale, 154*HScale);
            [_collectionView mas_remakeConstraints:^(MASConstraintMaker * make){
                make.left.equalTo(self.left).offset(12*WScale);
                make.width.equalTo(154*WScale);
                make.top.equalTo(_contentLabel.bottom).offset(15*HScale);
                //                make.height.equalTo(354*HScale/(imgW/imgH));
                make.height.equalTo(154*HScale);
            }];
        }
        else if(imgCount == 2)
        {
            height =175*HScale/(imgW/imgH);
            _layout.itemSize = CGSizeMake(175*WScale, height);
            [_collectionView mas_remakeConstraints:^(MASConstraintMaker * make){
                make.left.equalTo(self.left).offset(12*WScale);
                make.width.equalTo(351*WScale);
                make.top.equalTo(_contentLabel.bottom).offset(15*HScale);
                make.height.equalTo(175*HScale);
            }];
        }
        else if (imgCount == 3)
        {
            //            height =175*HScale/(imgW/imgH);
            _layout.itemSize = CGSizeMake(110*WScale, 112*HScale);
            [_collectionView mas_remakeConstraints:^(MASConstraintMaker * make){
                make.left.equalTo(self.left).offset(12*WScale);
                make.width.equalTo(351*WScale);
                make.top.equalTo(_contentLabel.bottom).offset(15*HScale);
                make.height.equalTo(112*HScale);
            }];
        }
        else if (imgCount >3&&imgCount<=6)
        {
            _layout.itemSize = CGSizeMake(110*WScale, 112*HScale);
            [_collectionView mas_remakeConstraints:^(MASConstraintMaker * make){
                make.left.equalTo(self.left).offset(12*WScale);
                make.width.equalTo(351*WScale);
                make.top.equalTo(_contentLabel.bottom).offset(15*HScale);
                make.height.equalTo(230*HScale);
            }];
        }
        else
        {
            //            _layout.itemSize = CGSizeMake(110*WScale, 130*HScale/(imgW/imgH));
            _layout.itemSize = CGSizeMake(110*WScale, 112*HScale);
            [_collectionView mas_remakeConstraints:^(MASConstraintMaker * make){
                make.left.equalTo(self.left).offset(12*WScale);
                make.width.equalTo(351*WScale);
                make.top.equalTo(_contentLabel.bottom).offset(15*HScale);
                make.height.equalTo(345*HScale);
            }];
        }
        //        [_collectionView reloadData];
    }];
    return cell;
}
-(CGFloat)getCellHeight
{
    NSString * cnt = self.contentLabel.text;
    NSDictionary * attr2 = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGFloat x = [UIScreen mainScreen].bounds.size.width - 5;
    CGSize contentSize = [cnt boundingRectWithSize:CGSizeMake(x, MAXFLOAT) options:
                          NSStringDrawingUsesLineFragmentOrigin attributes:attr2 context:nil].size;
    CGFloat contentH = contentSize.height;
    //    self.contentH = contentH;
    //    return 35+65+contentH + [self.pictureWidth intValue] * (ScreenW - 10) / [self.pictureHeight intValue];
    //    return 35+65+contentH + 200;
    if(cnt)
    {
        if(imgCount == 1)
        {
            return contentH + 270*HScale;
            //            NSLog(@"一张高度%f",contentH + height+135*HScale);
            //            return contentH + height+135*HScale;
        }
        else if(imgCount == 2)
        {
            
            return contentH + 290*HScale;
            //            return contentH + height + 135*HScale;
        }
        else if (imgCount == 3)
        {
            return 240*HScale + contentH;
        }
        else if(imgCount >3&&imgCount<=6)
        {
            //        NSLog(@"$$$%f",contentH + (110*HScale/(imgW/imgH))+400*HScale);
            return 350*HScale+ contentH;
            //        return contentH + (110*HScale/(imgW/imgH))+400*HScale;
        }
        else
        {
            return 470*HScale+contentH;
        }
        
    }
    return 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
