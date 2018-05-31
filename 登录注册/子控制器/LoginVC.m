//
//  LoginVC.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/12/14.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "LoginVC.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CoreMedia/CoreMedia.h>
#import <QuartzCore/QuartzCore.h>
#import "RegisterVC.h"
#import <SMS_SDK/SMSSDK.h>
@interface LoginVC ()<UITextFieldDelegate>
@property(nonatomic,strong) UIButton * logButton;
@property(nonatomic,strong) UIButton * regButton;
@property(nonatomic,strong) UIView * separateLine;
@property(nonatomic,strong) AVPlayer * player;
@property(nonatomic,strong) UIImageView * phoneNumberView;
@property(nonatomic,strong) UIImageView * passwordView;
@property(nonatomic,strong) UITextField * phoneNumberTextField;
@property(nonatomic,strong) UITextField * passwordTextField;
@property(nonatomic,strong) UIButton * loginButton;
@property(nonatomic,strong) UIButton * musicButton;
@property(nonatomic,strong) CAEmitterLayer * fireEmitter;
@property(nonatomic,strong) CAEmitterLayer * fireEmitter1;
@property(nonatomic,strong) CAEmitterLayer * fireEmitter2;
@property(nonatomic,strong) UITextField * registerPhoneNumber;
@property(nonatomic,strong) UITextField * registerPassword;
@property(nonatomic,strong) UIImageView * confirmPasswordView;
@property(nonatomic,strong) UIButton * registerButton;
@property(nonatomic,strong) UITextField * registerConfirmPassword;
@property(nonatomic,assign) BOOL IS_MUSIC_ON;
@property(nonatomic,assign) BOOL IS_FISRT_CLICK_LOGIN_BUTTON;

@end

