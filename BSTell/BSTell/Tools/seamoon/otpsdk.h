//
//  otpsdk.h
//  otpsdk
//
//  Created by wu chengming on 13-7-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface otpsdk : NSObject
- (NSString *) GetOneTimePassWord : (NSString *) sninfo ;
- (NSString *) GetTokenSN:(NSString *) macaddress;
-(NSString *) GetTokenSNinfo:(NSString *)otpurl :(NSString*)macaddress  :(NSString*)tokensn;
@end
