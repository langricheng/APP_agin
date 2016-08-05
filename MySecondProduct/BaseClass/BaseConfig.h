//
//  BaseConfig.h
//  QCCommunity
//
//  Created by chengwen on 16/3/24.
//  Copyright © 2016年 chengwen. All rights reserved.
//

#ifndef BaseConfig_h
#define BaseConfig_h


#endif /* BaseConfig_h */

//-------- 系统相关  --------
#define DelegateOfApp ((AppDelegate*)[UIApplication sharedApplication].delegate)

#define APPWidth ([[UIScreen mainScreen]bounds].size.width)
#define APPHeight ([[UIScreen mainScreen]bounds].size.height)
#define String(x)    [NSString stringWithFormat:@"%@", x == nil ? @"" : x];

// - ------------ 颜色相关  -------------

#define ClearColor      [UIColor clearColor]
#define RedColor        [UIColor redColor]
#define WhiteColor      [UIColor whiteColor]
#define BlackColor      [UIColor blackColor]
#define GreenColor      [UIColor greenColor]
#define YellowColor     [UIColor yellowColor]
#define BlueColor       [UIColor blueColor]
#define GrayColor       [UIColor grayColor]
#define LightGrayColor  [UIColor lightGrayColor]


#define COLORRGB_A(x)        [UIColor colorWithRed:x/255.0 green:x/255.0 blue:x/255.0 alpha:1.0]    //后缀ABC排序
#define COLORRGB_B(x,y,z)    [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:1.0]     //只为控制联想时
#define COLORRGB_C(x,y,z,a)  [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:a/1.0]   //出现顺序
#define COLORRGB_D(x,a)      [UIColor colorWithRed:x/255.0 green:x/255.0 blue:x/255.0 alpha:a/1.0]

#define COLORHEX_A(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(rgbValue & 0x0000FF))/255.0 alpha:alphaValue]
#define COLORHEX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(rgbValue & 0x0000FF))/255.0 alpha:1.0]


#define CUSTOM_BLUE COLORHEX(0x2892F1)
#define CUSTOM_BLACK COLORHEX(0x1E1E1E)
#define CUSTOM_GRAY COLORHEX(0x969FA9)
#define CUSTOM_SEPARATORLINE COLORHEX(0xD8D8D8)
#define CUSTOM_APPBLUE COLORHEX(0x2892F1)

#define BackgroundColor COLORRGB_A(249)

// ------------ 字体相关 --------------

#define Font(x)   [UIFont systemFontOfSize:x]        //设置系统字体
#define FontB(x)  [UIFont boldSystemFontOfSize:x]    //设置系统字体