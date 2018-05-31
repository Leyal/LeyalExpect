//
//  QDDIYHeader.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/27.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "QDDIYHeader.h"
#import "UIImage+GIFImage.h"
@implementation QDDIYHeader
- (void)prepare{
    [super prepare];
    
    //所有的自定义东西都放在这里
    self.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
    self.stateLabel.font = [UIFont systemFontOfSize:12];
    self.lastUpdatedTimeLabel.hidden = YES;
    self.automaticallyChangeAlpha = YES;
//    self.lastUpdatedTimeLabel.text = @"加载更多内容";
//    [self setTitle:@"即将刷新的状态" forState:MJRefreshStateWillRefresh];
//    [self setTitle:@"所有数据加载完毕，没有更多的数据了" forState:MJRefreshStateNoMoreData];
    
    //一些其他属性设置
    /*
      //设置字体
     self.stateLabel.font = [UIFont systemFontOfSize:15];
     self.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
     
     //设置颜色
     self.stateLabel.textColor = [UIColor redColor];
     self.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
      //隐藏时间
     self.lastUpdatedTimeLabel.hidden = YES;
      隐藏状态
     self.stateLabel.hidden = YES;
      设置自动切换透明度(在导航栏下面自动隐藏)
     self.automaticallyChangeAlpha = YES;
     */
}

//-(void)prepare
//{
//    [super prepare];
///*      gif       */
//
////    self.mj_h = 70*HScale;
////    _gifView = [[UIImageView alloc]initWithImage:[UIImage imageWithGIFNamed:@"gif_cat"]];
////    _gifView.layer.cornerRadius = 25*HScale;
////    _gifView.layer.masksToBounds = YES;
////    self.backgroundColor = [UIColor lightGrayColor];
////    [self addSubview:_gifView];
////    [_gifView mas_makeConstraints:^(MASConstraintMaker * make){
//////        make.centerY.equalTo(self);
////        make.top.equalTo(self.top).offset(10*HScale);
////        make.left.equalTo(self.left).offset(80*WScale);
////        make.height.equalTo(50*HScale);
////        make.width.equalTo(50*WScale);
////    }];
////    _label = [[UILabel alloc]init];
////    _label.textColor = [UIColor blackColor];
////    _label.text = @"已经在拼命刷新了";
////    [self addSubview:_label];
////    [_label mas_makeConstraints:^(MASConstraintMaker * make){
////        make.left.equalTo(_gifView.right).offset(10*WScale);
////        make.width.equalTo(200*WScale);
////        make.height.equalTo(30*HScale);
////        make.centerY.equalTo(_gifView);
////    }];
//
//    /*箭头刷新*/
//    _label = [[UILabel alloc]init];
//    _label.textColor = [UIColor RGB:134 andG:132 andB:132 alpha:1];
//    _label.font = [UIFont systemFontOfSize:12];
//    [self addSubview:_label];
//    [_label mas_makeConstraints:^(MASConstraintMaker * make){
//        make.left.equalTo(self.left).offset(192*WScale);
//        make.bottom.equalTo(self.bottom).offset(-10*HScale);
//    }];
//
//    self.mj_h = 50*HScale;
//    _gifView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"refresh"]];
//    [self addSubview:_gifView];
//    [_gifView mas_makeConstraints:^(MASConstraintMaker * make){
//        make.left.equalTo(self.left).offset(171*WScale);
//        make.centerY.equalTo(_label);
//        make.width.equalTo(9*WScale);
//        make.height.equalTo(18*HScale);
//    }];
//}
//-(void)setState:(MJRefreshState)state
//{
//    MJRefreshCheckState;
//
//    switch (state) {
//        case MJRefreshStateIdle:
//            self.label.text = @"下拉刷新";
//            _gifView.image = [UIImage imageWithGIFNamed:@"refresh"];
//
////            [self.loading stopAnimating];
////            [self.s setOn:NO animated:YES];
////            self.label.text = @"赶紧下拉吖(开关是打酱油滴)";
//            break;
//        case MJRefreshStatePulling:
//            self.gifView.transform=CGAffineTransformMakeRotation(M_PI);
//            _label.text = @"松开刷新";
////            [self.loading stopAnimating];
////            [self.s setOn:YES animated:YES];
////            self.label.text = @"赶紧放开我吧(开关是打酱油滴)";
//            break;
//        case MJRefreshStateRefreshing:
//            self.label.text = @"正在加载";
//            _gifView.image = [UIImage imageWithGIFNamed:@"gif_cat"];
////            _gifView
//
////            [self.s setOn:YES animated:YES];
////            self.label.text = @"加载数据中(开关是打酱油滴)";
////            [self.loading startAnimating];
//            break;
//        default:
//            break;
//    }
//
//}
#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

@end