@implementation LoginVC
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.player.volume = 0;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self addSubViews];
    [self setUpUI];
}
#pragma mark 添加子视图
-(void)addSubViews
{
    
    
    
    AVPlayerLayer * layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    layer.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:layer];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(runLoopTheMove:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    [self.view addSubview:self.logButton];
    [self.view addSubview:self.separateLine];
    [self.view addSubview:self.regButton];
    
    [self.view addSubview:self.phoneNumberView];
    [self.phoneNumberView addSubview:self.phoneNumberTextField];
    [self.phoneNumberView addSubview:self.registerPhoneNumber];
    
    [self.view addSubview:self.passwordView];
    [self.passwordView addSubview:self.passwordTextField];
    [self.passwordView addSubview:self.registerPassword];
    
    [self.view addSubview:self.confirmPasswordView];
    [self.view addSubview:self.registerConfirmPassword];
    
    [self.view addSubview:self.loginButton];
    
    [self.view addSubview:self.musicButton];
    [self.view addSubview:self.registerButton];
}
-(void)setUpUI
{
    [self.separateLine mas_makeConstraints:^(MASConstraintMaker * make){
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.top).offset(33*HScale);
        make.width.equalTo(1*WScale);
        make.height.equalTo(16*HScale);
    }];
    
    [self.logButton mas_makeConstraints:^(MASConstraintMaker * make){
        make.right.equalTo(self.separateLine.left).offset(-8*WScale);
        make.centerY.equalTo(self.separateLine);
        make.width.equalTo(40*WScale);
        make.height.equalTo(28*HScale);
    }];
    
    [self.regButton mas_makeConstraints:^(MASConstraintMaker * make){
        make.left.equalTo(self.separateLine.right).offset(8*WScale);
        make.centerY.equalTo(self.separateLine);
        make.width.equalTo(40*WScale);
        make.height.equalTo(28*HScale);
    }];
    
    [self.phoneNumberView mas_makeConstraints:^(MASConstraintMaker * make){
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.top).offset(278*HScale);
        make.width.equalTo(225*WScale);
        make.height.equalTo(38*HScale);
    }];
    
    [self.registerPhoneNumber mas_makeConstraints:^(MASConstraintMaker * make){
        make.left.equalTo(self.phoneNumberView.left).offset(35*WScale);
        make.centerY.equalTo(self.phoneNumberView);
        make.width.equalTo(185*WScale);
        make.height.equalTo(35*HScale);
    }];
    
    [self.phoneNumberTextField mas_makeConstraints:^(MASConstraintMaker * make){
        make.left.equalTo(self.phoneNumberView.left).offset(35*WScale);
        make.centerY.equalTo(self.phoneNumberView);
        make.width.equalTo(185*WScale);
        make.height.equalTo(35*HScale);
    }];
    
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker * make){
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.phoneNumberTextField.bottom).offset(30*HScale);
        make.width.equalTo(225*WScale);
        make.height.equalTo(38*HScale);
    }];
    
    [self.registerPassword mas_makeConstraints:^(MASConstraintMaker * make){
        make.left.equalTo(self.passwordView.left).offset(35*WScale);
        make.centerY.equalTo(self.passwordView);
        make.width.equalTo(185*WScale);
        make.height.equalTo(35*HScale);
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker * make){
        make.left.equalTo(self.passwordView.left).offset(35*WScale);
        make.centerY.equalTo(self.passwordView);
        make.width.equalTo(185*WScale);
        make.height.equalTo(35*HScale);
    }];
    
    [self.confirmPasswordView mas_makeConstraints:^(MASConstraintMaker * make){
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.passwordView.bottom).offset(30*HScale);
        make.width.equalTo(225*WScale);
        make.height.equalTo(38*HScale);
    }];
    
    [self.registerConfirmPassword mas_makeConstraints:^(MASConstraintMaker * make){
        make.centerY.equalTo(self.confirmPasswordView);
        make.left.equalTo(self.confirmPasswordView.left).offset(35*WScale);
        make.width.equalTo(185*WScale);
        make.height.equalTo(35*HScale);
    }];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker * make){
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.passwordTextField.bottom).offset(30*HScale);
        make.width.equalTo(225*WScale);
        make.height.equalTo(38*HScale);
    }];
    
    [self.musicButton mas_makeConstraints:^(MASConstraintMaker * make){
        make.right.equalTo(self.view.right).offset(-29*WScale);
        make.bottom.equalTo(self.view.bottom).offset(-29*HScale);
        make.width.equalTo(40*WScale);
        make.height.equalTo(40*HScale);
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker * make){
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.confirmPasswordView.bottom).offset(30*HScale);
        make.width.equalTo(225*WScale);
        make.height.equalTo(38*HScale);
    }];
    //注册界面
    
}
#pragma mark 循环播放
-(void)runLoopTheMove:(NSNotification *)n
{
    AVPlayerItem * p = [n object];
    [p seekToTime:kCMTimeZero];
    [self.player play];
}
#pragma mark 懒加载
-(UIView *)separateLine
{
    if(!_separateLine)
    {
        _separateLine = [[UIView alloc]init];
        _separateLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _separateLine;
}


-(UIButton *)logButton
{
    if(!_logButton)
    {
        _logButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_logButton setTitle:@"登录" forState:UIControlStateNormal];
        [_logButton setTitle:@"登录" forState:UIControlStateSelected];
        _logButton.selected = YES;
//        _logButton.userInteractionEnabled = NO;
        [_logButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_logButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_logButton addTarget:self action:@selector(logButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logButton;
}
-(UIButton *)regButton
{
    if(!_regButton)
    {
        _regButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_regButton setTitle:@"注册" forState:UIControlStateNormal];
        [_regButton setTitle:@"注册" forState:UIControlStateSelected];
        [_regButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_regButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_regButton addTarget:self action:@selector(regButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _regButton;
}
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
//手机号图片
-(UIImageView *)phoneNumberView
{
    if(!_phoneNumberView)
    {
        _phoneNumberView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"phone_number"]];
        _phoneNumberView.userInteractionEnabled = YES;
    }
    return _phoneNumberView;
}
//手机号输入
-(UITextField *)phoneNumberTextField
{
    if(!_phoneNumberTextField)
    {
        _phoneNumberTextField = [[UITextField alloc]init];
        _phoneNumberTextField.placeholder = @"请输入手机号";
        //        _phoneNumberTextField.delegate = self;
        _phoneNumberTextField.textColor = [UIColor darkGrayColor];
        _phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;//数字键盘
        _phoneNumberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _phoneNumberTextField;
}
//密码图片
-(UIImageView *)passwordView
{
    if(!_passwordView)
    {
        _passwordView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"password"]];
        _passwordView.userInteractionEnabled = YES;
    }
    return _passwordView;
}
//密码输入
-(UITextField *)passwordTextField
{
    if(!_passwordTextField)
    {
        _passwordTextField = [[UITextField alloc]init];
        _passwordTextField.placeholder = @"请输入密码";
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_passwordTextField setSecureTextEntry:YES];
        _passwordTextField.delegate = self;
        _passwordTextField.returnKeyType = UIReturnKeyDone;
    }
    return _passwordTextField;
}
//登录按钮
-(UIButton *)loginButton
{
    if(!_loginButton)
    {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}
//音乐按钮
-(UIButton *)musicButton
{
    if(!_musicButton)
    {
        _musicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_musicButton setImage:[UIImage imageNamed:@"music_button"] forState:UIControlStateNormal];
        [_musicButton addTarget:self action:@selector(musicButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _musicButton;
}
//注册界面手机号

//音符动画
-(CAEmitterLayer *)fireEmitter
{
    if(!_fireEmitter)
    {
        _fireEmitter = [[CAEmitterLayer alloc]init];
        _fireEmitter.emitterPosition = CGPointMake(317*WScale, 645*HScale);
        //发射器大小
        _fireEmitter.emitterSize = CGSizeMake(0, 0);//发射区域大小
        _fireEmitter.renderMode = kCAEmitterLayerOldestLast;//附加模式
        //发射单元
        CAEmitterCell * fire = [CAEmitterCell emitterCell];
        fire.birthRate = 0.3;
        fire.lifetime = 3.0;
        fire.lifetimeRange = 1.5;
        
        fire.contents = (id)[[UIImage imageNamed:@"music_1"]CGImage];
        [fire setName:@"fire"];
        fire.velocity = 25;
        fire.velocityRange = 30;
        fire.emissionLongitude = M_PI_4*5;
        fire.emissionRange = M_PI_4/2;
        fire.scaleSpeed = 0.01;
        fire.spin = 0.01;
        _fireEmitter.emitterCells = [NSArray arrayWithObjects:fire, nil];
    }
    return _fireEmitter;
}
-(CAEmitterLayer *)fireEmitter1
{
    if(!_fireEmitter1)
    {
        _fireEmitter1 = [[CAEmitterLayer alloc]init];
        _fireEmitter1.emitterPosition = CGPointMake(317*WScale, 645*HScale);
        //发射器大小
        _fireEmitter1.emitterSize = CGSizeMake(0, 0);//发射区域大小
        _fireEmitter1.renderMode = kCAEmitterLayerOldestLast;//附加模式
        //发射单元
        CAEmitterCell * fire = [CAEmitterCell emitterCell];
        fire.birthRate = 0.5;
        fire.lifetime = 3.0;
        fire.lifetimeRange = 1.5;

        fire.contents = (id)[[UIImage imageNamed:@"music_2"]CGImage];
        [fire setName:@"fire1"];
        fire.velocity = 15;
        fire.velocityRange = 30;
        fire.emissionLongitude = M_PI_4*5;
        fire.emissionRange = M_PI_4/2;
        fire.scaleSpeed = 0.01;
        fire.spin = 0.01;
        _fireEmitter1.emitterCells = [NSArray arrayWithObjects:fire, nil];
    }
    return _fireEmitter1;
}

//注册界面
-(UITextField *)registerPhoneNumber
{
    if(!_registerPhoneNumber)
    {
        _registerPhoneNumber = [[UITextField alloc]init];
        _registerPhoneNumber = [[UITextField alloc]init];
        _registerPhoneNumber.placeholder = @"请输入手机号";
        //        _phoneNumberTextField.delegate = self;
        _registerPhoneNumber.textColor = [UIColor darkGrayColor];
        _registerPhoneNumber.keyboardType = UIKeyboardTypeNumberPad;//数字键盘
        _registerPhoneNumber.clearButtonMode = UITextFieldViewModeWhileEditing;
        _registerPhoneNumber.hidden = YES;
    }
    return _registerPhoneNumber;
}
-(UITextField *)registerPassword
{
    if(!_registerPassword)
    {
        _registerPassword = [[UITextField alloc]init];
        _registerPassword.placeholder = @"请输入密码";
        _registerPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_registerPassword setSecureTextEntry:YES];
        _registerPassword.delegate = self;
        _registerPassword.returnKeyType = UIReturnKeyDone;
        _registerPassword.hidden = YES;
    }
    return _registerPassword;
}

-(UIImageView *)confirmPasswordView
{
    if(!_confirmPasswordView)
    {
        _confirmPasswordView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"password"]];
        _confirmPasswordView.userInteractionEnabled = YES;
        _confirmPasswordView.hidden = YES;
    }
    return _confirmPasswordView;
}
-(UITextField *)registerConfirmPassword
{
    if(!_registerConfirmPassword)
    {
        _registerConfirmPassword = [[UITextField alloc]init];
        _registerConfirmPassword.placeholder = @"请确认密码";
        _registerConfirmPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_registerConfirmPassword setSecureTextEntry:YES];
        _registerConfirmPassword.delegate = self;
        _registerConfirmPassword.returnKeyType = UIReturnKeyDone;
        _registerConfirmPassword.hidden = YES;
    }
    return _registerConfirmPassword;
}
-(UIButton *)registerButton
{
    if(!_registerButton)
    {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setImage:[UIImage imageNamed:@"register"] forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _registerButton.hidden = YES;
    }
    return _registerButton;
}
#pragma mark 登录点击
-(void)loginButtonClick
{
    
}

