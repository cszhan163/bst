//
//  JQConnect_bsteelPay.h
//  bsteelPay
//
//  Created by haifeng on 13-5-23.
//  Copyright (c) 2013年 wangxuhua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JQNetworkHelper.h"
#import "JQHTTPSConnect.h"

@interface JQConnect_bsteelPay : NSObject
{
    NSMutableString *postString;
    NSString *MethodString;
    NSString *appCode;
    SEL failSelector;
    SEL finishSelector;
    id  obj;
    BOOL compressdata;
    BOOL encryptdata;
    BOOL progress;
    JQNetworkHelper *jqConnect;
    JQHTTPSConnect *connect;
    BOOL encodeYN;
    BOOL isHTTPS;
    JQHTTPSConnect *failedHTTPSConnect;
    JQNetworkHelper *failedConnect;
    NSInteger count;
}
@property (nonatomic ,assign) BOOL compressdata;
@property (nonatomic ,assign) BOOL encryptdata;
@property (nonatomic ,assign) BOOL progress;
@property (nonatomic ,assign) BOOL encodeYN;
@property(nonatomic, retain) NSString *appCode;
@property (nonatomic, retain) NSString *MethodString;
@property (nonatomic, retain) NSMutableString *postString;
@property (nonatomic, retain) JQNetworkHelper *jqConnect;
-(void)addParam:(NSString*)value forKey:(NSString*)key;
-(NSString *)getPostString;
-(id)initWithDelegate:(id)delegate successCallBack:(SEL)didFinishSelector failedCallBack:(SEL)didFailSelector andMethodName:(NSString *)methodName;
-(void)sendRequest;
-(void)cancelConnect;
@end
