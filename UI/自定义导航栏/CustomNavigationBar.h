//
//  CustomNavigationBar.h
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/24.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomNavigationBarDelegate<NSObject>
-(void)transformVC;
@end
@interface CustomNavigationBar : UIView
@property(nonatomic,strong) UILabel * titleLabel;
@property(nonatomic,strong) UIButton * backButton;
@property(nonatomic,weak) id<CustomNavigationBarDelegate> delegate;
-(instancetype)initWithFrame:(CGRect )frame backgroundColor:(UIColor *)color titleFont:(UIFont *)font title:(NSString *)title;
@end
