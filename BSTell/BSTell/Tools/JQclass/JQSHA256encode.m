//
//  JQSHA256encode.m
//  bsteelPay
//
//  Created by haifeng on 13-6-7.
//  Copyright (c) 2013年 wangxuhua. All rights reserved.
//

#import "JQSHA256encode.h"

@implementation JQSHA256encode

+(NSString*)encodeString:(NSString*)src
{
    NSData *data = [src dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(data.bytes, data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

@end
