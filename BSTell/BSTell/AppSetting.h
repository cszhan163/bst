//
//  AppSetting.h
//  BSTell
//
//  Created by cszhan on 14-2-27.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppSetting : NSObject
+(void)setLoginUserDetailInfo:(NSDictionary*)dict userId:(NSString*)userId;
+(NSDictionary*)getLoginUserData:(NSString*)userId;
+(NSString*)getLoginUserId;
+(void)setLogoutUser;
@end
