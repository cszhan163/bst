//
//  arrivalDetailData.h
//  bsteelPay
//
//  Created by ygj on 13-5-20.
//  Copyright (c) 2013年 wangxuhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface arrivalDetailData : NSObject
{
    NSString *_pmStr;//品名
    NSString *_createPlace;//产地
    NSString *_weightStr;//重量
    NSString *_numStr;//件数
    NSString *_plusStr;//吨/件
    NSString *_sizeStr;//规格
    NSString *_madeOf;//材质
    NSString *_priceStr;//单价
}

@property (nonatomic ,retain) NSString *pmStr;//品名
@property (nonatomic ,retain) NSString *createPlace;//产地
@property (nonatomic ,retain) NSString *weightStr;//重量
@property (nonatomic ,retain) NSString *numStr;//件数
@property (nonatomic ,retain) NSString *plusStr;//吨/件
@property (nonatomic ,retain) NSString *sizeStr;//规格
@property (nonatomic ,retain) NSString *madeOf;//材质
@property (nonatomic ,retain) NSString *priceStr;//单价

@end
