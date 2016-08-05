//
//  GWProgressHUD.m
//  GWTestProj
//
//  Created by wanggw on 15/1/9.
//  Copyright (c) 2015年 wanggw. All rights reserved.
//

#import "GWProgressHUD.h"

@interface GWProgressHUD ()
{
    double angle; //double
}
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *containerBGV;
@property (nonatomic, strong) UIImageView *progressImageView;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *progressLabel;
@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) UIButton *stopButton;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation GWProgressHUD

@synthesize bgView, containerView, containerBGV, progressImageView, logoImageView, progressLabel, lineLabel, stopButton;
@synthesize timer;

- (id)init {
    if ((self = [super init])) {
        
        self.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height);
        
        [self addSubview:self.bgView];
        [self addSubview:self.containerView];
        [self.containerView addSubview:self.containerBGV];
        [self.containerView addSubview:self.progressImageView];
        [self.containerView addSubview:self.logoImageView];
        [self.containerView addSubview:self.progressLabel];
        [self.containerView addSubview:self.lineLabel];
        [self.containerView addSubview:self.stopButton];
    }
    
    return self;
}

//wanggw 实例化一个单例，dispatch_once_t确保单例在多线程下是安全的
+ (GWProgressHUD *)sharedView {
    static dispatch_once_t once;
    static GWProgressHUD *progressHUD;
    dispatch_once(&once, ^ {
        progressHUD = [[self alloc] init];
    });
    return progressHUD;
}

+ (void)showInView:(UIView *)uiview
{
    [[GWProgressHUD sharedView] showInView:uiview];
}

+ (void)showInView:(UIView *)uiview tipString:(NSString *)tipString
{
    GWProgressHUD *HUD = [GWProgressHUD sharedView];
    HUD.progressLabel.text = tipString;
    [HUD showInView:uiview];
}

+ (void)dismiss
{
    [[GWProgressHUD sharedView] dismiss];
}

+ (BOOL)isVisible
{
    return ([self sharedView].alpha == 1);
}

- (void)showInView:(UIView *)uiview
{
    [[GWProgressHUD sharedView] startAnimate];
    
    self.alpha = 1;
    
    [uiview.window addSubview:self];
}

- (void)startAnimate
{
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
//    [UIView setAnimationDuration:1.0f];
//    [UIView setAnimationRepeatCount:1000000];
//    self.progressImageView.layer.anchorPoint = CGPointMake(0.5,0.5);
//    self.progressImageView.transform = CGAffineTransformMakeRotation([self radians:-180]);
//    [UIView commitAnimations];
    
    angle = 0;
    if(!timer){
        timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(transformAction) userInfo:nil repeats:YES];
    }
}

- (void)dismiss
{
    [timer invalidate];//不写这个会出问题，会加速转动，暂时还不清楚什么原因
    timer = nil;
    
    self.alpha = 0;
    
    [self removeFromSuperview];
}

-(void)transformAction {
    //angle = angle + 0.01;//angle角度 double angle;
    angle = angle + 0.05;
    if (angle > 6.28) { //大于 M_PI*2(360度) 角度再次从0开始
        angle = 0;
    }

    CGAffineTransform transform = CGAffineTransformMakeRotation(angle);
    self.progressImageView.transform = transform;
}

- (void)stopRequest
{
   
    
    [self dismiss];
}

#pragma mark - Getters

-(double)radians:(double)degrees
{
    return degrees * M_PI/360;
}

- (UIView *)bgView {
    if(!bgView) {
        bgView = [[UIView alloc] initWithFrame:self.bounds];
        bgView.userInteractionEnabled = NO;//背景不可以点击
        bgView.backgroundColor = [UIColor clearColor]; //RedColor
    }
    return bgView;
}

- (UIView *)containerView {
    if(!containerView) {
        containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 376/2, 112/2)];
        containerView.center = self.center;
        containerView.backgroundColor = [UIColor clearColor];
    }
    return containerView;
}

- (UIImageView *)containerBGV {
    if(!containerBGV) {
        UIEdgeInsets insets = UIEdgeInsetsMake(10, 10, 10, 10);
        UIImage *bgImage=[[UIImage imageNamed:@"icon_progress_bg_imageView"] resizableImageWithCapInsets:insets];
        
        containerBGV = [[UIImageView alloc] initWithFrame:self.containerView.bounds];
        containerBGV.backgroundColor = [UIColor clearColor];
        containerBGV.image = bgImage;
    }
    return containerBGV;
}

- (UIImageView *)progressImageView {
    if(!progressImageView) {
        progressImageView = [[UIImageView alloc] initWithFrame:CGRectMake(28/2, 24/2, 64/2, 64/2)];
        progressImageView.backgroundColor = [UIColor clearColor];
        progressImageView.image = [UIImage imageNamed:@"icon_progress_loading"];
    }
    return progressImageView;
}

- (UIImageView *)logoImageView {
    if(!logoImageView) {
        logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 33/1.8, 11/1.8)];// /2  /2
        logoImageView.center = progressImageView.center;
        logoImageView.backgroundColor = [UIColor clearColor];
        logoImageView.image = [UIImage imageNamed:@"icon_progress_logo_byd"];
    }
    return logoImageView;
}

- (UILabel *)progressLabel {
    if(!progressLabel) {
        progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(progressImageView.frameMaxX + 30/2, 0, 150, 112/2)];
        progressLabel.backgroundColor = [UIColor clearColor];
        progressLabel.font = [UIFont systemFontOfSize:28.0/2];
        progressLabel.text = @"正在加载";
        progressLabel.textColor = [UIColor whiteColor];
    }
    return progressLabel;
}

- (UILabel *)lineLabel {
    if(!lineLabel) {
        lineLabel = [[UILabel alloc] initWithFrame:CGRectMake((376-100)/2, 0, 1, 112/2)];
        lineLabel.backgroundColor = [UIColor whiteColor];
    }
    return lineLabel;
}

- (UIButton *)stopButton {
    if(!stopButton) {
        UIEdgeInsets imageInsets = UIEdgeInsetsMake(22, 19, 22, 19);//上，左，下，右

        stopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        stopButton.frame = CGRectMake((376-100)/2, 0, 100/2, 112/2);
        [stopButton setImage:[UIImage imageNamed:@"icon_progress_stop"] forState:UIControlStateNormal];
        stopButton.imageEdgeInsets = imageInsets;
        [stopButton addTarget:self action:@selector(stopRequest) forControlEvents:UIControlEventTouchUpInside];
    }
    return stopButton;
}

@end
