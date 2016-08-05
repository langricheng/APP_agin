//
//  HCMp3Player.h
//  HealthCloud
//
//  Created by chengwen on 16/5/30.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCMp3Player : NSObject

+ (HCMp3Player *)shareInstance;

- (void)playSoundWithPath:(NSString *)path;

- (void)playMusicWithPath:(NSString *)path;

- (void)stopPlayer;
- (void)stopSound;
@end
