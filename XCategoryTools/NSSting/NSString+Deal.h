//
//  NSString+Deal.h
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>
#import <UIKit/UIKit.h>

@interface NSString (Deal)


#pragma mark - 空值判断

/** 判断是否为空 */
- (BOOL)isNil;


#pragma mark - 网址处理

/** 判断网址是否有效 -- 未实现 */  
- (BOOL)isHttp;

/** 去掉字符串里的空格 - @" " 替换为 @"" */
- (NSString *)removeSpace;

/** 替换字符串里的反斜线 - "\\" 替换为 "／" */
- (NSString *)replacBackslash;

/** 替换字符串里的中文 */
- (NSString *)replacChinese;

/** 格式化网址 - 返回 string */
- (NSString *)getUrlStr;

/** 格式化网址 - 返回 网址 */
- (NSURL *)getUrl;

/** 替换网址里的反斜线 - 在地址后加 token */
- (NSURL *)urlFromStringWithToken:(BOOL)flag;

/** 替换网址里的反斜线 - 在地址后加 OSS 转换过的网址 */
- (NSURL *)urlFromStringWithOSSISPublic:(BOOL)flag;

/** 给字符串添加时间戳 */
- (NSString *)getStampStringWithDateMode:(UIDateMode)mode;

/** 直接打开网页 */
- (void)openURL;


#pragma mark - 分节处理

/**  添加数字分节符 */
- (id)numFormat;


#pragma mark - 号码处理

/** 判断是不是邮箱 */
- (BOOL)isEmail;

/** 判断是不是手机号 */
- (BOOL)isPhone;

/** 格式化手机号 */
- (NSString *)becomePhoneNum;

/** 拨打电话 */
- (void)callPhone;

/** 判断手机号码的运营商类型 */
- (NSString *)judgePhoneNumType;

/** 判断是不是固定电话 */
- (BOOL)isLandlinePhone;

/** 判断是不是身份证号 */
- (BOOL)isPersonID;

/** 判断是不是银行卡号 */
- (BOOL)isBankCard;

/** 根据身份证判断生日 */
- (NSString *)birthdayWithPersonID;

/** 根据身份证判断年龄 */
- (NSString *)ageWithPersonID;

/** 根据身份证判断性别 */
- (NSString *)genderWithPersonID;


#pragma mark - 数字处理

/** 判断是不是正确密码格式 */
- (BOOL)isPassword;

/** 通过『正则表达式』判断是不是纯数 */
- (BOOL)isNumberByRegExp;

/** 通过『ASCII码』判断是不是纯数 */
- (BOOL)isNumberByASCII;

/** 通过『字符范围』判断是不是纯数 */
- (BOOL)isNumberByRange;

/** 十进制转换成十六进制 */
- (NSString *)getHexadecimal;

/** 十六进制转换成十进制 */
- (NSString *)getDecimal;

/** 将16进制的字符串转换成 NSData  */


#pragma mark - 大小处理

/** 获取字符串的字节大小 */
- (int)stringConvertToInt;

/** 计算不可变字符串大小 */
- (CGSize)getStringSize:(CGSize)size font:(CGFloat)font;

/** 计算可变字符串大小 */
- (CGSize)getSizeAttributedString:(NSMutableAttributedString *)mutStr;

/** 判断是否有表情符号，有则转换成可上传的格式 */
- (BOOL)stringContainsEmoji;

@end
