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

- (void)sendFinalOkData:(id)data withKey:(NSString*)key{
    NSDictionary *item = [NSDictionary dictionaryWithObjectsAndKeys:
                          data,@"data",
                          key,@"key",
                          nil];
    [ZCSNotficationMgr postMSG:kZCSNetWorkOK obj:item];
}
- (void)sendFinalFailedData:(id)data withKey:(NSString*)key{
    NSDictionary *item = [NSDictionary dictionaryWithObjectsAndKeys:
                          data,@"data",
                          key,@"key",
                          nil];
    [ZCSNotficationMgr postMSG:kZCSNetWorkRequestFailed obj:item];
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
    
    id data = [result JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalOkData:finalData withKey:kResNoteNewsData];
}
- (void)querySitePubmsg4MoveFailed:(NSString*)error{
    
}
- (void)getBidPubmsgById4Move:(NSDictionary*)param{

    /*
     公告ID	ggid
     会员代码	hydm
     */
    if(param == nil){
    param = [NSDictionary dictionaryWithObjectsAndKeys:
             @"0",@"ggid",
             @"0",@"hydm",
             nil];
    }
    [self sendRequest:@"getBidPubmsgById4Move" withVersion:@"v10" withParam:param withOkBack:@selector(getBidPubmsgById4MoveOk:) withFailedBack:@selector(getBidPubmsgById4MoveFailed:)];
}
- (void)getBidPubmsgById4MoveOk:(NSString*)result{
    
    id data = [result JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalOkData:finalData withKey:kResNoteBidDetail];
}
- (void)getBidPubmsgById4MoveFailed:(NSString*)error{
    
}

//getSitePubmsgById4Move
- (void)getSitePubmsgById4Move:(NSDictionary*)param{
    
    /*
     公告ID	ggid
     会员代码	hydm
     */
    if(param == nil){
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"0",@"ggid",
                 @"0",@"hydm",
                 nil];
    }
    [self sendRequest:@"getSitePubmsgById4Move" withVersion:@"v10" withParam:param withOkBack:@selector(getSitePubmsgById4MoveOk:) withFailedBack:@selector(getSitePubmsgById4MoveFailed:)];
}
- (void)getSitePubmsgById4MoveOk:(NSString*)result{
    
    id data = [result JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalOkData:finalData withKey:kResNoteNewsDetail];
}
- (void)getSitePubmsgById4MoveFailed:(NSString*)error{
    
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
    if(param == nil){
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"0",@"gglx",
                 @"0",@"zc",
                 @"10",@"limit",
                 @"1",@"offset",
                 nil];
    }
    [self sendRequest:@"queryBidPubmsg4Move" withVersion:@"v10" withParam:param withOkBack:@selector(queryBidPubmsg4MoveOk:) withFailedBack:@selector(queryBidPubmsg4MoveFailed:)];

}
- (void)queryBidPubmsg4MoveOk:(NSString*)result{
  
    id data = [result JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalOkData:finalData withKey:kResNoteBidData];

}
- (void)queryBidPubmsg4MoveFailed:(NSString*)error{

}

- (void)queryAuctionPps4Move:(NSDictionary*)param{
    /*
    
     hydm	会员代码
     zc	专场代码
     wtzt	场次状态
     limit	数据条数默认10条
     offset	第几页
     rqStart	竞价日期1
     rqEnd	竞价日期2
     */
    if(param == nil){
        param = [NSDictionary dictionaryWithObjectsAndKeys:
             @"001",@"hydm",
             @"10",@"limit",
             @"1",@"offset",
             nil];
    }
    [self sendRequest:@"queryAuctionPps4Move" withVersion:@"v10" withParam:param withOkBack:@selector(queryAuctionPps4MoveOk:) withFailedBack:@selector(queryAuctionPps4MoveFailed:)];


}
- (void)queryAuctionPps4MoveOk:(NSString*)result{
    
#if 0
    [NSJSONSerialization )JSONObjectWithData:(NSData *)data options:(NSJSONReadingOptions)opt error:(NSError **)error;];
