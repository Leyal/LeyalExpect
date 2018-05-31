//
//  QDSuggestTableViewCell.h
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/24.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QDHimageView.h"
#import "QDSuggestModel.h"
@class QDSuggestTabviewModel;
@interface QDSuggestTableViewCell : UITableViewCell
@property(nonatomic,strong) UIImageView * icon;
@property(nonatomic,strong) UILabel * nameLabel;
@property(nonatomic,strong) UILabel * timeLabel;
@property(nonatomic,strong) UILabel * titleLabel;
@property(nonatomic,strong) UILabel * contentLabel;
@property(nonatomic,strong) QDHimageView * image;
@property(nonatomic,strong) QDSuggestTabviewModel * model;
@property(nonatomic,strong) QDSuggestModel * mModel;
@property(nonatomic,assign) CGFloat cellHeight;
-(CGFloat)getCellHeight;
@end
