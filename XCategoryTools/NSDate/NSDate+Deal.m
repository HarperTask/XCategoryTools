//
//  NSDate+Deal.m
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import "NSDate+Deal.h"

#define TIME_ZONE @"Asia/Beijing"

@implementation NSDate (Deal)

/** 当前时间 */
+ (id)currentTimeWithDateMode:(UIDateMode)mode {
    
    // 设置格式
    NSDateFormatter *dateFormatter = [NSDate dateFormattingMode:mode];
    
    // 设置时区
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [dateFormatter setTimeZone:timeZone];
    
    // 获取时间
    NSDate *curDate = [NSDate date];
    NSString *curTime = [dateFormatter stringFromDate:curDate];
    
    return curTime;
}


/** 当前时间的时间戳 */
+ (id)currentStampDateMode:(UIDateMode)mode {
    // 当前时间 string
    NSString *currentDate = [self currentTimeWithDateMode:mode];
    
    // 当前时间戳
    NSString *stampString = [self timeToTimeStampWith:currentDate dateModel:mode];
    
    return stampString;
}

/**
 求时间差
 
 @param startTime 开始时间
 @param endTime 结束时间
 @return 时间差
 */
+ (id)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime {
    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    // 设置格式
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDateFormatter *dateFormatter = [self dateFormattingMode:UIDateModeYYMMDDHHMMSS];
    
    NSDate *startD = [dateFormatter dateFromString:startTime];
    
    NSDate *endD = [dateFormatter dateFromString:endTime];
    
    NSTimeInterval value = [endD timeIntervalSinceDate:startD];
    
    int year = (int)value / (12 * 30 * 24 * 60 * 60);//年
    
    int month = (int)value / (30 * 24 * 60 * 60) % 12;//取余数,不够一年的月数
    
    int day = (int)value / (24 * 60 * 60) % 30;//取余数,不够一月的天数
    
    int house = (int)value / (60 * 60) % 24;//取余数,不够一天的小时数
    
    int minute = (int)value /60 % 60;//取余数,不够一小时的分钟数
    
    int second = (int)value % 60;//取余数,不够一分钟的秒数
    
    NSString *str;
    
    if (year != 0) {
        // 年
        str = [NSString stringWithFormat:@"%d年%d月%d天%d小时%d分",year,month,day,house,minute];
    }
    else if (year == 0 && month != 0) {
        // 月
        str = [NSString stringWithFormat:@"%d月%d天%d小时%d分",month,day,house,minute];
    }
    else if (year == 0 && month == 0 && day != 0) {
        // 天
        str = [NSString stringWithFormat:@"%d天%d小时%d分",day,house,minute];
    }
    else if (year == 0 && month == 0 && day==0 && house != 0) {
        // 时
        str = [NSString stringWithFormat:@"%d小时%d分",house,minute];
    }
    else if (year == 0 && month == 0 && day== 0 && house== 0 && minute!=0) {
        // 分
        str = [NSString stringWithFormat:@"%d分",minute];
    }
    else {
        // 秒
        str = [NSString stringWithFormat:@"%d秒",second];
        
    }
    
    return str;
    
}

/**
 判断是不是作天
 
 @param dateString 要判断的日期
 @return 是不是作天
 */
+ (BOOL)isYesterdayWith:(NSString *)dateString {
    int timeInt = [self timeisDate:dateString];
    if (timeInt == 1) {
        return YES;
    }
    return NO;
}

/**
 判断是不是今天
 
 @param dateString 要判断的日期
 @return 是不是今天
 */
+ (BOOL)isTodayWith:(NSString *)dateString {
    int timeInt = [self timeisDate:dateString];
    if (timeInt == 2) {
        return YES;
    }
    return NO;
}

/**
 判断是不是明天
 
 @param dateString 要判断的日期
 @return 是不是明天
 */
+ (BOOL)isTomorrowWith:(NSString *)dateString {
    int timeInt = [self timeisDate:dateString];
    if (timeInt == 3) {
        return YES;
    }
    return NO;
}