#else
    id data = [result JSONValue];

    NSDictionary  *finalData = nil;
#if 0
    NSMutableArray *key_value_array = [NSMutableArray array];
    for(id key in data){
        
        id value = [data  objectForKey:key];
        /*
        if([value  isKindOfClass:[NSArray Class]]){
            
        }
        */
        [key_value_array addObject:key];
        [key_value_array addObject:value];
    }
    NSMutableArray *finalDataArray = [NSMutableArray array];
    int itemNumber = [key_value_array count]/2;
    for(int i = 0;i< itemNumber;i++){
        NSMutableDictionary *item =[NSMutableDictionary dictionary];
        [finalDataArray addObject:item];
    }
    for(int i = 0;i< itemNumber;i=i+2){
        NSString *key = key_value_array[i];
        int itemCount  = [key_value_array[i+1] count];
        id value  = nil;
        for(int j = 0;j<itemCount;j++){
           value  = [key_value_array[i+1] objectAtIndex:j];
            [finalDataArray[j] setValue:value forKey:key];
        }
    }
    data = finalDataArray;
    finalData = [NSDictionary dictionaryWithObject:data forKey:@"data"];
#else
    finalData = data;
#endif
    
#endif
    
    [self sendFinalOkData:finalData withKey:kResBidAllListData];
}
- (void)queryAuctionPps4MoveFailed:(NSString*)error{
    [self sendFinalFailedData:error withKey:kResBidAllListData];
}
- (void)queryAuctionWts4Move:(NSDictionary*)param{
    /*
     
     hydm	会员代码
     zc	专场代码
     wtzt	场次状态
     limit	数据条数默认10条
     offset	第几页
     rqStart	竞价日期1
     rqEnd	竞价日期2
     */
    if(param == nil){
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"001",@"hydm",
                 @"1",@"zc",
                 @"001",@"wtzt",
                 @"10",@"limit",
                 @"1",@"offset",
                 @"",@"rqStart",
                 @"",@"rqEnd",
                 
                 nil];
    }
    [self sendRequest:@"queryAuctionWts4Move" withVersion:@"v10" withParam:param withOkBack:@selector(queryAuctionWts4MoveOk:) withFailedBack:@selector(queryAuctionWts4MoveFailed:)];
    
    
}
- (void)queryAuctionWts4MoveOk:(NSString*)result{
    
    id data = [result JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalOkData:finalData withKey:kResBidListData];
}
- (void)queryAuctionWts4MoveFailed:(NSString*)error{
    
    [self sendFinalFailedData:error withKey:kResBidListData];
}

- (void)queryAuctionPpInfo4Move:(NSDictionary*)param{

    /*
     hydm	会员代码
     limit	数据条数默认10条
     offset	第几页
     
     */
    param = [NSDictionary dictionaryWithObjectsAndKeys:
             @"001",@"hydm",
             @"10",@"id",
             //@"1",@"offset",
             nil];
    [self sendRequest:@"queryAuctionPpInfo4Move" withVersion:@"v10" withParam:param withOkBack:@selector(queryBidDetailOk:) withFailedBack:@selector(queryBidDetailFailed:)];
}
- (void)queryBidDetailOk:(NSString*)result{

    id data = [result JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalOkData:finalData withKey:kResBidItemData];
}
- (void)queryBidDetailFailed:(NSString*)error{

    [self sendFinalFailedData:error withKey:kResBidItemData];
}

