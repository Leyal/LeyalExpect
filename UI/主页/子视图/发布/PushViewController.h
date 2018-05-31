//
//  PushViewController.h
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/25.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PushButtonDelegate<NSObject>
-(void)pushButtonClick;
@end
@interface PushViewController : UIViewController
@property(nonatomic,weak) id<PushButtonDelegate> delegate;
@end
