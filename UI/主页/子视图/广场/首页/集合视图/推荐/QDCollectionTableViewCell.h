//
//  QDCollectionTableViewCell.h
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/22.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol QDCollectionViewSelectDelegate<NSObject>
@optional
-(void)TransformVC:(NSIndexPath *)indexPath;
@end
@interface QDCollectionTableViewCell : UITableViewCell
@property(nonatomic,strong) UICollectionView * collectionView;
@property(nonatomic,strong) NSMutableArray * adImageArray;
@property(nonatomic,weak) id<QDCollectionViewSelectDelegate> delegate;
//- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath;
@end
