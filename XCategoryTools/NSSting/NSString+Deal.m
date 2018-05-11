//
//  NSString+Deal.m
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import "NSString+Deal.h"

#define TIME_ZONE @"Asia/Beijing"

@implementation NSString (Deal)


#pragma mark - 空值判断
/** 判断是否为空 */
- (BOOL)isNil {
    NSString *str = STRING(self);
    
    if ([str isEqualToString:@""]) {
        return YES;
    }
    
    if ([str isEqualToString:@"<null>"]) {
        return YES;
    }
    
    if ([str isEqualToString:@"(null)"]) {
        return YES;
    }
    
    if ([str isEqualToString:@"<nil>"]) {
        return YES;
    }
    
    if (str == nil || str == NULL) {
        return YES;
    }
    
    if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([str isEqual:[NSNull null]]) {
        return YES;
    }
    
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    
    
    return NO;

}


#pragma mark - URL处理

/** 判断网址是否有效 -- 未实现 */
- (BOOL)isHttp {
    
    NSString *number=@"^\[a-zA-z]+://(\\w+(-\\w+)*)(\\.(\\w+(-\\w+)*))*(\\?\\S*)?$";
    
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    
    return [numberPre evaluateWithObject:self];
}

/** 去掉字符串里的空格 - @" " 替换为 @"" */
- (NSString *)removeSpace {

    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

/** 替换字符串里的反斜线 - "\\" 替换为 "／" */
- (NSString *)replacBackslash {

    return [self stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
}

/** 替换字符串里的中文 */
- (NSString *)replacChinese {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

/** 格式化网址 - 返回 string */
- (NSString *)getUrlStr {
    
    return [[[self removeSpace] replacBackslash] replacChinese];
}

/** 格式化网址 - 返回 网址 */
- (NSURL *)getUrl {
    NSString *str = [self getUrlStr];
    
    NSURL *url = [NSURL URLWithString:str];
    
    return url;
}

/** 替换网址里的反斜线 - 在地址后加 token */
- (NSURL *)urlFromStringWithToken:(BOOL)flag {
    NSString *str = self;
    if (flag) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        str = [NSString stringWithFormat:@"%@&token=%@", self, [defaults objectForKey:@"token"]];
    }
    
    
    NSURL *url = [str getUrl];
    
    return url;
}

/** 替换网址里的反斜线 - 在地址后加 OSS 转换过的网址 */
- (NSURL *)urlFromStringWithOSSISPublic:(BOOL)flag {
    NSString *str = [[OSSManager sharedInstance] signAccessObjectURL:self isPublic:flag];
    
    NSURL *url = [str getUrl];
    
    return url;
}

/** 给字符串添加时间戳 */
- (NSString *)getStampStringWithDateMode:(UIDateMode)mode {
    
    NSString *stamp = [NSDate currentStampDateMode:mode];
    
    NSString *string = [NSString stringWithFormat:@"%@%@", self, stamp];
    
    return string;
}

//  for IPV6
+ (id)formatIPV6Address {
    NSString *address = nil;
    
    //    char dstStr[INET6_ADDRSTRLEN];
    //    char srcStr[INET6_ADDRSTRLEN];
    //    memcpy(srcStr, &self, sizeof(struct in6_addr));
    //    if(inet_ntop(AF_INET6, srcStr, dstStr, INET6_ADDRSTRLEN) != NULL){
    //        address = [NSString stringWithUTF8String:dstStr];
    //    }
    
    return address;
}

//  for IPV4
+ (id)formatIPV4Address {
    NSString *address = nil;
    
    //    char dstStr[INET_ADDRSTRLEN];
    //    char srcStr[INET_ADDRSTRLEN];
    //    memcpy(srcStr, &self, sizeof(struct in_addr));
    //    if(inet_ntop(AF_INET, srcStr, dstStr, INET_ADDRSTRLEN) != NULL){
    //        address = [NSString stringWithUTF8String:dstStr];
    //    }
    
    return address;
}

/** 直接打开网页 */
- (void)openURL {
    
//    NSDictionary *dic = [[NSDictionary alloc]init];
    
//    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:self] options:dic completionHandler:nil];
}


#pragma mark - 分节处理

/**  添加数字分节符 */
- (id)numFormat {
    // 小数位不变
    @try {
        if (self.length < 3) {
            return self;
        }
        
        NSString *numStr = self;
        NSArray *array = [numStr componentsSeparatedByString:@"."];
        NSString *numInt = [array objectAtIndex:0];
        if (numInt.length <= 3) {
            return self;
        }
        
        NSString *suffixStr = @"";
        if ([array count] > 1) {
            suffixStr = [NSString stringWithFormat:@".%@",[array objectAtIndex:1]];
        }
        
        NSMutableArray *numArr = [[NSMutableArray alloc] init];
        while (numInt.length > 3) {
            
            NSString *temp = [numInt substringFromIndex:numInt.length - 3];
            numInt = [numInt substringToIndex:numInt.length - 3];
            [numArr addObject:[NSString stringWithFormat:@",%@",temp]];// 得到的倒序的数据
        }
        
        int count = (int)[numArr count];
        for (int i = 0; i < count; i++) {
            numInt = [numInt stringByAppendingFormat:@"%@",[numArr objectAtIndex:(count -1 -i)]];
        }
        
        numStr = [NSString stringWithFormat:@"%@%@",numInt,suffixStr];
        
        return numStr;
    }
    @catch (NSException *exception) {
        return self;
    }
    @finally {}
    
    // 保留两位小数
    if(!self || [self floatValue] == 0) {
        return @"0.00";
    }
    else if ([self floatValue]<1) {
        return [NSString stringWithFormat:@"%@",self];
    }
    else {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setPositiveFormat:@",###.00"];
        
        return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[self doubleValue]]];
    }
    
}


