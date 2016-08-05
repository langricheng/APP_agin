//
//  CWUIFactory.m
//  QCCommunity
//
//  Created by chengwen on 16/5/5.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import "CWUIFactory.h"

@implementation CWUIFactory

+ (UIButton *)creatButtonWithTitle:(NSString *)title customImage:(NSString *)imageName selecteImage:(NSString *)selectedImage highlightedImage:(NSString *)highlightedImage titleColor:(UIColor *)titleColor font:(UIFont *)font
{
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [customButton setTitle:title forState:UIControlStateNormal];
    [customButton setTitleColor:titleColor forState:UIControlStateNormal];
    [customButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [customButton setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    [customButton setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    customButton.titleLabel.font = font;
    
    
    return customButton;
}

+ (UILabel *)creatLabelWithText:(NSString *)text titleColor:(UIColor *)titleColor font:(UIFont *)font textAligment:(NSTextAlignment)textAligment
{
    UILabel *customLabel = [[UILabel alloc]init];
    customLabel.text = text;
    customLabel.textColor = titleColor;
    customLabel.textAlignment = textAligment;
    customLabel.font = font;
    
    return customLabel;
}

+ (UIView *)creatSpaceWithFrame:(CGRect)frame andColor:(UIColor *)color ishasLine:(BOOL)ishasLine
{
    UIView *space = [[UIView alloc]initWithFrame:frame];
    space.backgroundColor = color;
    
    if (ishasLine) {
        //加两条线
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, .5)];
        line.backgroundColor = CUSTOM_SEPARATORLINE;
        [space addSubview:line];
        
        line = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - .5, frame.size.width, .5)];
        line.backgroundColor = CUSTOM_SEPARATORLINE;
        [space addSubview:line];
    }
    
    
    return space;
}

+ (UIView *)creatSeparatLineWithOrigin:(CGPoint)origin
{
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(origin.x, origin.y, APPWidth, .5)];
    line.backgroundColor = CUSTOM_SEPARATORLINE;
    
    return line;
}
@end
