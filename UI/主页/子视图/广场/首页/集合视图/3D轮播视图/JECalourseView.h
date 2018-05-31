//
//  JECalourseView.h
//  NSU_Time
//
//  Created by 雷源 on 2017/10/26.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JECalourseCell.h"
@protocol JECalourseViewDataSource <NSObject>

@required
-(void)JE3DCalourseViewWith:(JECalourseCell*)Cell andIndex:(NSInteger)index;
-(NSInteger)JE3DCalourseNumber;
@end


@interface JECalourseView : UIView
@property(nonatomic,assign)CGFloat scaleFloat;
@property(nonatomic,assign)CGFloat margin;
@property(nonatomic,weak)id<JECalourseViewDataSource>DataSource;

-(void)animationChange;
@end
