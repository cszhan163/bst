//
//  JQNetworkHelper.m
//  jqConnectTest
//
//  Created by haifeng on 13-1-14.
//  Copyright (c) 2013年 haifeng. All rights reserved.
//

#import "JQNetworkHelper.h"
#import "jqLoading.h"
#import "Reachability.h"
#import "jqAlertCenter.h"
#import "AppDelegate.h"
#import "jqEncode.h"

@interface JQNetworkHelper (){
    
}
-(void)doWhileFail:(ASIFormDataRequest*)req;
-(void)doWhileFinish:(ASIFormDataRequest*)req;
@end

@implementation JQNetworkHelper
@synthesize JQNetworkHelperDelegate;
@synthesize progress;
@synthesize request;
@synthesize tag;
@synthesize debug;
@synthesize progressMessage;
@synthesize responseData;
@synthesize error;
@synthesize decode;
@synthesize finishSelector, failSelector;
@synthesize sendData;

//检查当前网络是否可用；
+(BOOL)isExistenceNetwork
{
    BOOL isExistenceNetwork;
	if([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] ==NotReachable &&
       [[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable)
    {
        isExistenceNetwork=NO;
    }else{
        isExistenceNetwork=YES;
    }
	return isExistenceNetwork;
}

//设置连接失败时的回调函数
-(void)setFailedCallBack:(SEL)sel
{
    failSelector = sel;
}
//设置连接成功时的回调函数
-(void)setSuccessCallBack:(SEL)sel
{
    finishSelector = sel;
}

//设置发送的内容，参数为字符串, 启动异步请求；
-(void)send:(NSString*)data
{
    if (debug) {
        NSLog(@"JQNetworkHelper-debug sendData:%@", data);
    }
    
    sendData = data;
    if ([JQNetworkHelper isExistenceNetwork]) {
        if (progress) {
            if (progressMessage == nil) {
                loading=[[jqLoading alloc]initWithRequest:request];
            } else {
                loading=[[jqLoading alloc]initWithRequest:request andMessage:progressMessage];
            }
            AppDelegate* app=(AppDelegate*)[[UIApplication sharedApplication]delegate];
            [loading showInView:app.window];
        }
        [request appendPostData:[data dataUsingEncoding:NSUTF8StringEncoding]];
        [request setTimeOutSeconds:30];
        request.delegate=self;
        [request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
        [request setDidFailSelector:@selector(doWhileFail:)];
        [request setDidFinishSelector:@selector(doWhileFinish:)];
        [request startAsynchronous];
    } else {
        [self performSelectorOnMainThread:@selector(doFailCallBack) withObject:nil waitUntilDone:YES];
    }
}

-(id)init{
    self=[super init];
    if (self) {
        request=[[ASIFormDataRequest alloc]init];
        decode = NO;
    }
    return self;
}

//初始化
-(id)initWithURL:(NSURL *)newURL{
    self=[super init];
    if (self) {
        request=[[ASIFormDataRequest alloc]initWithURL:newURL];
    }
    return self;
}

//设置URL
-(void)setURL:(NSURL *)aURL
{
    [request setURL:aURL];
}

-(void)removeLoading{
    [loading removeFromSuperview];
    [loading release];
    loading = nil;
}

//设置进度条上的提示信息，不实现该方法则显示默认的提示信息；
-(void)setProgressMessage:(NSString*)msg
{
    progressMessage = msg;
}

-(void)doWhileFail:(ASIFormDataRequest*)req
{
    if (loading) {
        [self removeLoading];
    }
    switch (req.error.code) {
        case 1:
            [jqAlertCenter showAlertWithTag:0 forType:24 andDelegate:nil];
            break;
        case 2:
            [jqAlertCenter showAlertWithTag:0 forType:7 andDelegate:nil];
            break;
        default:
            break;
    }
    if (debug) {
        NSLog(@"JQNetworkHelper-debug error:%@", req.error);
    }
    self.error = req.error;
    [self performSelectorOnMainThread:@selector(doFailCallBack) withObject:nil waitUntilDone:YES];
}

-(void)doWhileFinish:(ASIFormDataRequest*)req
{
    if (loading) {
        [self performSelectorOnMainThread:@selector(removeLoading) withObject:nil waitUntilDone:YES];
    }
    
    NSData* respData=[req responseData];
    
    NSString *result=[[NSString alloc]initWithData:respData encoding:NSUTF8StringEncoding];
    if (decode) {
        jqEncode *encode = [[jqEncode alloc] init];
        result = [encode decodeString:result];
        [encode release];
    }
    
    if (!result) {
        [result release];
        NSStringEncoding enc=CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        result=[[NSString alloc] initWithData:respData encoding:enc];
    }
    if (!result) {
        [result release];
        result=[[NSString alloc] initWithData:respData encoding:NSASCIIStringEncoding];
    }
    if (!result) {
        [self release];
        return;
    }
    if (debug) {
        NSLog(@"JQNetworkHelper-debug responseData:%@", result);
    }
    NSString* filterStr=[self filterSpecialChat:result];
    self.responseData = filterStr;
    
    [self performSelectorOnMainThread:@selector(doFinishCallBack) withObject:nil waitUntilDone:YES];
    
}

-(NSString*)filterSpecialChat:(NSString *)src{
    NSMutableString* ret=[[NSMutableString alloc]initWithString:src];
    //    去掉制表符
    NSRange range=[ret rangeOfString:@"\t"];
    while (range.location!=NSNotFound) {
        [ret replaceCharactersInRange:range withString:@""];
        range=[ret rangeOfString:@"\t"];
    }
    //    去掉回车符
    NSRange newlineRange=[ret rangeOfString:@"\r"];
    while (newlineRange.location!=NSNotFound) {
        [ret replaceCharactersInRange:newlineRange withString:@""];
        newlineRange=[ret rangeOfString:@"\r"];
    }
    //  去掉换行符
    NSRange enterRange=[ret rangeOfString:@"\n"];
    while (enterRange.location!=NSNotFound) {
        [ret replaceCharactersInRange:enterRange withString:@""];
        enterRange=[ret rangeOfString:@"\n"];
    }
    //    去掉dle
    NSRange dleRange=[ret rangeOfString:@""];
    while (dleRange.location!=NSNotFound) {
        [ret replaceCharactersInRange:dleRange withString:@""];
        dleRange=[ret rangeOfString:@""];
    }
    return [ret autorelease];
}

-(void)addRequestHeader:(NSString *)header value:(NSString*)value
{
    [request addRequestHeader:header value:value];
}

-(void)doFinishCallBack{
    if (JQNetworkHelperDelegate &&[JQNetworkHelperDelegate respondsToSelector:finishSelector]) {
        [JQNetworkHelperDelegate performSelector:finishSelector withObject:self];
    }
}

-(void)doFailCallBack{
    if (JQNetworkHelperDelegate &&[JQNetworkHelperDelegate respondsToSelector:failSelector]) {
        [JQNetworkHelperDelegate performSelector:failSelector withObject:self];
    }
}

-(void)dealloc{
    [request release];request=nil;
    if (loading) {
        [loading release],loading=nil;
    }
    if (progressMessage!=nil) {
        progressMessage=nil;
    }
    if (responseData!=nil) {
        responseData=nil;
    }
    if (error!=nil) {
        error=nil;
    }
    if (sendData) {
        sendData=nil;
    }
    [super dealloc];
}

@end
