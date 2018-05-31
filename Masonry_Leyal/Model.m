//
//  Model.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/10.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "Model.h"
#import "QD_UserModel.h"
@implementation Model
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}


+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             // 模型属性: JSON key, MJExtension 会自动将 JSON 的 key 替换为你模型中需要的属性
//             @"ID":@"id",
//             @"descrip":@"description",
//             //             @"address":@"address.province",
//             @"dogName":@"address.family[2].dog",
             
             @"imgurl":@"img.url",
             
             };
}


@end
