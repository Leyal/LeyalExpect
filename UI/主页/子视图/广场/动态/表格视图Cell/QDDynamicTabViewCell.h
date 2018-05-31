//
//  QDDynamicTabViewCell.h
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/23.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import <UIKit/UIKit.h>
//@protocol QDDynamicDelegate<NSObject>
//-(void)clickGoodButton:(NSIndexPath *)indexPath;
//@end

@class QDDynamicTabViewCellModel;
@interface QDDynamicTabViewCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong) UIImageView * icon;
@property(nonatomic,strong) UILabel * nameLabel;
@property(nonatomic,strong) UILabel * timeLabel;
@property(nonatomic,strong) UILabel * contentLabel;
@property(nonatomic,strong) UICollectionView * collectionView;
@property(nonatomic,strong) UILabel * lookCountLabel;
@property(nonatomic,strong) UIButton * goodButton;
//@property(nonatomic,assign) NSInteger imgCount;
@property(nonatomic,strong) NSMutableArray * imgModelArray;
@property(nonatomic,strong) QDDynamicTabViewCellModel * model;
@property(nonatomic,strong) UICollectionViewFlowLayout * layout;
@property(nonatomic,strong) UILabel * likeLabel;
@property(nonatomic,strong) UIButton * shareButton;
@property(nonatomic,strong) UILabel * shareLabel;

//@property(nonatomic,weak) id <QDDynamicDelegate>delegate;
-(CGFloat)getCellHeight;
@end
