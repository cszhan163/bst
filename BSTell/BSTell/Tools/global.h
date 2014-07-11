//
//  global.h
//  bsteelPay
//
//  Created by ygj on 13-5-17.
//  Copyright (c) 2013年 wangxuhua. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 test:
 #define kHttpsRequestUrl  @"https://uatm.b-chem.com:9002/app/"
 #define kHttpRequestUrl  @"https://uatm.b-chem.com:9002/app/"
 app store:
 
 #define kHttpsRequestUrl  @"https://m.b-chem.com:9005/app/"
 #define kHttpRequestUrl  @"https://m.b-chem.com:9005/app/"
 */

#define kKeyCode   @"jkznf7585535556160675056460853260"

#if 1

#define kHttpsRequestUrl  @"https://uatm.b-chem.com:9002/app/"
#define kHttpRequestUrl  @"https://uatm.b-chem.com:9002/app/"

#define CERNAME @"client"
#else
//https://211.144.193.11:8000/app/queryAuctionWts4Move_V1
#define kHttpsRequestUrl  @"https://211.144.193.11:8000/app/"
#define kHttpRequestUrl  @"https://211.144.193.11:8000/app/"
#define CERNAME @"test"
#endif
@interface global : NSObject
{
    NSString *_equipment;//设备型号 4 or 5
    NSString *_sessionID;
    NSString *_companyName;
    id        _firstResponderObj;
    NSString *_updateURL;
    BOOL      _updateFlag;
    NSInteger _BadgeValue;
}
@property(nonatomic,assign) NSInteger BadgeValue;
@property(nonatomic,retain) NSString *equipment;
@property(nonatomic,retain) NSString *sessionID;
@property(nonatomic,retain) NSString *companyName, *updateURL;
@property(nonatomic,assign) id        firstResponderObj;
@property(nonatomic,assign) BOOL     updateFlag;
+(global *)getGlobal;

@end
