//
//  NameViewController.h
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/29.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NameViewController : UIViewController
typedef void(^ChangeName) (id);
@property(nonatomic,copy) ChangeName changeName;
@property(nonatomic,copy) NSString * name;
@end