- (void)getAuctionWtInfo:(NSDictionary*)param{

    /*
     hydm	会员代码
     limit	数据条数默认10条
     offset	第几页
     
     */
    if(param == nil){
    param = [NSDictionary dictionaryWithObjectsAndKeys:
             @"001",@"wtid",
             //@"10",@"id",
             //@"1",@"offset",
             nil];
    }
    [self sendRequest:@"getAuctionWtInfo" withVersion:@"v10" withParam:param withOkBack:@selector(getAuctionWtInfoOk:) withFailedBack:@selector(getAuctionWtInfoFailed:)];
}
- (void)getAuctionWtInfoOk:(NSString*)result{
    
    id data = [result JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalOkData:finalData withKey:kResBidItemData];
}
- (void)getAuctionWtInfoFailed:(NSString*)error{
    
    [self sendFinalFailedData:error withKey:kResBidItemData];
}
#pragma mark -
#pragma mark agreement 

- (void)showAgreement4Move:(NSDictionary*)param{
    
    /*
     接口参数	参数名称
     wtid	场次号
     hydm	会员代码
     *
     */
    if(param == nil){
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"001",@"hydm",
                 @"",@"wtid",
                 
                 nil];
    }
    [self sendRequest:@"showAgreement4Move" withVersion:@"v10" withParam:param withOkBack:@selector(showAgreement4MoveOk:) withFailedBack:@selector(showAgreement4MoveFailed:)];
}
- (void)showAgreement4MoveOk:(NSString*)result{
    
    id data = [result JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalOkData:finalData withKey:kResBidAgreementData];
}
- (void)showAgreement4MoveFailed:(NSString*)error{
    
    [self sendFinalFailedData:error withKey:kResBidAgreementData];
}
- (void)joinBuy4Move:(NSDictionary*)param{
    
    /*
     wtid	场次号
     hydm	会员代码
     czy	操作员代码
     *
     */
    if(param == nil){
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"001",@"hydm",
                 @"",@"wtid",
                 @"",@"czy",
                 nil];
    }
    [self sendRequest:@"joinBuy4Move" withVersion:@"v10" withParam:param withOkBack:@selector(joinBuy4MoveOk:) withFailedBack:@selector(joinBuy4MoveFailed:)];
}
- (void)joinBuy4MoveOk:(NSString*)result{
    
    id data = [result JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalOkData:finalData withKey:kResBidAgreeAction];
}
- (void)joinBuy4MoveFailed:(NSString*)error{
    
    [self sendFinalFailedData:error withKey:kResBidAgreeAction];
}
#pragma mark -
#pragma mark user

- (void)getAccountInfo:(NSDictionary*)param{
    
    /*
     *
     */
    if(param == nil){
    param = [NSDictionary dictionaryWithObjectsAndKeys:
             @"001",@"hydm",
             nil];
    }
    [self sendRequest:@"getAccountInfo" withVersion:@"v10" withParam:param withOkBack:@selector(getAccountInfoOk:) withFailedBack:@selector(getAccountInfoFailed:)];
}
- (void)getAccountInfoOk:(NSString*)result{
    
    id data = [result JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalOkData:finalData withKey:kCarUserInfo];

}
- (void)getAccountInfoFailed:(NSString*)error{
    id data = [error JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalFailedData:finalData withKey:kCarUserInfo];
}

- (void)getOrderList:(NSDictionary*)param{

    /*
     *
     */
    if(param == nil){
    param = [NSDictionary dictionaryWithObjectsAndKeys:
             @"001",@"hydm",
             @"10",@"limit",
             @"1",@"offset",
             nil];
    }
    [self sendRequest:@"getOrderList" withVersion:@"v10" withParam:param withOkBack:@selector(getOrderListOk:) withFailedBack:@selector(getOrderListFailed:)];

}
- (void)getOrderListOk:(NSString*)result{
    
}
- (void)getOrderListFailed:(NSString*)error{
    
}
- (void)getOrderDetail:(NSDictionary*)param{
    if(param == nil){
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"001",@"orderId",
                 nil];
    }
    [self sendRequest:@"getOrderDetail" withVersion:@"v10" withParam:param withOkBack:@selector(getOrderDetailOk:) withFailedBack:@selector(getOrderDetailFailed:)];
    
}
- (void)getOrderDetailOk:(NSString*)result{

}
- (void)getOrderDetailFailed:(NSString*)error{
    
}
@end
