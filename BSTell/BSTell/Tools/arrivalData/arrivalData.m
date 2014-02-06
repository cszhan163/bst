//
//  arrivalData.m
//  bsteelPay
//
//  Created by ygj on 13-5-20.
//  Copyright (c) 2013年 wangxuhua. All rights reserved.
//

#import "arrivalData.h"

@implementation arrivalData
@synthesize money= _money , receivingside = _receivingside , info = _info , createDate = _createDate , extbill= _extbill , amt = _amt, yyZfqdid = _yyZfqdid, mallid = _mallid, retcode = _retcode;

-(id)init
{
    self = [super init];
    if ( self)
    {
        _mallid = [[NSString alloc] initWithString:@""]; 
        _yyZfqdid = [[NSString alloc] initWithString:@""];
        _money = [[NSString alloc] initWithString:@""];
        _receivingside = [[NSString alloc] initWithString:@""];
        _info = [[NSString alloc] initWithString:@""];
        _createDate = [[NSString alloc] initWithString:@""];
        _extbill = [[NSString alloc] initWithString:@""];
        _retcode = [[NSString alloc] initWithString:@""];
        _amt = [[NSString alloc] initWithString:@""];
    }
    return self;
}

-(void)dealloc
{
    _mallid = nil;
    _yyZfqdid = nil;
    _money = nil;
    _receivingside = nil;
    _info = nil;
    _createDate = nil;
    _extbill = nil;
    _amt = nil;
    _retcode = nil;
    
    [super dealloc];
}


@end






