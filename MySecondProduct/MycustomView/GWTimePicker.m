//
//  GWTimePicker.m
//  BaseProject
//
//  Created by wanggw on 14/11/21.
//  Copyright (c) 2014年 wanggw. All rights reserved.
//

#import "GWTimePicker.h"

#define Screen_height   [[UIScreen mainScreen] bounds].size.height
#define Screen_width    [[UIScreen mainScreen] bounds].size.width

@interface GWTimePicker () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSMutableArray *pickeDatas;
@property (nonatomic, assign) NSInteger i_index;

@end

@implementation GWTimePicker
{
    UIDatePicker *timePicker;
    NSString *str_currentTime;
    NSString *oldTime;
    UIButton *btn_cancel;
    UIButton *btn_sure;
    BOOL _isSwip;
    
    SelectTimeBlock G_block;
    
    SelectTimeBlock AccurateTimeBlock;

    NSString *pickeVeiwSelectString;
    UIPickerView *timePeriodPikeView;
    NSArray *pickeOriginDatas; /** 原始数据 */
    
    NSString *currentFormatString;
}

+ (GWTimePicker *)sharedView {
    static dispatch_once_t once;
    static GWTimePicker *sharedView;
    dispatch_once(&once, ^ {
        sharedView = [[self alloc] init];
    });
    return sharedView;
}

//获取以前的时间
+ (void)showInView:(UIView *)view SelectPreviousTime:(SelectTimeBlock)block
{
    [[GWTimePicker sharedView] showInView:view SelectPreviousTime:(SelectTimeBlock)block];
}

+ (void)showInView:(UIView *)view andDateStr:(NSString *)date SelectPreviousTime:(SelectTimeBlock)block
{
    [[GWTimePicker sharedView] showInView:view SelectPreviousTime:(SelectTimeBlock)block andDataStr:date];
}

//获取以后的时间
+ (void)showInView:(UIView *)view SelectLaterTime:(SelectTimeBlock)block
{
    [[GWTimePicker sharedView] showInView:view SelectLaterTime:(SelectTimeBlock)block];
}

+ (void)showInView:(UIView *)view andDateStr:(NSString *)date SelectLaterTime:(SelectTimeBlock)block
{
     [[GWTimePicker sharedView] showInView:view SelectLaterTime:(SelectTimeBlock)block andDataStr:date];
}

+ (void)showInView:(UIView *)view andDateStr:(NSString *)date SelectLaterAccurateTime:(SelectTimeBlock)block
{
    [[GWTimePicker sharedView] showInView:view SelectLaterAccurateTime:(SelectTimeBlock)block andDataStr:date];
}

+ (void)showInViewToSelectSepeatorTime:(UIView *)view dataSource:(NSArray *)source SelectLaterAccurateTime:(SelectTimeBlock)block
{
    [[GWTimePicker sharedView] showInViewToSelectSepeatorTime:view dataSource:source SelectLaterAccurateTime:block];
}

#pragma mark - init

- (id)init
{
    self = [super init];
    if (self) {
        
        
        self.frame = CGRectMake(0, 0, Screen_width, Screen_height);
        self.backgroundColor = [UIColor clearColor];
       
        UIView *backView = [[UIView alloc]initWithFrame:self.bounds];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0.5;
        [self addSubview:backView];
        
        _isSwip = NO;
        //背景
        UIImageView *botBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, Screen_height - 325+64,Screen_width, 375/2 )];
        botBg.backgroundColor = [UIColor colorWithRed:68/255.0 green:129/255.0 blue:210/255.0 alpha:1.0];
        [self addSubview:botBg];
        
        //取消按钮
        btn_cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_cancel.frame = CGRectMake(25/2, Screen_height - 325 + 10+64 , 120/2, 55/2) ;
        [btn_cancel setTitle:@"取消" forState:UIControlStateNormal];
        btn_cancel.titleLabel.font = [UIFont systemFontOfSize:14];
        btn_cancel.showsTouchWhenHighlighted = YES;
        [btn_cancel addTarget:self action:@selector(btnAction_cancel) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn_cancel];
        
        //完成按钮
        btn_sure = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_sure.frame = CGRectMake(505/2, Screen_height - 325 + 10 +64, 120/2, 55/2) ;
        [btn_sure setTitle:@"完成" forState:UIControlStateNormal];
        btn_sure.titleLabel.font = [UIFont systemFontOfSize:14];
        btn_sure.showsTouchWhenHighlighted = YES;
        //btn_sure.enabled = NO;
        [btn_sure addTarget:self action:@selector(btnAction_sure) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn_sure];
        
        //时间选择器
        
        
    }
    return self;
}

