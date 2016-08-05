//
//  NSString+Extensin.h
//  tentinet_firstTask
//
//  Created by chengwen on 15/12/9.
//  Copyright © 2015年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)


- (BOOL)isBlank;
/** 获取字符串的size: 求长度就固定高度，就高度就固定长度 */
- (CGSize)sizeGwWithFont:(UIFont *)font Size:(CGSize)size;

/** 检查名字  */
- (BOOL)checkNameInput;

/** 检查密码 */
- (BOOL)checkPasswordInput;

/** 检查电话号码   */
-(BOOL)checkPhoneNumInput;

/** 检查qq号  */
- (BOOL)checkQQnumberInput;

/** 验证是否全数字 */
- (BOOL)checkNumberInput;

/** 匹配是否是只包含数字和字母 */
- (BOOL)checkIsNumOrApha;

/** 检查身份证号码 */
- (BOOL)checkIDCard;

/** 检查真实姓名，没数字和符号 */
- (BOOL)checkRealNameInput;

/** 检查车牌号 */
- (BOOL)checkRealCarNum;

/** 检查是否包括emoji表情 */
- (BOOL)stringContainsEmoji;

/** 判断特殊字符 */
- (BOOL)checkSpecialSymbols;

/** 去掉字符串中的html标签 */
-(NSString *)filterHTML;


@end
