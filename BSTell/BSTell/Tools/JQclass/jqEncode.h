//
//  jqEncode.h
//  guosen
//
//  Created by  on 12-11-2.
//  Copyright (c) 2012年 JianQiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface jqEncode : NSObject

-(NSString*)encodeString:(NSString*)src;
-(NSString*)decodeString:(NSString*)src;

@end
