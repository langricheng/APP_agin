//
//  CWAdLodingView.m
//  HealthCloud
//
//  Created by chengwen on 16/7/1.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import "CWAdLodingView.h"
#import "CWUIFactory.h"

#define cwAdLoading_main_width  [[UIScreen mainScreen]bounds].size.width
#define cwAdLoading_main_height  [[UIScreen mainScreen]bounds].size.height
#define bottom_height  0

@interface CWAdLodingView ()

@property (nonatomic, strong) UIButton *btn_close;
@property (nonatomic, strong) UIImageView *img_content;
@property (nonatomic, strong) UIImageView *img_bottom;
@property (nonatomic, strong) UIWebView *web_content;

@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *contentUrl;

@property (nonatomic, copy) CWAdLoadingBlock block_close;
@property (nonatomic, copy) CWAdLoadingBlock block_tapClick;

@end


@implementation CWAdLodingView



+ (CWAdLodingView *)shareInstance
{
    static CWAdLodingView *adLoadingView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        adLoadingView = [[CWAdLodingView alloc]init];
        
    });
    
    
    return adLoadingView;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self initSubViews];
         
    }
    
    return self;
}



- (void)initSubViews
{
    self.frame = CGRectMake(0, 0, cwAdLoading_main_width, cwAdLoading_main_height);
    
    self.img_content = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cwAdLoading_main_width, cwAdLoading_main_height)];
    self.img_content.backgroundColor = [UIColor blueColor];
    [self addSubview:self.img_content];
    
    self.img_bottom  = [[UIImageView alloc]initWithFrame:CGRectMake(0, cwAdLoading_main_height - bottom_height, cwAdLoading_main_width, bottom_height)];
    self.img_bottom.backgroundColor = [UIColor redColor];
    [self addSubview:self.img_bottom];
    
    
    self.web_content = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, cwAdLoading_main_width, cwAdLoading_main_height)];
    self.web_content.hidden = YES;
    [self addSubview:self.web_content];
    
    
    self.btn_close = [CWUIFactory creatButtonWithTitle:@"关闭" customImage:@"" selecteImage:nil highlightedImage:nil titleColor:CUSTOM_BLACK font:Font(16)];
    self.btn_close.hidden = YES;
    self.btn_close.frame = CGRectMake(APPWidth - 60 - 10, 20, 60, 20);
    [self.btn_close addTarget:self action:@selector(action_close:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btn_close];
    
    //加一个可以点击的手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(action_tap:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tap];
    
}

#pragma mark - 公共的方法
+ (void)showWithImageUrl:(NSString *)imageUrl andContenUrl:(NSString *)contentUrl andCloseBlock:(CWAdLoadingBlock)close andTapClickBlock:(CWAdLoadingBlock)tapClick
{
    CWAdLodingView *adView = [CWAdLodingView shareInstance];
    adView.imageUrl = imageUrl;
    adView.contentUrl = contentUrl;
    
    //[adView.img_content sd_setImageWithURL:[NSURL URLWithString:adView.imageUrl] placeholderImage:[UIImage imageNamed:@"Launch_ad"]];
    
    
    
    UIWindow *keyWindow = [[UIApplication sharedApplication].keyWindow.subviews firstObject];
    
    [keyWindow addSubview:adView];
    
    if (close) {
        adView.block_close = close;
    }
    
    if (tapClick) {
        adView.block_tapClick = tapClick;
    }
    
    
    
}

+ (void)dismiss
{
     CWAdLodingView *adView = [CWAdLodingView shareInstance];
    
    [adView removeFromSuperview];
}


#pragma mark - 私有的方法

+ (void)showWebRequest
{
    
    CWAdLodingView *adView = [CWAdLodingView shareInstance];
    adView.web_content.hidden = NO;
    
    NSURL *url = [[NSURL alloc]initWithString:adView.contentUrl];
    
    [adView.web_content loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)action_close:(UIButton *)sender
{
   
    self.web_content.hidden = YES;
    
    [self removeFromSuperview];
    
    self.block_close();
}

- (void)action_tap:(UITapGestureRecognizer *)sender
{
    if (!self.contentUrl) {
        return;
    }
    self.web_content.hidden = NO;
    self.btn_close.hidden = NO;
    
    NSURL *url = [[NSURL alloc]initWithString:self.contentUrl];
    
    [self.web_content loadRequest:[NSURLRequest requestWithURL:url]];
    
    self.block_tapClick();
}

@end