- (void)changeDate
{
    
}

#pragma mark - time method

- (void)reConfigTimePeriodWithSeletedDate:(NSDate *)selectedDate
{
    [self.pickeDatas removeAllObjects];
    
    NSDate *currentDate = [NSDate date];
    //选择的时间变化了，这里需要动态改变可以选择的时间段 pickeDatas
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    //比较天数
    unsigned units  = NSDayCalendarUnit;
    NSDateComponents *currentComp = [cal components:units fromDate:currentDate];
    NSDateComponents *selectComp = [cal components:units fromDate:selectedDate];
    NSInteger selectedDay = [selectComp day];
    NSInteger currentDay = [currentComp day];
    
    //比较月数
    unsigned int unitFlag = NSYearCalendarUnit | NSMonthCalendarUnit;
    
    
    NSDateComponents *gap = [cal components:unitFlag fromDate:selectedDate toDate:currentDate options:0];
    int targetIndex = -1;
    if (!([gap year] > 0 || [gap month] > 0 || selectedDay > currentDay)) {
        //如果选择了今天，注意上面的判断条件是非
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HHmm"];
        NSString *cTimeString = [dateFormatter stringFromDate:currentDate];
        NSInteger cTime = cTimeString.integerValue;
        
        
        for (int i = 0; i < pickeOriginDatas.count; i++) {
            
            NSString *timeString = [NSString stringWithFormat:@"%@", pickeOriginDatas[i]];
            timeString = [timeString substringFromIndex:6];
            timeString = [timeString stringByReplacingOccurrencesOfString:@":" withString:@""];
            
            NSInteger aTime = timeString.integerValue;
            
            //计算时间差
            if ((aTime - cTime) > 300) {
                targetIndex = i;
                break;
            }
        }
        
        
        
//        for (int i = targetIndex; i < pickeOriginDatas.count; i++) {
//            [self.pickeDatas addObject:pickeOriginDatas[i]];
//        }
        
    }
    else{
        
//        self.pickeDatas = [NSMutableArray arrayWithArray:pickeOriginDatas];
        
    }
    
    self.i_index = targetIndex;
    self.pickeDatas = [NSMutableArray arrayWithArray:pickeOriginDatas];

    [timePeriodPikeView reloadAllComponents];
    
    
    if (self.i_index > 0) {
        [timePeriodPikeView selectRow:self.i_index inComponent:0 animated:YES];
    }
    else{
        [timePeriodPikeView selectRow:self.pickeDatas.count/2 inComponent:0 animated:YES];
    }
}

#pragma mark - actions

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self btnAction_cancel];
}

- (void)btnAction_cancel
{
    [self removeFromSuperview];
}

- (void)btnAction_sure
{
    if([str_currentTime stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0){
        //默认为今天的日期
        NSDate *senddate = [NSDate date];
        NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:currentFormatString];
        
        
//        if (pickeVeiwSelectString) {
//            [dateformatter setDateFormat:@"YYYY-MM-dd"];
//        }
//        else {
//            [dateformatter setDateFormat:@"YYYY-MM-dd hh:mm"];
//        }

        str_currentTime = [dateformatter stringFromDate:senddate];
    }
    
    if (AccurateTimeBlock) {
        if (pickeVeiwSelectString) {
            AccurateTimeBlock([str_currentTime stringByAppendingString:[NSString stringWithFormat:@" %@", pickeVeiwSelectString]]);
        }
        else {
            if([str_currentTime rangeOfString:@":"].location == NSNotFound || str_currentTime.length < 13){
                //默认为今天的日期
                NSDate *senddate = [NSDate date];
                NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
                [dateformatter setDateFormat:@"YYYY-MM-dd hh:mm"];
                str_currentTime = [dateformatter stringFromDate:senddate];
            }

            AccurateTimeBlock(str_currentTime);
        }

    }
    
    //返回当前时间
    if (G_block) {
        G_block(str_currentTime);
    }
    
    [self removeFromSuperview];
}

