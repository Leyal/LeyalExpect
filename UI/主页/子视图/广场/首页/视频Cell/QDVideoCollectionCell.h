//
//  QDVideoCollectionCell.h
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/23.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QDVideoModel;
@interface QDVideoCollectionCell : UICollectionViewCell
@property(nonatomic,strong) UIImageView * firstImageView;
@property(nonatomic,strong) UIImageView * lookCountImageView;
@property(nonatomic,strong) UILabel * titleLabel;
@property(nonatomic,strong) UILabel * lookCountLabel;
@property(nonatomic,strong) QDVideoModel * model;
@end
