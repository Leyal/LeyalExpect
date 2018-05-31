//
//  QDSuggestViewCell.h
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/22.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol QDSUGCellDelegate<NSObject>
@optional
-(void)QDSuggestVCTransform:(NSIndexPath * )indexPath;
@end
@interface QDSuggestViewCell : UITableViewCell
@property(nonatomic,strong) UITableView * tabView;
@property(nonatomic,strong) UIImageView * recommendReadView;
@property(nonatomic,weak) id<QDSUGCellDelegate> delegate;
@end
