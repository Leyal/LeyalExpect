//
//  RegisterVC.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/12/14.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "RegisterVC.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <SMS_SDK/SMSSDK.h>
#import "QD_MainTabBarVC.h"

@interface RegisterVC ()
@property(nonatomic,strong) AVPlayer * player;
@property(nonatomic,assign) BOOL IS_PLAY_VOLUME;
@property(nonatomic,strong) UIImageView * validationView;
@property(nonatomic,strong) UITextField * validationTextField;
@property(nonatomic,strong) UIButton * registerButton;

@end

@implementation RegisterVC
#pragma mark 懒加载
//视频播放
-(AVPlayer *)player
{
    if(!_player)
    {
        NSURL * url = [NSURL URLWithString:@"http://ac-ba69fjyb.clouddn.com/a070b91ae39ed0e64a48.mp4"];
        AVAsset * videoAsset = [AVURLAsset URLAssetWithURL:url options:nil];
        AVPlayerItem * item = [AVPlayerItem playerItemWithAsset:videoAsset];
        _player = [AVPlayer playerWithPlayerItem:item];
        _player.volume = 0;
        //
        [_player play];
        
    }
    return _player;
}
-(UIImageView *)validationView
{
    if(!_validationView)
    {
        _validationView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"validation"]];
        _validationView.userInteractionEnabled = YES;
    }
    return _validationView;
}

-(UITextField *)validationTextField
{
    if(!_validationTextField)
    {
        _validationTextField = [[UITextField alloc]init];
        _validationTextField.placeholder = @"请输入您收到的验证码";
        _validationTextField.textColor = [UIColor darkGrayColor];
        _validationTextField.keyboardType = UIKeyboardTypeNumberPad;//数字键盘
        _validationTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _validationTextField;
}
-(UIButton *)registerButton
{
    if(!_registerButton)
    {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setImage:[UIImage imageNamed:@"register"] forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}
#pragma mark ----------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubViews];
    [self setUpUI];
    
}
-(void)addSubViews
{
    AVPlayerLayer * layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    layer.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:layer];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(runLoopTheMove:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    [self.view addSubview:self.validationView];
    [self.validationView addSubview:self.validationTextField];
    [self.view addSubview:self.registerButton];
}
-(void)setUpUI
{
    [self.validationView mas_makeConstraints:^(MASConstraintMaker * make){
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.top).offset(120*HScale);
        make.width.equalTo(225*WScale);
        make.height.equalTo(38*HScale);
    }];
    
    [self.validationTextField mas_makeConstraints:^(MASConstraintMaker * make){
        make.centerY.equalTo(self.validationView);
        make.left.equalTo(self.validationView.left).offset(35*WScale);
        make.width.equalTo(185*WScale);
        make.height.equalTo(35*HScale);
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker * make){
        make.top.equalTo(self.validationView.bottom).offset(30*HScale);
        make.centerX.equalTo(self.view);
        make.width.equalTo(225*WScale);
        make.height.equalTo(38*HScale);
    }];
}
#pragma mark 循环播放
-(void)runLoopTheMove:(NSNotification *)n
{
    AVPlayerItem * p = [n object];
    [p seekToTime:kCMTimeZero];
    [self.player play];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(!_IS_PLAY_VOLUME)
    {
        self.player.volume = 10;
        _IS_PLAY_VOLUME = !_IS_PLAY_VOLUME;
    }
    else
    {
        self.player.volume = 0;
        _IS_PLAY_VOLUME = !_IS_PLAY_VOLUME;
    }
    
}
#pragma mark 点击登录
-(void)registerButtonClick
{
    [SMSSDK commitVerificationCode:self.validationTextField.text phoneNumber:self.phoneNumber zone:@"86" result:^(NSError * error){
       if(!error)
       {
           NSLog(@"验证成功");
           //转换根视图控制器
           [self.validationTextField resignFirstResponder];
//           UIApplication * app = [UIApplication sharedApplication];
//           AppDelegate * app2 = app.delegate;
//           app2.tabBarController = [[QD_MainTabBarVC alloc]init];
//           app2.window.rootViewController = self.tabBarController;
           QD_MainTabBarVC * rootVC = [[QD_MainTabBarVC alloc]init];
           UIApplication * app = [UIApplication sharedApplication];
           app.keyWindow.rootViewController = rootVC;
       }else
       {
           UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"验证码错误" message:@"" preferredStyle:UIAlertControllerStyleAlert];
           UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               //            [alertController dismissViewControllerAnimated:YES completion:nil];
//               [self dismissViewControllerAnimated:YES completion:nil];
           }];
           [alertController addAction:action];
           [self presentViewController:alertController animated:YES completion:nil];
       }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
