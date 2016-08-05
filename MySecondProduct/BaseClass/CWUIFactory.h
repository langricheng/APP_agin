//
//  CWUIFactory.h
//  QCCommunity
//
//  Created by chengwen on 16/5/5.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CWUIFactory : NSObject

/**
 *  创建一个普通的button
 *
 *  @param title            <#title description#>
 *  @param imageName        <#imageName description#>
 *  @param selectedImage    <#selectedImage description#>
 *  @param highlightedImage <#highlightedImage description#>
 *  @param titleColor       <#titleColor description#>
 *  @param font             <#font description#>
 *
 *  @return <#return value description#>
 */
+ (UIButton *)creatButtonWithTitle:(NSString *)title customImage:(NSString *)imageName selecteImage:(NSString *)selectedImage highlightedImage:(NSString *)highlightedImage titleColor:(UIColor *)titleColor font:(UIFont *)font;

/**
 *  创建一个普通的label
 *
 *  @param text         <#text description#>
 *  @param titleColor   <#titleColor description#>
 *  @param font         <#font description#>
 *  @param textAligment <#textAligment description#>
 *
 *  @return <#return value description#>
 */
+ (UILabel *)creatLabelWithText:(NSString *)text titleColor:(UIColor *)titleColor font:(UIFont *)font textAligment:(NSTextAlignment)textAligment;

/**
 *  创建一个空白的间隔
 *
 *  @param frame     <#frame description#>
 *  @param color     <#color description#>
 *  @param ishasLine <#ishasLine description#>
 *
 *  @return <#return value description#>
 */
+ (UIView *)creatSpaceWithFrame:(CGRect)frame andColor:(UIColor *)color ishasLine:(BOOL)ishasLine;

/**
 *  创建一条分隔线
 *
 */
+ (UIView *)creatSeparatLineWithOrigin:(CGPoint)origin;

@end
