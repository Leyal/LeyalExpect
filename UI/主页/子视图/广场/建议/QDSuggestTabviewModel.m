//
//  QDSuggestTabviewModel.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/24.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "QDSuggestTabviewModel.h"

@implementation QDSuggestTabviewModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"iconUrl":@"icon.url",
             @"title":@"title",
             @"name":@"name",
             @"content":@"content",
             @"time":@"createtime",
             @"imgUrl":@"img.url",
             };
}
@end
