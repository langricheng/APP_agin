//
//  NSString+Extensin.m
//  tentinet_firstTask
//
//  Created by chengwen on 15/12/9.
//  Copyright © 2015年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)


-(BOOL)isBlank
{
    if (!self) {
        return YES;
    }
    
    if([[self stringByStrippingWhitespace] length] == 0)
    {
        return YES;
    }
    
    return NO;
   
}

-(NSString *)stringByStrippingWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (CGSize)sizeGwWithFont:(UIFont *)font Size:(CGSize)size
{
//----可以作为 nsstring 的扩展类：参数：字符串长度，字体大小，固定的宽度或长度 | 返回值：size或者直接返回高度或者长度


//----注意：ios7情况下宽度计算貌似有点问题
CGSize stringSize;
//    CGRect stringRect;
CGSize constraintSize = size;//求长度就固定高度，就高度就固定长度
//#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
CGRect stringRect = [self boundingRectWithSize:constraintSize options:(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName: font} context:NULL];

stringRect.size.width = stringRect.size.width + 1;
stringSize = stringRect.size;
//#else
//    stringSize = [self sizeWithFont:font constrainedToSize:constraintSize];
//#endif



if (stringSize.height == 0) {
    stringSize = stringRect.size;
}
//----



//    //现在不适配ios6啦！！！！！！！！！
//    //----注意：ios7情况下宽度计算貌似有点问题
//    CGSize stringSize;
//    CGSize constraintSize = size;//求长度就固定高度，就高度就固定长度
//    CGRect stringRect = [self boundingRectWithSize:constraintSize options:(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName: font} context:NULL];
//
//    stringRect.size.width = stringRect.size.width + 1;
//
//
//    if (stringSize.height == 0) {
//        stringSize = stringRect.size;
//    }
//    //----

return stringSize;
}

- (BOOL)checkNameInput
{
    NSString *nameStr = @"^[\u4e00-\u9fa5A-Za-z]{2,10}$";
    NSPredicate *regextName = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nameStr];
    return [regextName evaluateWithObject:self];
}

- (BOOL)checkPasswordInput
{
    NSString *passwordStr = @"^[a-zA-Z0-9_]{6,16}$";
    NSPredicate *regextNumber = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passwordStr];
    return [regextNumber evaluateWithObject:self];
}


-(BOOL)checkPhoneNumInput{
    
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    BOOL res1 = [regextestmobile evaluateWithObject:self];
    BOOL res2 = [regextestcm evaluateWithObject:self];
    BOOL res3 = [regextestcu evaluateWithObject:self];
    BOOL res4 = [regextestct evaluateWithObject:self];
    
    if (res1 || res2 || res3 || res4 )
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

- (BOOL)checkQQnumberInput
{
    NSString *qqNum = @"^[1-9](\\d){4,9}$";
    NSPredicate *regextestQQ = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",qqNum];
    return [regextestQQ evaluateWithObject:self];
    
}

- (BOOL)checkNumberInput
{
    NSString *numberStr = @"^[0-9]*$";
    NSPredicate *regextNumber = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numberStr];
    return [regextNumber evaluateWithObject:self];
}

- (BOOL)checkIsNumOrApha
{
    NSString *qqNum = @"^[A-Za-z0-9]+$";
    NSPredicate *regextestQQ = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",qqNum];
    return [regextestQQ evaluateWithObject:self];
}

- (BOOL)checkIDCard
{
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [identityCardPredicate evaluateWithObject:self];
    
    //    NSString *IDCard = @"^[a-zA-Z0-9]+$";
    //    NSPredicate *regextName = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",IDCard];
    //    return [regextName evaluateWithObject:self];
}

- (BOOL)checkRealNameInput
{
    NSString *usernameStr = @"^[a-zA-Z\u4e00-\u9fa5]+$";
    //    NSString *usernameStr = @"^[a-zA-Z0-9?_\u4e00-\u9fa5]+$"; //中间可以有或没有_
    // @"^[\u4e00-\u9fa5]{2,10}$|^[\u4e00-\u9fa5A-Za-z0-9]{4,10}$|^[A-Za-z0-9]{4,20}$";
    // @"^[\u4e00-\u9fa5]{2,10}$|^[A-Za-z0-9]{4,20}$";
    //  ^[0-9A-Za-z]  a-zA-Z0-9
    
    //计算字符，中英混用
    NSInteger count = [self convertToInt];
    NSLog(@"_______%@________%ld_______", self,(long)count);
    
    if (count<4 || count >20) {
        return NO;
    }
    NSPredicate *regextNumber = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",usernameStr];
    return [regextNumber evaluateWithObject:self];
}

-  (NSInteger)convertToInt
//:(NSString*)strtemp
{
    
    NSInteger strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
    //    return (strlength+1)/2;
    
}


- (BOOL)checkRealCarNum
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:self];
}

- (BOOL)stringContainsEmoji{
    
    __block BOOL returnValue =NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring,NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        
        const unichar hs = [substring characterAtIndex:0];
        
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    returnValue =YES;
                }
            }
            
        }else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
                returnValue =YES;
            }
            
        }else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff) {
                returnValue =YES;
                
            }else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue =YES;
                
            }else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue =YES;
                
            }else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue =YES;
                
            }else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                returnValue =YES;
            }
        }
        
    }];
    return returnValue;
}

- (BOOL)checkSpecialSymbols
{
    //提示 标签不能输入特殊字符
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (![emailTest evaluateWithObject:self]) {
        return YES;
    }
    return NO;
}


-(NSString *)filterHTML
{
    NSScanner * scanner = [NSScanner scannerWithString:self];
    NSString * text = nil;
    NSString * wantStr;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        wantStr = [self stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    
    return wantStr;
}
@end
