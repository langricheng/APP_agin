//
//  HCMp3Player.m
//  HealthCloud
//
//  Created by chengwen on 16/5/30.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import "HCMp3Player.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface HCMp3Player ()

@property (nonatomic, assign) CFURLRef  soundFileURLRef;
@property (nonatomic, strong) AVAudioPlayer *player;

@end


static SystemSoundID soundID;

@implementation HCMp3Player

+ (HCMp3Player *)shareInstance
{
    static HCMp3Player *hcMP3player ;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        hcMP3player = [[HCMp3Player alloc]init];
    });
    return hcMP3player;
    
}

- (void)playMusicWithPath:(NSString *)path
{
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"星月神话" ofType:@"mp3"]] error:nil];//使用本地URL创建
    //1、音量
    self.player.volume =0.8;//0.0-1.0之间
    //2、循环次数
    self.player.numberOfLoops = 1;//默认只播放一次
//   // 3、播放位置
//    self.player.currentTime =15.0;//可以指定从任意位置开始播放
//    //4、声道数
//    NSUInteger channels = self.player.numberOfChannels;//只读属性
//    //5、持续时间
//    NSTimeInterval duration = self.player.duration;//获取持续时间
//    //6、仪表计数
//    self.player.meteringEnabled =YES;//开启仪表计数功能
//    [self.player updateMeters];//更新仪表计数
    [self.player prepareToPlay];
    [self.player play];
}


-(void)playSoundWithPath:(NSString *)path

{
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"shake_sound_male" ofType:@"wav"];
    
    
    self.soundFileURLRef = (__bridge CFURLRef)[NSURL fileURLWithPath:path];
    
    if (path) {
        //注册声音到系统
        AudioServicesCreateSystemSoundID(self.soundFileURLRef,&soundID);
        AudioServicesPlaySystemSound(soundID);
        
        
         AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);   //让手机震动
       
    }
    
}

- (void)stopPlayer
{
    [self.player stop];
}

- (void)stopSound
{
    
}

@end
