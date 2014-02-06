//
//  global.m
//  bsteelPay
//
//  Created by ygj on 13-5-17.
//  Copyright (c) 2013年 wangxuhua. All rights reserved.
//

#import "global.h"
static global * myglobal = nil;

@implementation global
@synthesize equipment = _equipment;
@synthesize sessionID = _sessionID;
@synthesize companyName = _companyName;
@synthesize firstResponderObj = _firstResponderObj;
@synthesize updateURL = _updateURL;
@synthesize updateFlag = _updateFlag;
@synthesize BadgeValue = _BadgeValue;
+(global *)getGlobal
{
    @synchronized(self)
	{
		if (myglobal == nil)
		{
			myglobal = [[global alloc]init];
		}
	}
	return myglobal;
}
@end
