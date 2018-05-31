//
//  UIColor+SetRGB.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/10/31.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "UIColor+SetRGB.h"

@implementation UIColor (SetRGB)
+(UIColor *)RGB:(CGFloat)r andG:(CGFloat)g andB:(CGFloat)b alpha:(CGFloat) alp
{
    UIColor * color = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alp];
    return color;
}
@end