+ (int)timeisDate:(NSString *)timeStr {
    
    // 一天时间的秒数
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    
    // 设置格式
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    long strLength = [timeStr length];
    switch (strLength) {
        case 8:{
            dateFormatter = [self dateFormattingMode:UIDateModeYYMMDDs];
//            [dateFormatter setDateFormat:@"yyyyMMdd"];
        }
            break;
        case 10:{
            if ([[[timeStr substringFromIndex:4] substringToIndex:1] isEqualToString:@"-"]) {
//                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                dateFormatter = [self dateFormattingMode:UIDateModeYYMMDD];
            }
            else {
//                [dateFormatter setDateFormat:@"yyyyMMddHH"];
                dateFormatter = [self dateFormattingMode:UIDateModeYYMMDDHHs];
            }
            
        }
            break;
        case 12:{
//            [dateFormatter setDateFormat:@"yyyyMMddHHmm"];
            dateFormatter = [self dateFormattingMode:UIDateModeYYMMDDHHMMs];
        }
            break;
        case 14:{
//            [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
            dateFormatter = [self dateFormattingMode:UIDateModeYYMMDDHHMMSSs];
        }
            break;
            
        case 16:{
//            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            dateFormatter = [self dateFormattingMode:UIDateModeYYMMDDHHMM];
        }
            break;
        case 19:{
//            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            dateFormatter = [self dateFormattingMode:UIDateModeYYMMDDHHMMSS];
        }
            break;
            
        default:
            break;
    }
    
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:TIME_ZONE]];
    NSDate *dateTime = [dateFormatter dateFromString:timeStr];
    
    NSDateFormatter *dateFormatter1 = [self dateFormattingMode:UIDateModeYYMMDDHH];
    [dateFormatter1 setTimeZone:[NSTimeZone timeZoneWithName:TIME_ZONE]];
    
    // 获取昨天,今天,明天凌晨的时间(UTC时间)
    NSString *todayStr = [dateFormatter1 stringFromDate:[NSDate date]];
    NSDate *dateToday = [dateFormatter1 dateFromString:todayStr];
    NSDate *dateYesterday = [dateToday dateByAddingTimeInterval:-secondsPerDay];
    NSDate *dateTomorrow = [dateToday dateByAddingTimeInterval:secondsPerDay];
    
    
    
    // 获取昨天,今天,明天凌晨的时间的秒数
    NSTimeInterval yesterday = [dateYesterday timeIntervalSince1970];
    NSTimeInterval today = [dateToday timeIntervalSince1970];
    NSTimeInterval tomorrow = [dateTomorrow timeIntervalSince1970];
    NSTimeInterval time = [dateTime timeIntervalSince1970];
    
    
    if (time >= yesterday && time < today) {
        return 1;//昨天
    }
    else if (time >= today && time < tomorrow) {
        return 2;//今天
    }
    else if (time >= tomorrow && time < tomorrow + secondsPerDay) {
        return 3;//明天
    }
    else {
        return 4;
    }
    
}

/**
 通过时间字符串获取年、月、日
 
 @param dateString 要截取的时间字符串
 @return 年、月、日
 */