#pragma mark - 号码处理

/** 判断是不是邮箱 */
- (BOOL)isEmail {
    
    NSString *email = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *regextestemail = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",email];
    
    return [regextestemail evaluateWithObject:self];
}

/** 判断是不是手机号 */
- (BOOL)isPhone {
    //    电信号段:133/153/180/181/189/177
    //    联通号段:130/131/132/155/156/185/186/145/176
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    //    虚拟运营商:170
    
//    NSString *phone = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    NSString *phone = @"1[0-9]{10}";
    NSPredicate *regextestphone = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phone];

    return [regextestphone evaluateWithObject:self];
    
//    if ([self length] == 11) {
//        return YES;
//    }
//    return NO;
}

/** 格式化手机号 */
- (NSString *)becomePhoneNum {
    NSString *newString;
    
    NSString *first = [self substringToIndex:3];
    
    NSString *second = [self substringWithRange:NSMakeRange(3, 4)];
    NSString *third = [self substringFromIndex:7];
    
    newString = [NSString stringWithFormat:@"%@ %@ %@",first,second,third];
    
    return newString;
    
}

//  格式化银行卡
- (id)becomeBankCardNum {
    NSString *newString;
    // 小数位不变
    @try {
        if (self.length < 4) {
            return self;
        }
        
        NSString *numStr = self;
        NSArray *array = [numStr componentsSeparatedByString:@" "];
        NSString *numInt = [array objectAtIndex:0];
//        if (numInt.length <= 3) {
//            return self;
//        }
        
        NSString *suffixStr = @" ";
//        if ([array count] > 1) {
//            suffixStr = [NSString stringWithFormat:@".%@",[array objectAtIndex:1]];
//        }
        
        NSMutableArray *numArr = [[NSMutableArray alloc] init];
        while (numInt.length > 4) {
            
            NSString *temp = [numInt substringFromIndex:numInt.length - 4];
            numInt = [numInt substringToIndex:numInt.length - 3];
            [numArr addObject:[NSString stringWithFormat:@",%@",temp]];// 得到的倒序的数据
        }
        
        int count = (int)[numArr count];
        for (int i = 0; i < count; i++) {
            numInt = [numInt stringByAppendingFormat:@"%@",[numArr objectAtIndex:(count -1 -i)]];
        }
        
        numStr = [NSString stringWithFormat:@"%@%@",numInt,suffixStr];
        
        return numStr;
    }
    @catch (NSException *exception) {
        return self;
    }
    @finally {}
    
    // 保留两位小数
    if(!self || [self floatValue] == 0) {
        return @"0.00";
    }
    else if ([self floatValue]<1) {
        return [NSString stringWithFormat:@"%@",self];
    }
    else {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setPositiveFormat:@",###.00"];
        return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[self doubleValue]]];
    }
    
    return newString;

}

/** 拨打电话 */
- (void)callPhone {
    NSString *phone = [NSString stringWithFormat:@"telprompt://%@",self];
    NSDictionary *dic = [[NSDictionary alloc]init];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone] options:dic completionHandler:nil];
    } else {
        // Fallback on earlier versions
        NSLog(@"小于 iOS 10.0");
    }
    
}

