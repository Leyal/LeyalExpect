//
//  UIImage+ToData.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/26.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "UIImage+ToData.h"

@implementation UIImage (ToData)
//将UIImage转换为NSData

+(NSData*)getDataFromImage:(UIImage*)image{
    
    NSData *data;
    
    /*判断图片是不是png格式的文件*/
    
    if(UIImagePNGRepresentation(image))
        
        data = UIImagePNGRepresentation(image);
    
    /*判断图片是不是jpeg格式的文件*/
    
    else
        
        data = UIImageJPEGRepresentation(image,1.0);
    
    return data;
}
@end
