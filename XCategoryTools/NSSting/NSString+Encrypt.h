//
//  NSString+Encrypt.h
//  CMe
//
//  Created by OS X on 2018/1/25.
//  Copyright © 2018年 杭州石匍丁科技公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encrypt)


#pragma mark - MD5 单项加密，不可解密

/** MD5直接加密 */
- (id)MD5;

/** MD5加盐加密 */
- (id)MD5WithStr:(NSString *)string;

/** MD5多次加密 */
- (id)MD5WithMD5;

/**  MD5先加密，后乱序 */
- (id)MD5WithOrder;


#pragma mark - SHA1 单项加密，不可解密

/** SHA1 加密 */
- (id)SHA1;

/** SHA256加密 */
- (id)SHA256;


#pragma mark - DES

/** 加密方法 */
//+ (id)DESEncrypt;

/** 解密方法 */
//+ (id)DESDecrypt;

#pragma mark - AES


#pragma mark - RSA




@end