/** 判断手机号码的运营商类型 */
- (NSString *)judgePhoneNumType {
    NSString *phoneNumType = nil;
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,147,150,151,152,157,158,159,178,182,183,184,187,188
     * 联通：130,131,132,155,156,185,186,145,176
     * 电信：133,1349,153,180,181,189
     */
    //NSString *MOBILE = @"^1(3[0-9]|4[47]|5[0-35-9]|7[68]|8[0-9])\\d{8}$";
    
    /**
     * 中国移动
     */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     * 中国联通：China Unicom
     */
    NSString * CU = @"^1(3[0-2]|4[5]|5[256]|7[6]|8[56])\\d{8}$";
    /**
     * 中国电信
     */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     * 大陆地区固话及小灵通
     */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if ([regextestcm evaluateWithObject:self])
    {
        phoneNumType = @"中国移动";
    }
    else if ([regextestct evaluateWithObject:self])
    {
        phoneNumType = @"中国联通";
    }
    else if ([regextestcu evaluateWithObject:self])
    {
        phoneNumType = @"中国电信";
    }
    
    return phoneNumType;
}

/** 判断是不是固定电话 */
- (BOOL)isLandlinePhone {
    
    NSString *mobile = @"0\\d{2,3}-\\d{5,9}|0\\d{2,3}-\\d{5,9}";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",mobile];
    
    return [regextestmobile evaluateWithObject:self];
}

/** 判断是不是身份证号 */
- (BOOL)isPersonID {
    
    NSString *person = @"(\\d{14}[0-9a-zA-Z])|(\\d{17}[0-9a-zA-Z])";
    
    NSPredicate *regextestperson = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",person];
    
    return [regextestperson evaluateWithObject:self];
}

/** 判断是不是银行卡号 */
- (BOOL)isBankCard {
    
    NSString *CT = @"^([0-9]{16}|[0-9]{19})$";
    NSPredicate *regextestCard = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    return [regextestCard evaluateWithObject:self];
}

/** 根据身份证判断生日 */
- (NSString *)birthdayWithPersonID {
    NSMutableString *result = [NSMutableString stringWithCapacity:0];
    
    NSString *year = nil;
    NSString *month = nil;
    NSString *day = nil;
    
    
    // xxxxxx YYYYMMDD xxx
    if([self length] == 18) {
        // 截取有效部分 YYYYMMDD
        NSString *fontNumer = [self substringWithRange:NSMakeRange(6, 8)];
        
        if ([fontNumer isNumberByRegExp]) {
            
            year = [fontNumer substringWithRange:NSMakeRange(0, 4)];
            
            month = [fontNumer substringWithRange:NSMakeRange(4, 2)];
            
            day = [fontNumer substringWithRange:NSMakeRange(6,2)];
            
            [result appendString:year];
            
            [result appendString:@"-"];
            
            [result appendString:month];
            
            [result appendString:@"-"];
            
            [result appendString:day];
            
            return result;
            
        }
        else {
            return result;
        }
        
        
    }
    // xxxxxx YYMMDD xxx
    else if ([self length] == 15) {
        
        // 截取有效部分 YYMMDD
        NSString *fontNumer = [self substringWithRange:NSMakeRange(6, 6)];
        
        if ([fontNumer isNumberByRegExp]) {
            year = [NSString stringWithFormat:@"19%@",[fontNumer substringWithRange:NSMakeRange(0, 2)]];
            
            month = [fontNumer substringWithRange:NSMakeRange(2, 2)];
            
            day = [fontNumer substringWithRange:NSMakeRange(4,2)];
            
            [result appendString:year];
            
            [result appendString:@"-"];
            
            [result appendString:month];
            
            [result appendString:@"-"];
            
            [result appendString:day];
            
            return result;
            
        }
        else {
            return result;
        }
        
    }
    // 无法识别的号码
    else {
        return result;
    }
}

