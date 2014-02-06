//
//  global.h
//  bsteelPay
//
//  Created by ygj on 13-5-17.
//  Copyright (c) 2013年 wangxuhua. All rights reserved.
//

#import <Foundation/Foundation.h>

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
