//
//  MediaCtroller.m
//  MySecondProduct
//
//  Created by chengwen on 16/2/23.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import "MediaCtroller.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SessionHandler.h"
#define Vedio @"http://221.228.249.82/youku/697A5CA0CEB3582FB91C4E3A88/03002001004E644FA2997704E9D2A7BA1E7B9D-6CAB-79A9-E635-3B92A92B3500.mp4"

#define Picture @"http://xqproduct.xiangqu.com/FrQbHmZzI-MGDQfQGQxrggRe8TUa?imageView2/2/w/300/q/90/format/jpg/@w/$w$@/@h/$h$@/700x700/"

@interface MediaCtroller ()

@property (nonatomic, strong) AVPlayerViewController *avController;
@property (nonatomic, strong) NSData *vedioData;

@property (nonatomic, strong) UIProgressView *progress;
@end

@implementation MediaCtroller
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 64 - 44 - 50 - 50, 320, 44)];
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];
    
    [self initVedioUI];
    [self downLoad];
    
    [self initProgress];
}

#pragma mark - init UI

- (void)initVedioUI
{
    self.avController = [[AVPlayerViewController alloc]init];
    NSString *file = [[NSBundle mainBundle]pathForResource:@"123" ofType:@"m4v"];
    
    AVPlayer *player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:file]];
    
    self.avController.player = player;
    
    
    [self presentViewController:self.avController animated:YES completion:nil];
    
    
}


#pragma  mark - initProgress
- (void)initProgress
{
    self.progress = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 60, 100, 20)];
    self.progress.progressTintColor = [UIColor redColor];
    //[self.progress setProgress:.5 animated:YES];
    self.progress.progressViewStyle = UIProgressViewStyleDefault;
    [self.view addSubview:self.progress];
    
    
}
#pragma mark - configData

- (void)downLoad
{
    

   [SessionHandler getRequestWithUrl:Picture params:nil andSuccess:^(id result) {
        self.vedioData = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
       
       
   } andFailurre:^(id error) {
       
   }];
    
 
   // NSString *path = [Picture stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet whitespaceCharacterSet]];
//    
//    [mgr GET:Picture parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        NSLog(@"%f",downloadProgress.fractionCompleted);
//        [self.progress setProgress:downloadProgress.fractionCompleted animated:YES];
//        
//        
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        self.vedioData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        
//        
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//    }];
//    
    
}

#pragma mark - action
- (void)startVedio
{
    
}
@end
