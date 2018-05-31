//
//  QD_collectionCell.h
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/11.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CollectionViewModel;
@interface QD_collectionCell : UICollectionViewCell
@property(nonatomic,strong) UIImageView * imgView;
@property(nonatomic,strong) UILabel * textLabel;
@property(nonatomic,strong) CollectionViewModel * model;
@property(nonatomic,strong) UIImageView * eyeView;
@property(nonatomic,strong) UILabel * lookCountLabel;
@end
