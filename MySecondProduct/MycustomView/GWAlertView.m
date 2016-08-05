//
//  GWAlertView.m
//  BYDFans
//
//  Created by wanggw on 15/1/27.
//  Copyright (c) 2015年 Tentinet. All rights reserved.
//

#import "GWAlertView.h"
#import "NSString+Extension.h"

#define AlertLineColor ([UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0])
#define AlertTitleColor ([UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0])
#define AlertMessageColor ([UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0])
#define AlertButtonColor ([UIColor colorWithRed:76/255.0 green:202/255.0 blue:159/255.0 alpha:1.0])

static GWAlertView *instance = nil;

@interface GWAlertView ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *sureBtn;

@property (nonatomic, strong) UILabel *verticalLineLabel;
@property (nonatomic, strong) UILabel *horizontalLineLabel;


@end

@implementation GWAlertView

@synthesize bgView, containerView, titleLabel, messageLabel;
@synthesize cancelBtn, sureBtn, horizontalLineLabel, verticalLineLabel;


+ (GWAlertView *)sharedView{
    
    if (instance == nil) {
        instance = [[self alloc] init];
    }
    
    return instance;
}

-(id)init{
    if (self=[super init]) {
        
        self.frame = [[UIScreen mainScreen] bounds];
        self.backgroundColor = [UIColor clearColor];
        //UIWindow的层级 总共有三种
        self.windowLevel = UIWindowLevelAlert;
        
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.bgView];
    [self addSubview:self.containerView];
    [containerView addSubview:self.titleLabel];
    [containerView addSubview:self.messageLabel];
    
    //horizontalLineLabel = [UIFactory createGlobalLineWith:CGRectMake(0, 160/2, containerView.frameSizeWidth, 1/2.0)];
    horizontalLineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 160/2, containerView.frameSizeWidth, 1/2.0)];
    horizontalLineLabel.backgroundColor = AlertLineColor;
    [containerView addSubview:horizontalLineLabel];
    
    cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame=CGRectMake(0, 160/2, 270/2, 90/2);
    cancelBtn.backgroundColor = [UIColor clearColor];
    [cancelBtn addTarget:self action:@selector(action_cancel) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:NSLocalizedString(@"cancel", @"取消") forState:UIControlStateNormal];
    [cancelBtn setTitleColor:AlertButtonColor forState:UIControlStateNormal];
    cancelBtn.autoresizingMask=UIViewAutoresizingFlexibleTopMargin;
    [containerView addSubview:cancelBtn];
    
    sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame=CGRectMake(270/2, 160/2, 270/2, 90/2);
    sureBtn.backgroundColor = [UIColor clearColor];
    [sureBtn addTarget:self action:@selector(action_sure) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitle:NSLocalizedString(@"determine", @"确定") forState:UIControlStateNormal];
    [sureBtn setTitleColor:AlertButtonColor forState:UIControlStateNormal];
    sureBtn.autoresizingMask=UIViewAutoresizingFlexibleTopMargin;
    [containerView addSubview:sureBtn];
    
    //verticalLineLabel = [UIFactory createGlobalLineWith:CGRectMake(270/2, 160/2, 1/2.0, 90/2)];
    verticalLineLabel = [[UILabel alloc]initWithFrame:CGRectMake(270/2, 160/2, 1/2.0, 90/2)];
    verticalLineLabel.backgroundColor = AlertLineColor;
    [containerView addSubview:verticalLineLabel];
}

+ (GWAlertView *)alertWithTitle:(NSString *)title message:(NSString *)message
{
    [[GWAlertView sharedView] refreshUIWithTitile:title Message:message AlertType:GWAlertSureCancel];
    
    
    return [GWAlertView sharedView];
}

+ (GWAlertView *)alertWithTitle:(NSString *)title message:(NSString *)message AlertType:(GWAlertType)alertType
{
    [[GWAlertView sharedView] refreshUIWithTitile:title Message:message AlertType:alertType];
    
    return [GWAlertView sharedView];
}