//读取日期
- (void)readDate:(id)sender
{
    UIDatePicker *datePicker = (UIDatePicker *)sender;
    
    NSDate *selected = [datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    str_currentTime = [dateFormatter stringFromDate:selected];
}

- (void)AccurateTimeRead:(id)sender
{
    UIDatePicker *datePicker = (UIDatePicker *)sender;
    
    NSDate *selectedDate = [datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    str_currentTime = [dateFormatter stringFromDate:selectedDate];
    
    [self reConfigTimePeriodWithSeletedDate:selectedDate];
}

- (void)showInView:(UIView *)view SelectPreviousTime:(SelectTimeBlock)block
{
    if (timePicker) {
        timePicker = nil;
    }
    CGRect pickerFrame = CGRectZero;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        pickerFrame = CGRectMake(0,Screen_height - 280+64, [[UIScreen mainScreen]bounds].size.width, 214);
    }
    else {
        pickerFrame = CGRectMake(0,Screen_height - 280+64,  [[UIScreen mainScreen]bounds].size.width, 0.0);
    }

    timePicker = [[UIDatePicker alloc] init];
    [timePicker setAccessibilityLanguage:@"Chinese"];
    timePicker.frame = pickerFrame;
    timePicker.datePickerMode = UIDatePickerModeDate;
    [timePicker addTarget:self action:@selector(readDate:) forControlEvents:UIControlEventValueChanged];
    
    
    timePicker.backgroundColor = [UIColor whiteColor];
    [self addSubview:timePicker];
    
    //最大日期为今天，也就是说你只能选择今天以前的日期
    timePicker.maximumDate = [NSDate date];
    [self showInView:view WithBlock:block];
}

- (void)showInView:(UIView *)view SelectPreviousTime:(SelectTimeBlock)block andDataStr:(NSString *)dateStr
{
    if (timePicker) {
        timePicker = nil;
    }
    CGRect pickerFrame = CGRectZero;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        pickerFrame = CGRectMake(0,Screen_height - 280+64,  [[UIScreen mainScreen]bounds].size.width, 214);
    }
    else {
        pickerFrame = CGRectMake(0,Screen_height - 280+64,  [[UIScreen mainScreen]bounds].size.width, 0.0);
    }

    timePicker = [[UIDatePicker alloc] init];
    [timePicker setAccessibilityLanguage:@"Chinese"];
    timePicker.frame = pickerFrame;
    timePicker.datePickerMode = UIDatePickerModeDate;
    [timePicker addTarget:self action:@selector(readDate:) forControlEvents:UIControlEventValueChanged];
    
    
    timePicker.backgroundColor = [UIColor whiteColor];
    [self addSubview:timePicker];
    
    //最大日期为今天，也就是说你只能选择今天以前的日期
    timePicker.maximumDate = [NSDate date];
    
    
    currentFormatString = @"yyyy-MM-dd";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:currentFormatString];
    
    str_currentTime = @"";
//    if ((![dateStr isEqualToString:@""]) || (dateStr != nil) || ![dateStr isBlank]) {
//        NSDate * date = [dateFormatter dateFromString:dateStr];
//        timePicker.date = date;
//        str_currentTime = dateStr;
//
//    }
//    else{
//        timePicker.date = [NSDate date];
//    }
    
    if (([dateStr isEqualToString:@""]) || (dateStr == nil) || ([str_currentTime stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0))
    {
        timePicker.date = [NSDate date];
    }
    else
    {
        NSDate * date = [dateFormatter dateFromString:dateStr];
        timePicker.date = date;
        str_currentTime = dateStr;
    }
    
//    str_currentTime = dateStr;

    [self showInView:view WithBlock:block];
}

- (void)showInView:(UIView *)view SelectLaterTime:(SelectTimeBlock)block
{
    if (timePicker) {
        timePicker = nil;
    }
    CGRect pickerFrame = CGRectZero;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        pickerFrame = CGRectMake(0,Screen_height - 280+64,  [[UIScreen mainScreen]bounds].size.width, 214);
    }
    else {
        pickerFrame = CGRectMake(0,Screen_height - 280+64,  [[UIScreen mainScreen]bounds].size.width, 0.0);
    }

    timePicker = [[UIDatePicker alloc] init];
    [timePicker setAccessibilityLanguage:@"Chinese"];
    timePicker.frame = pickerFrame;
    timePicker.datePickerMode = UIDatePickerModeDate;
    [timePicker addTarget:self action:@selector(readDate:) forControlEvents:UIControlEventValueChanged];
    
    
    timePicker.backgroundColor = [UIColor whiteColor];
    [self addSubview:timePicker];
    
    //最小日期为今天，也就是说你只能选择今天以后的日期
    timePicker.minimumDate = [NSDate date];
    
    [self showInView:view WithBlock:block];
}

