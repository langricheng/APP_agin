//
//  NSData+JSON.m
//  lenewwifi
//
//  Created by Meng on 15/4/28.
//  Copyright (c) 2015年 com.tentinet. All rights reserved.
//

#import "NSData+JSON.h"

@implementation NSData (JSON)

- (id)JSONOObject  //执行json解析
{
    NSError *error = nil;
    id jsonData = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableContainers error:&error];
    
    if (error) {
        NSLog(@"json error:%@",error);
    }
    return jsonData;
}

- (NSString *)stringData //直接字符串话
{
    return [[NSString alloc] initWithBytes:self.bytes length:self.length encoding:NSUTF8StringEncoding];
}

@end
