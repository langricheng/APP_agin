//
//  CWBluetoothUtil.h
//  MySecondProduct
//
//  Created by chengwen on 16/6/17.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CWBluetoothUtil : NSObject

/** 将16进制字符串转成data,一般用于蓝牙的写值  如发送指令:"1B9901"*/
- (NSData *)hexToBytes:(NSString *)str;

/** 十六进制字符串转换成十进制字符串 */
+ (NSString *)stringFromHexString:(NSString *)hexString;
@end