- (void)showInView:(UIView *)view SelectLaterTime:(SelectTimeBlock)block andDataStr:(NSString *)dateStr
{
    if (timePicker) {
        timePicker = nil;
    }
    CGRect pickerFrame = CGRectZero;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        pickerFrame = CGRectMake(0,Screen_height - 280+64,  [[UIScreen mainScreen]bounds].size.width, 214);
    }
    else {
        pickerFrame = CGRectMake(0,Screen_height - 280+64,  [[UIScreen mainScreen]bounds].size.width, 0.0);
    }

    timePicker = [[UIDatePicker alloc] init];
    [timePicker setAccessibilityLanguage:@"Chinese"];
    timePicker.frame = pickerFrame;
    timePicker.datePickerMode = UIDatePickerModeDate;
    [timePicker addTarget:self action:@selector(readDate:) forControlEvents:UIControlEventValueChanged];
    
    
    timePicker.backgroundColor = [UIColor whiteColor];
    [self addSubview:timePicker];
    
    //最小日期为今天，也就是说你只能选择今天以后的日期
    timePicker.minimumDate = [NSDate date];
    str_currentTime = @"";
    
    
    currentFormatString = @"yyyy-MM-dd";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:currentFormatString];
    
    if ([str_currentTime stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length != 0) {
        NSDate * date = [dateFormatter dateFromString:dateStr];
        timePicker.date = date;
        str_currentTime = dateStr;
    }
    else{
        timePicker.date = [NSDate date];
    }
    
    
    [self showInView:view WithBlock:block];
}

- (void)showInView:(UIView *)view SelectLaterAccurateTime:(SelectTimeBlock)block andDataStr:(NSString *)dateStr
{
    if (timePicker) {
        timePicker = nil;
    }
    
    CGRect pickerFrame = CGRectZero;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        pickerFrame = CGRectMake(0, Screen_height - 280+64,  [[UIScreen mainScreen]bounds].size.width, 214);
    }
    else {
        pickerFrame = CGRectMake(0, Screen_height - 280+64,  [[UIScreen mainScreen]bounds].size.width, 0.0);
    }
    
    
    timePicker = [[UIDatePicker alloc] init];
    [timePicker setAccessibilityLanguage:@"Chinese"];
    timePicker.frame = pickerFrame;
    
    [timePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"]];
    
    //timePicker.minuteInterval = 30;//设置分钟的选择区间端，1就是默认，最大60
    //timePicker.datePickerMode = UIDatePickerModeDateAndTime;
    timePicker.datePickerMode = UIDatePickerModeDate;
    [timePicker addTarget:self action:@selector(AccurateTimeRead:) forControlEvents:UIControlEventValueChanged];
    timePicker.backgroundColor = [UIColor whiteColor];
    [self addSubview:timePicker];
    
    
    //最小日期为今天，也就是说你只能选择今天以后的日期
    timePicker.minimumDate = [NSDate date];
    str_currentTime = @"";
    
    currentFormatString = @"yyyy-MM-dd";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];

    
    if ([str_currentTime stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length != 0) {
        NSDate *date = [dateFormatter dateFromString:dateStr];
        timePicker.date = date;
        str_currentTime = dateStr;
    }
    else{
        timePicker.date = [NSDate date];
    }
    
    [self showInView:view WithAccurateTimeBlock:block];
}

- (void)showInView:(UIView *)view WithAccurateTimeBlock:(SelectTimeBlock)block
{
    [view addSubview:self];
    
    AccurateTimeBlock = block;
}


- (void)showInView:(UIView *)view WithBlock:(SelectTimeBlock)block
{
    [view addSubview:self];
    //[view bringSubviewToFront:self];
    
    G_block = block;
}

