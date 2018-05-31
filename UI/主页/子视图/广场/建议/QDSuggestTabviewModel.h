//
//  QDSuggestTabviewModel.h
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/24.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QDSuggestTabviewModel : NSObject
@property(nonatomic,copy) NSString * iconUrl;
@property(nonatomic,copy) NSString * title;
@property(nonatomic,copy) NSString * name;
@property(nonatomic,copy) NSString * time;
@property(nonatomic,copy) NSString * content;
@property(nonatomic,copy) NSString * imgUrl;
@property(nonatomic,assign) CGFloat cellHeight;
@end
