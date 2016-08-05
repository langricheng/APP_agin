//
//  BaseModel.m
//  Ce_06
//
//  Created by chengwen on 15/12/29.
//  Copyright © 2015年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import "BaseModel.h"
#import <objc/runtime.h>

@implementation BaseModel


//从字典给属性赋值
- (void)setObjectAndKeysWithDict:(NSDictionary *)dict
{
    for(NSString *key in dict.allKeys)
    {
        char cc = [key characterAtIndex:0];
        cc = cc + 'A' - 'a'; //第一个字母大写
        NSString *selString = [NSString stringWithFormat:@"set%c%@:",cc,[key substringFromIndex:1]];
        SEL selector = sel_registerName(selString.UTF8String);
        if([self respondsToSelector:selector])
        {
            id obj = [dict valueForKey:key];
            if ([obj isKindOfClass:[NSDictionary class]] || [obj isKindOfClass:[NSArray class]]) {
                
                NSLog(@"温馨提示 -------> %@  这个模型里面有复合对象,请自行解析", [self class]);
                
                [self setValue:obj forKey:key];
            }
            else {
                [self setValue:[NSString stringWithFormat:@"%@", obj] forKey:key];
            }
        }
        else {
            NSLog(@"温馨提示 -------> %@  class 中没有 %@ 字段", [self class], key);
        }
    }
}

- (NSDictionary *)properties_aps
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    
    free(properties);
    
    return props;
}

- (NSString *)description
{
    NSString *printString = [NSString stringWithFormat:@"%@%@", [super description], [[self properties_aps] description]];
    return printString;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    return self;
}

@end
