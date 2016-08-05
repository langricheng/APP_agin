//
//  NSMutableDictionary+CWHelper.m
//  HealthCloud
//
//  Created by chengwen on 16/6/3.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import "NSMutableDictionary+CWHelper.h"

@implementation NSMutableDictionary (CWHelper)

- (void)saveSetValue:(NSString *)value forKey:(NSString *)key
{
    if (value && ![value isEqualToString:@""]) {
        [self setValue:value forKey:key];
    }
}
@end