- (void)showInViewToSelectSepeatorTime:(UIView *)view dataSource:(NSArray *)source SelectLaterAccurateTime:(SelectTimeBlock)block
{
    if (timePicker) {
        timePicker = nil;
    }
    if (timePeriodPikeView) {
        timePeriodPikeView = nil;
    }
    
    pickeOriginDatas = source;

    CGRect pickerFrame = CGRectZero;
    CGRect pikeViewFrame = CGRectZero;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        pickerFrame = CGRectMake(0,Screen_height - 280+64,  [[UIScreen mainScreen]bounds].size.width - 80, 214);
        pikeViewFrame = CGRectMake( [[UIScreen mainScreen]bounds].size.width - 100,Screen_height - 280+64, 100, 214);
    }
    else {
        pickerFrame = CGRectMake(0,Screen_height - 280+64,  [[UIScreen mainScreen]bounds].size.width - 80, 0.0);
        pikeViewFrame = CGRectMake( [[UIScreen mainScreen]bounds].size.width - 100,Screen_height - 280+64, 100, 0.0);
    }


    timePicker = [[UIDatePicker alloc] init];
    [timePicker setAccessibilityLanguage:@"Chinese"];
    timePicker.frame = pickerFrame;
    [timePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"]];

    //timePicker.minuteInterval = 30;//设置分钟的选择区间端，1就是默认，最大60
    //    timePicker.datePickerMode = UIDatePickerModeDateAndTime;
    timePicker.datePickerMode = UIDatePickerModeDate;
    [timePicker addTarget:self action:@selector(AccurateTimeRead:) forControlEvents:UIControlEventValueChanged];
    timePicker.backgroundColor = [UIColor whiteColor];
    [self addSubview:timePicker];

    currentFormatString = @"yyyy-MM-dd";
    //最小日期为今天，也就是说你只能选择今天以后的日期
    timePicker.minimumDate = [NSDate date];
    str_currentTime = @"";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [dateFormatter setDateFormat:currentFormatString];


    timePicker.date = [NSDate date];

    timePeriodPikeView = [[UIPickerView alloc] initWithFrame:pikeViewFrame];
    timePeriodPikeView.backgroundColor = [UIColor whiteColor];
    timePeriodPikeView.delegate = self;
    [self addSubview:timePeriodPikeView];
    
    
    [self reConfigTimePeriodWithSeletedDate:timePicker.date];

    if ([timePeriodPikeView selectedRowInComponent:0] >= self.pickeDatas.count) {
        pickeVeiwSelectString = nil;
    }
    else{
        pickeVeiwSelectString = [self.pickeDatas objectAtIndex:[timePeriodPikeView selectedRowInComponent:0]];
    }
    //pickeVeiwSelectString = [self.pickeDatas safeGetIndexObj:[timePeriodPikeView selectedRowInComponent:0]];

    [view addSubview:self];
    AccurateTimeBlock = block;
}

#pragma mark - UIPickerViewDelegate UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickeDatas.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *myItemTitle = nil;
    if (view && [view isKindOfClass:[UILabel class]]) {
        if (row >= self.pickeDatas.count) {
            ((UILabel *)view).text = nil;
        }
        else{
            ((UILabel *)view).text = [self.pickeDatas objectAtIndex:row];
        }
        //((UILabel *)view).text = [self.pickeDatas safeGetIndexObj:row];
        myItemTitle = (UILabel *)view;
    }
    else {
        myItemTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frameSizeWidth, 32)];
        myItemTitle.font = [UIFont systemFontOfSize:17.0];//Font(17.0);
        myItemTitle.textColor = [UIColor blackColor];
        myItemTitle.backgroundColor = [UIColor clearColor];
        myItemTitle.textAlignment = NSTextAlignmentCenter;
        if (row >= self.pickeDatas.count) {
            myItemTitle.text = nil;
        }
        else{
            myItemTitle.text = [self.pickeDatas objectAtIndex:row];
        }
        //myItemTitle.text = [self.pickeDatas safeGetIndexObj:row];
    }
    
    if (self.i_index > 0 && row < self.i_index) {
        myItemTitle.textColor = [UIColor grayColor];//GrayColor;
    }
    else{
        myItemTitle.textColor = [UIColor blackColor];
    }
    
    return myItemTitle;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 32;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.i_index > 0 && row < self.i_index) {
        [timePeriodPikeView selectRow:self.i_index inComponent:0 animated:YES];
        return;
    }
    if (row >= self.pickeDatas.count) {
        pickeVeiwSelectString = nil;
    }
    else{
        pickeVeiwSelectString = [self.pickeDatas objectAtIndex:row];
    }
   // pickeVeiwSelectString = [self.pickeDatas safeGetIndexObj:row];
}

- (NSMutableArray *)_pickeDatas
{
    if (!_pickeDatas) {
        _pickeDatas = [NSMutableArray arrayWithCapacity:1];
    }
    
    return _pickeDatas;
}

@end
