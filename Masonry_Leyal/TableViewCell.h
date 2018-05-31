//
//  TableViewCell.h
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/10.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Model;
@interface TableViewCell : UITableViewCell
@property(nonatomic,strong) Model * model;
@property(nonatomic,strong) UILabel * nameLabel;
@property(nonatomic,strong) UILabel * contentLabel;
@end
