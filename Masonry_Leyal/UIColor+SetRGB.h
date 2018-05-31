//
//  UIColor+SetRGB.h
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/10/31.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SetRGB)
//-(void)setRGB:Red:(CGFloat)r Green:(CGFloat) g Blue:(CGFloat) b;
+(UIColor *)RGB:(CGFloat)r andG:(CGFloat)g andB:(CGFloat)b alpha:(CGFloat) alp;
@end
