//
//  AES128.h
//  AES128
//
//  Created by haifeng on 13-6-8.
//  Copyright (c) 2013年 haifeng. All rights reserved.
//

// 开发中用到AES128加密、解密
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonKeyDerivation.h>
@interface NSData (AES128)
- (NSData *)AES128Operation:(CCOperation)operation key:(NSString *)key iv:(NSString *)iv;
+ (NSString *)AES128EncryptWithString:(NSString *)plain;
+ (NSString *)AES128DecryptWithString:(NSString *)ciphertexts;
@end