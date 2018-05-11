//
//  NSDate+Deal.h
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger, UIDateMode) {
    /** yyyy 4 */
    UIDateModeYY,
    /** MM-DD 5 */
    UIDateModeMMDD,
    /** HH:mm 5 */
    UIDateModeHHMM,
    /** HH:mm:ss 8 */
    UIDateModeHHMMSS,
    /** yyyy-MM-dd 10 */
    UIDateModeYYMMDD,
    /** yyyyMMdd 8 */
    UIDateModeYYMMDDs,
    /** yyyy-MM-dd HH 13 */
    UIDateModeYYMMDDHH,
    /** yyyyMMddHH 10 */
    UIDateModeYYMMDDHHs,
    /** yyyy-MM-dd HH:mm 16 */
    UIDateModeYYMMDDHHMM,
    /** yyyyMMddHHmm 12 */
    UIDateModeYYMMDDHHMMs,
    /** yyyy-MM-dd HH:mm:ss 19 */
    UIDateModeYYMMDDHHMMSS,
    /** yyyyMMddHHmmss 14 */
    UIDateModeYYMMDDHHMMSSs,
    
    
};

@interface NSDate (Deal)

/** 当前时间 */
+ (id)currentTimeWithDateMode:(UIDateMode)mode;

/** 当前时间的时间戳 */
+ (id)currentStampDateMode:(UIDateMode)mode;

///** 给字符串添加时间戳 */
//+ (id)getStampString:(NSString *)string dateMode:(UIDateMode)mode;


/**
 求时间差

 @param startTime 开始时间
 @param endTime 结束时间
 @return 时间差
 */
+ (id)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;


/**
 判断是不是作天

 @param dateString 要判断的日期
 @return 是不是作天
 */
+ (BOOL)isYesterdayWith:(NSString *)dateString;


/**
 判断是不是今天

 @param dateString 要判断的日期
 @return 是不是今天
 */
+ (BOOL)isTodayWith:(NSString *)dateString;


/**
 判断是不是明天

 @param dateString 要判断的日期
 @return 是不是明天
 */
+ (BOOL)isTomorrowWith:(NSString *)dateString;


/**
 通过时间字符串获取年、月、日

 @param dateString 要截取的时间字符串
 @return 年、月、日
 */
+ (id)getYearAndMonthAndDayWith:(NSString *)dateString;


/**
 通过秒数获取时、分、秒

 @param seconds 要截取的时间字符串
 @return 时、分、秒
 */
+ (id)getHouseMinuteSecondWith:(NSTimeInterval)seconds;


/**
 通过 NSDate 计算年龄

 @param date 要判断的时间
 @return 年龄
 */
+ (id)getAgeWithDate:(NSDate *)date;


/**
 通过 dateString 计算年龄

 @param dateString 要判断的时间字符串
 @param dateModel 要判断的时间字符串格式
 @return 通过 dateString 计算年龄
 */
+ (id)getAgeWithDateString:(NSString *)dateString dateModel:(UIDateMode)dateModel;


/**
 将时间转换成时间戳(1970年01月01日00时00分00秒(北京时间1970年01月01日08时00分00秒)起至现在的总秒数。)

 @param dateString 要判断的时间字符串
 @param dateModel 要判断的时间字符串格式
 @return 时间戳
 */
+ (id)timeToTimeStampWith:(NSString *)dateString dateModel:(UIDateMode)dateModel;


/**
 将时间戳转换成时间

 @param timeStamp 要转换的时间戳
 @return 时间
 */
+ (id)timeStampToTime:(long)timeStamp;


/**
 将时间转换成时间字符串

 @param date 要转换的时间
 @param mode 要转换的时间字符串格式
 @return 时间字符串
 */
+ (id)dateIntoString:(NSDate *)date UIDateMode:(UIDateMode)mode;


/**
 将时间字符串转换成时间

 @param dateString 要转换的时间字符串
 @param mode 要转换的时间格式
 @return 时间
 */
+ (id)stringIntoDate:(NSString *)dateString UIDateMode:(UIDateMode)mode;

//


//

@end
