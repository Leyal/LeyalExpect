//
//  QDSuggestCell.h
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/22.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QDSuggestModel;
@interface QDSuggestCell : UITableViewCell
@property(nonatomic,strong) UILabel * titleLabel;
@property(nonatomic,strong) UIImageView * logoView;
@property(nonatomic,strong) UIImageView * imgView;
@property(nonatomic,strong) QDSuggestModel * model;
@end
