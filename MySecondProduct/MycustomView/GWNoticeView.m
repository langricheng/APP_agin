//
//  GWNoticeView.m
//  GWTestProj
//
//  Created by wanggw on 15/2/4.
//  Copyright (c) 2015年 wanggw. All rights reserved.
//

#import "GWNoticeView.h"


#define default_blue_color [UIColor colorWithRed:68/255.0 green:129/255.0 blue:210/255.0 alpha:1.0]
#define RGB_B(x,y,z)    [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:1.0]
#define Font(x)   [UIFont systemFontOfSize:x]

static GWNoticeView *instance = nil;

@interface GWNoticeView ()

@property (nonatomic, strong) UILabel *noticLabel;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation GWNoticeView

@synthesize noticLabel, timer;

+ (GWNoticeView *)sharedView {
    if (instance == nil) {
        instance = [[self alloc] init];
    }
    
    return instance;
}

- (id)init
{
    if (self=[super init]) {
        self.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 88/2);
        [self addSubview:self.noticLabel];
    }
    
    return self;
}

#pragma mark -

+ (void)successNoticeInView:(UIView *)view title:(NSString *)title
{
    [[GWNoticeView sharedView] successNoticeInView:view title:title];
}

+ (void)errorNoticeInView:(UIView *)view title:(NSString *)title
{
    [[GWNoticeView sharedView] errorNoticeInView:view title:title];
}

+ (void)errorNoticeInView:(UIView *)view title:(NSString *)title top:(BOOL)isTop
{
    [[GWNoticeView sharedView]errorNoticeInView:view title:title top:isTop];
}

+ (void)errorNoticeInWindow:(UIWindow *)window title:(NSString *)title
{
    [[GWNoticeView sharedView] errorNoticeInWindow:window title:title];
}

+ (void)successNoticeInWindow:(UIWindow *)window title:(NSString *)title
{
    [[GWNoticeView sharedView] successNoticeInWindow:window title:title];
}

#pragma mark -

- (void)successNoticeInView:(UIView *)view title:(NSString *)title
{
    self.backgroundColor = default_blue_color;
    self.noticLabel.text = title;
    
    [self showInView:view];
}

- (void)successNoticeInWindow:(UIWindow *)window title:(NSString *)title
{
    self.backgroundColor = default_blue_color;
    self.noticLabel.text = title;
    [self showInWindow:window];
    
}


- (void)errorNoticeInView:(UIView *)view title:(NSString *)title
{
    self.backgroundColor = RGB_B(255, 100, 100);
    self.noticLabel.text = title;
    
    [self showInView:view];
}

- (void)errorNoticeInWindow:(UIWindow *)window title:(NSString *)title
{
    self.backgroundColor = RGB_B(255, 100, 100);
    self.noticLabel.text = title;
    [self showInWindow:window];

}

- (void)errorNoticeInView:(UIView *)view title:(NSString *)title top:(BOOL)isTop
{
    self.backgroundColor = RGB_B(255, 100, 100);
    self.noticLabel.text = title;
    if (isTop) {
        [self showInTopOfView:view];
    }
    else
    {
        [self showInView:view];
    }
}

#pragma mark - actions

- (void)showInView:(UIView *)view
{
    //CGFloat originY = view.frameMaxY - 64;
    CGFloat originY = [[UIScreen mainScreen]bounds].size.height  - 64;
    self.frameOriginY = originY;
    [view addSubview:self];
    
    [UIView animateWithDuration:0.4 animations:^{
        self.frameOriginY = originY - self.frameSizeHeight;
    } completion:^(BOOL finished) {
        
    }];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerFired) userInfo:nil repeats:NO];
}

- (void)showInWindow:(UIWindow *)window
{
    CGFloat originY = [[UIScreen mainScreen]bounds].size.height;
    self.frameOriginY = originY;
    [window addSubview:self];
    
    [UIView animateWithDuration:0.4 animations:^{
        self.frameOriginY = originY - self.frameSizeHeight;
    } completion:^(BOOL finished) {
        
    }];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerFired) userInfo:nil repeats:NO];
}

- (void)showInTopOfView:(UIView *)view
{
    //CGFloat originY = view.frameMaxY - 64;
    CGFloat originY = view.frame.origin.y - 20;
    
    self.frameOriginY = originY;

    [view addSubview:self];
    
    [UIView animateWithDuration:0.4 animations:^{
        self.frameOriginY = originY - self.frameSizeHeight;
    } completion:^(BOOL finished) {
        
    }];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerFired) userInfo:nil repeats:NO];
}

- (void)dismiss
{
    [self removeFromSuperview];
}

- (void)timerFired
{
    [timer invalidate];
    timer = nil;
    
    instance = nil;
    
    [self dismiss];
}

#pragma mark - Getters

- (UIView *)noticLabel {
    if(!noticLabel) {
        noticLabel = [[UILabel alloc] initWithFrame:self.bounds];
        noticLabel.font = Font(15.0);
        noticLabel.textColor = [UIColor whiteColor];
        noticLabel.textAlignment = NSTextAlignmentCenter;
        noticLabel.backgroundColor = [UIColor clearColor];
    }
    
    return noticLabel;
}

@end