+ (id)getYearAndMonthAndDayWith:(NSString *)dateString {
    NSString *year,*month,*day;
    
    if ([dateString length]>4)  {
        year = [dateString substringToIndex:4];
    }
    if ([dateString length]>6)  {
        month = [[dateString substringFromIndex:5] substringToIndex:2];
    }
    if ([dateString length]>10)  {
        day = [[dateString substringFromIndex:8] substringToIndex:2];
    }
    
    return [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
}

/**
 通过秒数获取时、分、秒
 
 @param seconds 要截取的时间字符串
 @return 时、分、秒
 */
+ (id)getHouseMinuteSecondWith:(NSTimeInterval)seconds {
    

    int house = (int)seconds / (60 * 60);//取余数,不够一天的小时数
    
    int minute = (int)seconds /60 % 60;//取余数,不够一小时的分钟数
    
    int second = (int)seconds % 60;//取余数,不够一分钟的秒数
    
    NSString *str;
    
   
    // 时
    if (house != 0) {
        
        str = [NSString stringWithFormat:@"%02d:%02d:%02d",house,minute,second];
    }
    // 分
    else if (house== 0 && minute!=0) {
        
        str = [NSString stringWithFormat:@"%02d:%02d",minute,second];
    }
    // 秒
    else {
    
        str = [NSString stringWithFormat:@"00:%02d",second];
        
    }
    
    return str;
}

/**
 通过 NSDate 计算年龄
 
 @param date 要判断的时间
 @return 年龄
 */
+ (id)getAgeWithDate:(NSDate *)date {
    //获得当前系统时间
    NSDate *currentDate = [NSDate date];
   
    //获得当前系统时间与出生日期之间的时间间隔
    NSTimeInterval time = [currentDate timeIntervalSinceDate:date];
   
    //时间间隔以秒作为单位,求年的话除以60*60*24*356
    int age = ((int)time)/(3600*24*365);
    
    NSString *ageString = [NSString stringWithFormat:@"%d",age];
    
    return ageString;
}

/**
 通过 dateString 计算年龄
 
 @param dateString 要判断的时间字符串
 @param dateModel 要判断的时间字符串格式
 @return 通过 dateString 计算年龄
 */
+ (id)getAgeWithDateString:(NSString *)dateString dateModel:(UIDateMode)dateModel {

    NSDate *date = [self stringIntoDate:dateString UIDateMode:dateModel];
    
    NSString *ageString = [self getAgeWithDate:date];
    
    
    return ageString;
}

/**
 将时间转换成时间戳(1970年01月01日00时00分00秒(北京时间1970年01月01日08时00分00秒)起至现在的总秒数。)
 
 @param dateString 要判断的时间字符串
 @param dateModel 要判断的时间字符串格式
 @return 时间戳
 */
+ (id)timeToTimeStampWith:(NSString *)dateString dateModel:(UIDateMode)dateModel {
    
    // 设置格式
    NSDateFormatter *dateFormatter = [NSDate dateFormattingMode:dateModel];
    
    /* 设置时区 */
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [dateFormatter setTimeZone:timeZone];
    
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    NSString *timeStamp = [NSString stringWithFormat:@"%ld",(long)[date timeIntervalSince1970]];
    
    return timeStamp;
    
}

/**
 将时间戳转换成时间
 
 @param timeStamp 要转换的时间戳
 @return 时间
 */
+ (id)timeStampToTime:(long)timeStamp {
    
    // 设置格式
    NSDateFormatter *dateFormatter = [NSDate dateFormattingMode:UIDateModeYYMMDDHHMMSS];
    
    /* 设置时区 */
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [dateFormatter setTimeZone:timeZone];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    
    NSString *timeString = [dateFormatter stringFromDate:date];
    // timeString = [dateString substringToIndex:20];
    
    return  timeString;
    
}

/**
 将时间转换成时间字符串
 
 @param date 要转换的时间
 @param mode 要转换的时间字符串格式
 @return 时间字符串
 */
+ (NSString *)dateIntoString:(NSDate *)date UIDateMode:(UIDateMode)mode {
    
    // 设置格式
    NSDateFormatter *dateFormatter = [NSDate dateFormattingMode:mode];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
    
}

/**
 将时间字符串转换成时间
 
 @param dateString 要转换的时间字符串
 @param mode 要转换的时间格式
 @return 时间
 */
+ (NSDate *)stringIntoDate:(NSString *)dateString UIDateMode:(UIDateMode)mode  {
    
    // 设置格式
    NSDateFormatter *dateFormatter = [NSDate dateFormattingMode:mode];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    return destDate;
    
}

//  时间格式化
+ (NSDateFormatter *)dateFormattingMode:(UIDateMode)mode {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    switch (mode) {
        case UIDateModeYY:
            [dateFormatter setDateFormat:@"yyyy"];
            break;
        case UIDateModeMMDD:
            [dateFormatter setDateFormat:@"MM-DD"];
            break;
            
        case UIDateModeHHMM:
            [dateFormatter setDateFormat:@"HH:mm"];
            break;
            
        case UIDateModeHHMMSS:
            [dateFormatter setDateFormat:@"HH:mm:ss"];
            break;
            
        case UIDateModeYYMMDD:
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            break;
            
        case UIDateModeYYMMDDs:
            [dateFormatter setDateFormat:@"yyyyMMdd"];
            break;
            
        case UIDateModeYYMMDDHH:
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH"];
            break;
            
        case UIDateModeYYMMDDHHs:
            [dateFormatter setDateFormat:@"HH:mm"];
            break;
            
        case UIDateModeYYMMDDHHMM:
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
            
        case UIDateModeYYMMDDHHMMs:
            [dateFormatter setDateFormat:@"yyyyMMddHHmm"];
            break;
            
        case UIDateModeYYMMDDHHMMSS:
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            break;
            
        case UIDateModeYYMMDDHHMMSSs:
            [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
            break;
        default:
            break;
    }
    
    
    return dateFormatter;
}


@end
