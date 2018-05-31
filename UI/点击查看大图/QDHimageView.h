//
//  QDHimageView.h
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/19.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QDHimageView : UIImageView
@property(nonatomic,assign) BOOL ifCheckBigImage;
- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString*)imageName contentMode:(UIViewContentMode)contentMode ifCheckBigImage:(BOOL)ifCheckBigImage;
@end
