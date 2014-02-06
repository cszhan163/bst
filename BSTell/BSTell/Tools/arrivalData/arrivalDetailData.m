//
//  arrivalDetailData.m
//  bsteelPay
//
//  Created by ygj on 13-5-20.
//  Copyright (c) 2013年 wangxuhua. All rights reserved.
//

#import "arrivalDetailData.h"

@implementation arrivalDetailData
@synthesize pmStr = _pmStr ,createPlace = _createPlace , weightStr = _weightStr , numStr = _numStr ,plusStr = _plusStr , sizeStr = _sizeStr ,madeOf = _madeOf ,priceStr = _priceStr;

-(id)init
{
    self = [super init];
    if (self)
    {
//        _pmStr = [[NSString alloc]initWithString:@""];
//        _createPlace = [[NSString alloc]initWithString:@""];
//        _weightStr = [[NSString alloc]initWithString:@""];
//        _numStr = [[NSString alloc]initWithString:@""];
//        _plusStr = [[NSString alloc]initWithString:@""];
//        _sizeStr = [[NSString alloc]initWithString:@""];
//        _madeOf = [[NSString alloc]initWithString:@""];
//        _priceStr = [[NSString alloc]initWithString:@""];
        _pmStr = [[NSString alloc]initWithString:@"纯锌热镀锌板卷"];
        _createPlace = [[NSString alloc]initWithString:@"三亚亚星小亚细亚"];
        _weightStr = [[NSString alloc]initWithString:@"98.70"];
        _numStr = [[NSString alloc]initWithString:@"2"];
        _plusStr = [[NSString alloc]initWithString:@"98.70吨/2件"];
        _sizeStr = [[NSString alloc]initWithString:@"2.0*1018*C"];
        _madeOf = [[NSString alloc]initWithString:@"ST05Z 80MB-O"];
        _priceStr = [[NSString alloc]initWithString:@"50,000.00"];
    }
    return self;
}

-(void)dealloc
{
    _pmStr = nil;
    _createPlace = nil;
    _weightStr = nil;
    _numStr = nil;
    _plusStr = nil;
    _sizeStr = nil;
    _madeOf = nil;
    _priceStr = nil;
    
    [super dealloc];
}

@end
