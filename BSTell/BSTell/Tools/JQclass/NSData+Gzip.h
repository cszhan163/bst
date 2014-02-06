//
//  NSData+Gzip.h
//  PullTest
//
//  Created by  on 12-10-26.
//  Copyright (c) 2012年 JianQiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (GZip)

- (NSData *)gzipInflate;
- (NSData *)gzipDeflate;

@end