-(void)registerButtonClick
{   NSLog(@"用户输入的手机号是%@",self.registerPhoneNumber.text);
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.registerPhoneNumber.text zone:@"86" result:^(NSError * error){
        if(!error)
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"验证码已成功发送至您手机" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //            [alertController dismissViewControllerAnimated:YES completion:nil];
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertController addAction:action];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
            NSLog(@"请求失败");
        }
    }];
    RegisterVC * registerVC = [[RegisterVC alloc]init];
    registerVC.phoneNumber = self.registerPhoneNumber.text;
//    [self.navigationController pushViewController:registerVC animated:YES];
    [self presentViewController:registerVC animated:YES completion:nil];
}
#pragma mark 点击音乐按钮
-(void)musicButtonClick
{
    if(!_IS_MUSIC_ON)
    {
        _IS_MUSIC_ON = !_IS_MUSIC_ON;
        [self.view.layer addSublayer:self.fireEmitter];
        self.player.volume = 10;
        CABasicAnimation * rotateAnm = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotateAnm.toValue = [NSNumber numberWithFloat:M_PI*2];
        rotateAnm.duration = 3;
        rotateAnm.repeatCount = 1000;
        rotateAnm.cumulative = YES;
        [self.musicButton.layer addAnimation:rotateAnm forKey:@"rotationAnimation"];
//        __weak typeof(self) weakself = self;
//        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC));
//        dispatch_after(delayTime,dispatch_get_main_queue(),^{
//            [weakself MakeSecondAnimation];
//        });
        [self performSelector:@selector(MakeSecondAnimation) withObject:nil afterDelay:1.5];
    }
    else
    {
        [self.fireEmitter removeFromSuperlayer];
        self.player.volume = 0;
        _IS_MUSIC_ON = !_IS_MUSIC_ON;
        [self.musicButton.layer removeAllAnimations];//移除所有动画
    }
}
#pragma mark 第二层动画
-(void)MakeSecondAnimation
{
    [self.view.layer addSublayer:self.fireEmitter1];
//    [self performSelector:@selector(MakeThirdAnimation) withObject:nil afterDelay:1];
//    __weak typeof(self) weakself = self;
//    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC));
//    dispatch_after(delayTime,dispatch_get_main_queue(),^{
//        [weakself MakeSecondAnimation];
//    });
}
#pragma makr UITextField代理
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.passwordTextField resignFirstResponder];
    [self.registerConfirmPassword resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.phoneNumberTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.registerPhoneNumber resignFirstResponder];
    [self.registerPassword resignFirstResponder];
    [self.registerConfirmPassword resignFirstResponder];
}
-(void)logButtonClick
{
    self.logButton.selected = YES;
    self.regButton.selected = NO;
    self.logButton.userInteractionEnabled = NO;
    self.regButton.userInteractionEnabled = YES;
    
    self.phoneNumberTextField.hidden = NO;
    self.registerPhoneNumber.hidden = YES;
    self.passwordTextField.hidden = NO;
    self.registerPassword.hidden = YES;
    self.confirmPasswordView.hidden = YES;
    self.loginButton.hidden = NO;
    self.registerConfirmPassword.hidden = YES;
    self.registerButton.hidden = YES;
}
-(void)regButtonClick
{
    self.logButton.selected = NO;
    self.regButton.selected = YES;
    self.regButton.userInteractionEnabled = NO;
    self.logButton.userInteractionEnabled = YES;
    
    self.phoneNumberTextField.hidden = YES;
    self.registerPhoneNumber.hidden = NO;
    self.passwordTextField.hidden = YES;
    self.registerPassword.hidden = NO;
    self.confirmPasswordView.hidden = NO;
    self.loginButton.hidden = YES;
    self.registerConfirmPassword.hidden = NO;
    self.registerButton.hidden = NO;
}
//-(void)MakeThirdAnimation
//{
//    _fireEmitter2 = [[CAEmitterLayer alloc]init];
//    _fireEmitter2.emitterPosition = CGPointMake(317*WScale, 645*HScale);
//    //发射器大小
//    _fireEmitter2.emitterSize = CGSizeMake(0, 0);//发射区域大小
//    _fireEmitter2.renderMode = kCAEmitterLayerOldestLast;//附加模式
//    //发射单元
//    CAEmitterCell * fire = [CAEmitterCell emitterCell];
//    fire.birthRate = 0.5;
//    fire.lifetime = 3.0;
//    fire.lifetimeRange = 1.5;
//
//    fire.contents = (id)[[UIImage imageNamed:@"music_3"]CGImage];
//    [fire setName:@"fire3"];
//    fire.velocity = 25;
//    fire.velocityRange = 30;
//    fire.emissionLongitude = M_PI_4*5;
//    fire.emissionRange = M_PI_4/2;
//    fire.scaleSpeed = 0.01;
//    fire.spin = 0.01;
//    _fireEmitter2.emitterCells = [NSArray arrayWithObjects:fire, nil];
//    [self.view.layer addSublayer:self.fireEmitter2];
//}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