+ (GWAlertView *)alertWithTitle:(NSString *)title message:(NSString *)message SureButtonTitle:(NSString *)buttonTitle
{
    [[GWAlertView sharedView] setTitle:title];
    [[GWAlertView sharedView] setMessage:message];
    [[GWAlertView sharedView].sureBtn setTitle:buttonTitle forState:UIControlStateNormal];
    [[GWAlertView sharedView].cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    return [GWAlertView sharedView];
}

- (void)refreshUIWithTitile:(NSString *)title Message:(NSString *)message AlertType:(GWAlertType)alertType
{
    if (alertType == GWAlertSureCancel){
        
    }else if (alertType == GWAlertOnlyMessage){
        
        [[GWAlertView sharedView] cancelBtn].hidden = YES;
        verticalLineLabel.hidden = YES;
        [[GWAlertView sharedView] sureBtn].frame=CGRectMake(0, 160/2, 270, 90/2);
        
    }else{
        
        
    }
    
    [[GWAlertView sharedView] setTitle:title];
    [[GWAlertView sharedView] setMessage:message];
}

- (void)setTitle:(NSString *)title
{
    titleLabel.text = title;
}

- (void)setMessage:(NSString *)message
{

    CGSize size = [message sizeGwWithFont:[UIFont systemFontOfSize:14.0] Size:CGSizeMake(containerView.frameSizeWidth, 10000)];
    
    if (size.height > 14) {
        messageLabel.numberOfLines = 0;
#warning 不知道为什么 containerView.frameSizeWidth 变成297了，应该是270的
        messageLabel.frame = CGRectMake(10, titleLabel.frameMaxY + 10/2, 270 -20, 34);
//        messageLabel.frame = CGRectMake(10, titleLabel.frameMaxY + 10/2, size.width, size.height);
//        messageLabel.center = self.center;
    }
    else{
        messageLabel.frame = CGRectZero;
        
        
        [[GWAlertView sharedView] containerView].frameSizeHeight -= 24;
        CGFloat height = [[GWAlertView sharedView] containerView].frameSizeHeight;
        
        
        UILabel *horizontalLineLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, height - 96/2, 540/2, 1/2.0)];//[UIFactory createGlobalLineWith:CGRectMake(0, height - 96/2, 540/2, 1/2.0)];
        horizontalLineLabel.backgroundColor = AlertLineColor;
        [[[GWAlertView sharedView] containerView] addSubview:horizontalLineLbl];
        
        UILabel *verticalLineLbl = [[UILabel alloc]initWithFrame:CGRectMake(270/2, height - 96/2, 1/2.0, 100/2)];//[UIFactory createGlobalLineWith:CGRectMake(270/2, height - 96/2, 1/2.0, 100/2)];
        verticalLineLabel.backgroundColor = AlertLineColor;
        [[[GWAlertView sharedView] containerView] addSubview:verticalLineLbl];
        
        
        [[[GWAlertView sharedView] horizontalLineLabel] removeFromSuperview];
        [[[GWAlertView sharedView] verticalLineLabel] removeFromSuperview];
    }
    
    
    messageLabel.text = message;
}

#pragma mark - actions

- (void)show
{
    
    [self makeKeyAndVisible];
    //[animation showAlertAnimation];
}

- (void)dismiss
{
    [self resignKeyWindow];
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    instance = nil;
    
    //[animation dismissAlertAnimation];
}

- (void)action_cancel
{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    
    [self dismiss];
}

- (void)action_sure
{
    if (self.sureBlock) {
        self.sureBlock();
    }
    
    [self dismiss];
}

#pragma mark -- CustomizedAlertAnimationDelegate

//自定义的alert view出现动画结束后调用
- (void)showCustomizedAlertAnimationIsOverWithUIView:(UIView *)v
{
    //NSLog(@"showCustomizedAlertAnimationIsOverWithUIView");
    
}

//自定义的alert view消失动画结束后调用
- (void)dismissCustomizedAlertAnimationIsOverWithUIView:(UIView *)v
{
    //NSLog(@"dismissCustomizedAlertAnimationIsOverWithUIView");
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    instance = nil;
}

#pragma mark - Getters

- (UIView *)bgView {
    if(!bgView) {
        bgView = [[UIView alloc] initWithFrame:self.bounds];
        bgView.backgroundColor =  [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];//RGB_D(0, 0.4); //clearColor
    }
    return bgView;
}

- (UIView *)containerView {
    if(!containerView) {
        containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 540/2, 250/2)];
        containerView.center = self.center;
        containerView.backgroundColor = [UIColor whiteColor];
        containerView.layer.cornerRadius = 5.0;
        containerView.clipsToBounds = YES;
    }
    return containerView;
}

- (UILabel *)titleLabel
{
    if (!titleLabel) {
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40/2, containerView.frameSizeWidth, 32/2)];
        titleLabel.font = [UIFont boldSystemFontOfSize:16.0];//FontB(16.0);
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.textColor = AlertTitleColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return titleLabel;
}

- (UILabel *)messageLabel
{
    if (!messageLabel) {
        messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLabel.frameMaxY + 20/2, containerView.frameSizeWidth, 28/2)];
        messageLabel.font = [UIFont systemFontOfSize:14.0];//Font(14.0);
        messageLabel.backgroundColor = [UIColor whiteColor];
        messageLabel.textColor = AlertMessageColor;
        messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return messageLabel;
}

@end
