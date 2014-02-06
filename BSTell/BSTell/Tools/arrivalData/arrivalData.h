//
//  arrivalData.h
//  bsteelPay
//
//  Created by ygj on 13-5-20.
//  Copyright (c) 2013年 wangxuhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface arrivalData : NSObject
{
    NSString *_money;//金额
    NSString *_receivingside;//收款方
    NSString *_info;//业务信息
    NSString *_createDate;//生成日期
    NSString *_extbill;//订单号
    
    NSString *_yyZfqdid;
    NSString *_mallid;
    NSString *_retcode;//附属属性retcode
    NSString *_amt;//附属属性amt
}

@property (nonatomic , retain) NSString *mallid;
@property (nonatomic , retain) NSString *yyZfqdid;
@property (nonatomic , retain) NSString *money;//金额
@property (nonatomic , retain) NSString *receivingside;//收款方
@property (nonatomic , retain) NSString *info;//业务信息
@property (nonatomic , retain) NSString *createDate;//生成日期
@property (nonatomic , retain) NSString *extbill;//订单号
@property (nonatomic , retain) NSString *retcode;//附属属性retcode
@property (nonatomic , retain) NSString *amt;//附属属性amt

@end
