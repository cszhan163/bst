//
//  DressMemoNetDataMgr.m
//  DressMemo
//
//  Created by  on 12-6-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CarServiceNetDataMgr.h"
#import "ZCSNetClientNetInterfaceMgr.h"
#import "ZCSNetClientConfig.h"
#import "ZCSNetClient.h"
#import "ZCSNotficationMgr.h"
#import "JQConnect_bsteelPay.h"
//#import "AppSetting.h"
//#import <iPlat4M_framework/iPlat4M_framework.h>
//#import "AppConfig_bak.h"
@interface CarServiceNetDataMgr()
@property(nonatomic,retain)NSMutableDictionary *requestResourceDict;
//@property(nonatomic,assign)BOOL isUserLogOut;
@end
static CarServiceNetDataMgr *sharedInstance = nil;
static ZCSNetClientNetInterfaceMgr *dressMemoInterfaceMgr = nil;
@implementation CarServiceNetDataMgr
@synthesize requestResourceDict;
+(id)getSingleTone{
    @synchronized(self)
    {
        if(sharedInstance == nil)
            sharedInstance = [[self alloc] init];
        
    }
    return sharedInstance;
}
-(id)init
{
    if(self = [super init])
    {
        dressMemoInterfaceMgr = [ZCSNetClientNetInterfaceMgr getSingleTone];
        NSDictionary *requestResouceMapDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                               
                                               @"login",        kNetLoginRes,
                                               @"register",             kNetResignRes,
                                               @"search_goods", @"getgoodslist",
                                               @"search_goodDetail",@"getGoodDetail",
                                               @"search_orders_old",@"search_orders_old",
                                               @"search_orders_month",@"search_orders_month",
                                               @"search_good_ad",@"getGoodAd",
                                               @"search_good_ad",@"getGoodMap",
                                               @"search_category",@"search_category",
                                               @"search_orders",@"search_orders",
                                               @"search_ordergoods",@"search_ordergoods",
                                               @"search_orderDetail",@"search_orderDetail",
                                               @"search_fav",@"search_fav",
                                               @"search_delivery",@"search_delivery",
                                               @"pay",@"pay",
                                               
                                               @"search_address",@"search_address",
                                               @"add_address",@"add_address",
                                               @"edit_address",@"edit_address",
                                               
                                               @"search_province",@"search_province",
                                               @"search_city",@"search_city",
                                               @"search_good_map",@"search_good_map",
                                               
                                               @"delete_order",@"delete_order",
                                               @"update",       @"update",
                                               @"getsms",       @"getsms",
                                               @"update_contacts",@"update_contacts",
                                               @"getsmsfindpassword",@"getsmsfindpassword",
                                               @"findpassword",@"findpassword",
                                               
                                               @"new_order",    @"new_order",
                                               @"search_ad",@"search_ad",
                                               @"search_good_ad",@"search_good_ad",
                                               @"search_good_map",@"search_good_map",
                                               @"update_userico",@"update_userico",
                                                   @"search_deliveryDetail",@"search_deliveryDetail",
                                               @"getDetailByDay",@"getDetailByDay",
                                               @"getInfoByMonth",@"getInfoByMonth",
                                               @"check",@"check",
                                               nil];
        dressMemoInterfaceMgr.requestResourceDict = requestResouceMapDict;
        
        dressMemoInterfaceMgr.netInterfaceDataSource = self;
        dressMemoInterfaceMgr.netInterfaceDelegate = self;
        //requestResourceDict = [[NSMutableDictionary alloc]init];
#if 0
        [ZCSNotficationMgr addObserver:self call:@selector(didGetDataFromNet:) msgName:kZCSNetWorkOK];
        [ZCSNotficationMgr addObserver:self call:@selector(didGetDataFromNetFailed:) msgName:kZCSNetWorkRequestFailed];
#endif
        //dbMgr = [DBManage getSingleTone];
    }
    return self;
}
#pragma mark -
#pragma mark -common
- (void)sendRequest:(NSString*)method withVersion:(NSString*)ver withParam:(NSDictionary*)param
         withOkBack:(SEL)okCallBackFun  withFailedBack:(SEL)failedBack
{
    
    JQConnect_bsteelPay *connect = [[JQConnect_bsteelPay alloc] initWithDelegate:self successCallBack:okCallBackFun failedCallBack:failedBack andMethodName:[NSString stringWithFormat:@"%@_%@",method,ver]];
    for (id key in param) {
        [connect addParam:[param objectForKey:key] forKey:key];
    }
    [connect sendRequest];
}
#pragma mark -
#pragma mark -public New
- (void)querySitePubmsg4Move:(NSDictionary*)param{
    
    JQConnect_bsteelPay *requestEng = [[JQConnect_bsteelPay alloc] initWithDelegate:self successCallBack:@selector(querySitePubmsg4MoveOK:) failedCallBack:@selector(querySitePubmsg4MoveFailed:) andMethodName:@"querySitePubmsg4Move_v10"];
    /*
     @"10",@"limit",
     @"1",@"offset",
     */
    [requestEng addParam:@"10" forKey:@"limit"];
    [requestEng addParam:@"1" forKey:@"offset"];
    [requestEng addParam:@"1" forKey:@"zc"];
    [requestEng addParam:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:@"version"];
    [requestEng sendRequest];
}
- (void)querySitePubmsg4MoveOK:(NSString*)result{
    
    
}
- (void)querySitePubmsg4MoveFailed:(NSString*)error{
    
}

#pragma mark -
#pragma mark -bid
- (void)queryBidPubmsg4Move:(NSDictionary*)param{

    /*
     调用资源接口参数	参数名称	参数类型	备注	 (参数值)
     gglx	公告类型		0  交易预告
     1  竞价公告
     2  市场公告
     zc	专场类型（循环物资，钢材正品）		1 钢材正品
     2 循环物资
     limit	数据条数默认10条
     offset	第几页
     */
    param = [NSDictionary dictionaryWithObjectsAndKeys:
             @"0",@"gglx",
             @"10",@"limit",
             @"1",@"offset",
             nil];
    [self sendRequest:@"queryBidPubmsg4Move" withVersion:@"v10" withParam:param withOkBack:@selector(queryBidPubmsg4MoveOk:) withFailedBack:@selector(queryBidPubmsg4MoveFailed:)];

}
- (void)queryBidPubmsg4MoveOk:(NSString*)result{
  
    
}
- (void)queryBidPubmsg4MoveFailed:(NSString*)error{

}

- (void)queryAuctionPps4Move:(NSDictionary*)param{
    /*
     hydm	会员代码
     limit	数据条数默认10条
     offset	第几页
     
     */
    param = [NSDictionary dictionaryWithObjectsAndKeys:
             @"001",@"hydm",
             @"10",@"limit",
             @"1",@"offset",
             nil];
    [self sendRequest:@"queryBidPubmsg4Move" withVersion:@"v10" withParam:param withOkBack:@selector(queryBidPubmsg4MoveOk:) withFailedBack:@selector(queryBidPubmsg4MoveFailed:)];


}
- (void)getAccountInfo:(NSDictionary*)param{


}
#pragma mark -
#pragma mark user

@end
