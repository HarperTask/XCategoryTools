//
//  NSString+Encrypt.m
//  CMe
//
//  Created by OS X on 2018/1/25.
//  Copyright © 2018年 杭州石匍丁科技公司. All rights reserved.
//

#import "NSString+Encrypt.h"
const Byte iv[] = {1,2,3,4,5,6,7,8};

@implementation NSString (Encrypt)


#pragma mark - 加密处理

// MD5直接加密
- (id)MD5 {
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (int)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

// MD5加盐加密
- (id)MD5WithStr:(NSString *)string{
    NSString *anwen = [self stringByAppendingString:string];
    
    anwen = [anwen MD5];
    
    return anwen;
}

// MD5多次加密
- (id)MD5WithMD5 {
    NSString *anwen = [self MD5];
    
    anwen = [anwen MD5];
    
    return anwen;
}

// MD5先加密，后乱序
- (id)MD5WithOrder {
    NSString *anwen = [self MD5];
    NSString *header = [anwen substringToIndex:2];
    NSString *footer = [anwen substringFromIndex:2];
    
    anwen = [footer stringByAppendingString:header];
    
    return anwen;
}


#pragma mark - SHA1 单项加密，不可解密

// SHA1加密
- (id)SHA1 {
    const char *cStr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cStr length:self.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}

// SHA256加密
- (id)SHA256 {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes, (unsigned int)data.length, digest);
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}


#pragma mark - DES

// 加密方法 


// 解密方法


#pragma mark - AES


#pragma mark - RSA

@end
