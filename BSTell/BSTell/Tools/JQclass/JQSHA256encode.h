//
//  JQSHA256encode.h
//  bsteelPay
//
//  Created by haifeng on 13-6-7.
//  Copyright (c) 2013年 wangxuhua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface JQSHA256encode : NSObject

+(NSString*)encodeString:(NSString*)src;

@end
