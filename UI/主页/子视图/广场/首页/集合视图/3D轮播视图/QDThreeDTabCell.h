//
//  QDThreeDTabCell.h
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/21.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JECalourseView.h"
#import <SDCycleScrollView.h>
@protocol ThreeDDelegate<NSObject>
-(void)TotaoBao;
@end
@interface QDThreeDTabCell : UITableViewCell
@property(nonatomic,strong) JECalourseView * verticalScrollView;
@property(nonatomic,strong) SDCycleScrollView * scrollView;
@property(nonatomic,copy) id<ThreeDDelegate> ThreeDelegate;
@end
