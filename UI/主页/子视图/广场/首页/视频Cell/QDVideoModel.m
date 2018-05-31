//
//  QDVideoModel.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/23.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "QDVideoModel.h"

@implementation QDVideoModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"firstImgUrl":@"fisrtimg.url",
             @"lookCount":@"lookcount",
             @"videoUrl":@"video.url",
             @"title":@"title",
             };
}
@end
