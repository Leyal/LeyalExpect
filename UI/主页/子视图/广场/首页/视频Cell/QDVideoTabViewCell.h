//
//  QDVideoTabViewCell.h
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/23.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QDVideoCollectionCell.h"
@protocol QDVideoCollectionCellDelegate<NSObject>
-(void)transformVC:(NSIndexPath *)indexPath;
@end
@interface QDVideoTabViewCell : UITableViewCell
@property(nonatomic,strong) UICollectionView * collectionView;
@property(nonatomic,strong) NSMutableArray * videoArray;
@property(nonatomic,weak) id <QDVideoCollectionCellDelegate> delegate;
@end