/** 根据身份证判断年龄 */
- (NSString *)ageWithPersonID {
    
    NSDateFormatter *formatterTow = [[NSDateFormatter alloc]init];
    
    [formatterTow setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *bsyDate = [formatterTow dateFromString:[self birthdayWithPersonID]];
    
    NSTimeInterval dateDiff = [bsyDate timeIntervalSinceNow];
    
    int age = trunc(dateDiff/(60*60*24))/365;
    
    
    return [NSString stringWithFormat:@"%d",-age];
    
}

/** 根据身份证判断性别 */
- (NSString *)genderWithPersonID {
    NSString *sex = @"";
    
    // 获取18位 二代身份证
    if (self.length == 18)  {
        
        int sexInt = [[self substringWithRange:NSMakeRange(16,1)] intValue];
        
        if(sexInt%2 == 0)  {
            sex = @"女";
        }
        else {
            sex = @"男";
        }
    }
    
    // 获取15位 一代身份证
    if (self.length == 15) {
        
        int sexInt = [[self substringWithRange:NSMakeRange(14,1)] intValue];
        
        if(sexInt%2 == 0) {
            sex = @"女";
        }
        else {
            sex = @"男";
        }
    }
    
    
    return sex;
}


#pragma mark - 数字处理

/** 判断是不是正确密码格式 */
- (BOOL)isPassword {
    
    NSString *password = @"^[0-9A-Za-z_]{6,20}";
    NSPredicate *regextestpassword = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",password];
    
    return [regextestpassword evaluateWithObject:self];
    
}

/** 通过『正则表达式』判断是不是纯数 */
- (BOOL)isNumberByRegExp {
    BOOL isValid = YES;
    NSUInteger len = self.length;
    if (len > 0) {
        NSString *numberRegex = @"^[0-9]*$";
        NSPredicate *numberPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
        isValid = [numberPredicate evaluateWithObject:self];
    }
    return isValid;
}

/** 通过『ASCII码』判断是不是纯数 */
- (BOOL)isNumberByASCII {
    BOOL isValid = YES;
    NSUInteger len = self.length;
    if (len > 0) {
        for (NSUInteger i=0; i<len; i++) {
            NSUInteger asciiCode = [self characterAtIndex:i];
            if (asciiCode < 48 || asciiCode > 57) {
                isValid = NO;
                break;
            }
        }
    }
    return isValid;
}

/** 通过『字符范围』判断是不是纯数 */
- (BOOL)isNumberByRange {
    BOOL isValid = YES;
    NSUInteger len = self.length;
    if (len > 0) {
        NSCharacterSet *validNumberCS = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        NSUInteger singleStrIndex = 0;
        do {
            NSString *singleStr = [self substringWithRange:NSMakeRange(singleStrIndex, 1)];
            NSRange range = [singleStr rangeOfCharacterFromSet:validNumberCS];
            if (range.length == 0) {
                isValid = NO;
                break;
            }
            singleStrIndex++;
        } while (singleStrIndex < len);
    }
    return isValid;
}

/** 十进制转换成十六进制 */
- (NSString *)getHexadecimal {
    Byte bytes[] = {0xA6,0x27,0x0A};
    
    NSString *str  = [NSString stringWithFormat:@"%@",[[NSString alloc]initWithFormat:@"%02lx",(long)bytes[0]]];
    
    return str;
}

/** 十六进制转换成十进制 */
- (NSString *)getDecimal {
    
    NSString *str = [self substringWithRange:NSMakeRange(2,2)];
    
    str = [NSString stringWithFormat:@"%ld",strtoul([str UTF8String],0,16)];
    
    return str;
}

/** 将16进制的字符串转换成 NSData  */

#pragma mark - 大小处理

/** 获取字符串的字节大小 */
- (int)stringConvertToInt {
    
    int strlength = 0;
    char *p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i < [self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        } else {
            p++;
        }
    }

    
    return (strlength + 1) / 2.0;
}

/** 计算不可变字符串大小 */
- (CGSize)getStringSize:(CGSize)size font:(CGFloat)font {
    
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:AUTO_SCALE_F(font)]} context:nil];
    
    return rect.size;
}

/** 计算可变字符串大小 */
- (CGSize)getSizeAttributedString:(NSMutableAttributedString *)mutStr {
    CGRect rect = [mutStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    return rect.size;
}



//+ (id)stringReplaceWithFace {
//    NSString *mutaStr;
//    
//    for (int i=0x1F600; i<=0x1F64F; i++) {
//        if (i < 0x1F641 || i > 0x1F644) {
//            int sym = EMOJI_CODE_TO_SYMBOL(i);
//            NSString *emoT = [[NSString alloc] initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];
//            
//            mutaStr = [self stringByReplacingOccurrencesOfString:emoT withString:[NSString stringWithFormat:@"%d",sym]];
//        }
//    }
//    
//    return mutaStr;
//}

/** 判断是否有表情符号，有则转换成可上传的格式 */
- (BOOL)stringContainsEmoji {
//- (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:      ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    returnValue = YES;
                    
                }
                
            }
            
        } else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
                returnValue = YES;
                
            }
            
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff) {
                returnValue = YES;
                
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue = YES;
                
            } else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue = YES;
                
            } else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue = YES;
                
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                returnValue = YES;
                
            }
            
        }
        
    }];
    
    return returnValue;
    
}

@end
