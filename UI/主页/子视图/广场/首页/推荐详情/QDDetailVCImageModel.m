//
//  QDDetailVCImageModel.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/19.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "QDDetailVCImageModel.h"

@implementation QDDetailVCImageModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"text":@"content",
             @"url0":@"imgUrl0.url",
             @"iconUrl":@"icon.url",
             @"pushtime":@"pushtime",
             @"imgcount":@"imgcount",
             @"phone":@"phone",
             @"lookcount":@"lookcount",
             @"goodcount":@"goodcount",
             @"url1":@"imgUrl1.url",
             @"url2":@"imgUrl2.url",
             @"url3":@"imgUrl3.url",
             @"url4":@"imgUrl4.url",
             @"url5":@"imgUrl5.url",
             @"name":@"name",
             @"objectId":@"objectId",
             @"isGood":@"isgood",
             };
}
@end
