//
//  JQHTTPSConnect.m
//  bsteelPay
//
//  Created by haifeng on 13-6-18.
//  Copyright (c) 2013年 wangxuhua. All rights reserved.
//

#import "JQHTTPSConnect.h"
#import "jqLoading.h"
#import "jqAlertCenter.h"
#import "jqEncode.h"
#import "AppDelegate.h"

@implementation JQHTTPSConnect
@synthesize delegate;
@synthesize progress;
@synthesize URLRequest;
@synthesize tag;
@synthesize debug;
@synthesize progressMessage;
@synthesize responseData;
@synthesize error;
@synthesize decode;
@synthesize finishSelector, failSelector;

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
        NSLog(@"JQHTTPSConnect-debug sendData:%@", data);
    }
    
    if (progress) {
        if (progressMessage == nil) {
            loading=[[jqLoading alloc]initWithRequest:nil];
        } else {
            loading=[[jqLoading alloc]initWithRequest:nil andMessage:progressMessage];
        }
        AppDelegate* app=(AppDelegate*)[[UIApplication sharedApplication]delegate];
        [loading showInView:app.window];
    }
    
    [URLRequest setTimeoutInterval:30.0];
    [URLRequest setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    [URLRequest setHTTPMethod:@"POST"];
    [URLRequest addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    if (connection!=nil) {
        [connection release];
        connection = nil;
        [recvData release];
        recvData = nil;
    }
    connection = [[NSURLConnection alloc]initWithRequest:URLRequest delegate:self startImmediately:YES];
    
    recvData =[[NSMutableData alloc]init];
}

-(void)cancelConnect
{
    [connection cancel];
}

//初始化
-(id)initWithURL:(NSURL *)newURL{
    self=[super init];
    if (self) {
        URLRequest = [[NSMutableURLRequest alloc]initWithURL:newURL];
    }
    return self;
}

//设置URL
-(void)setURL:(NSURL *)aURL
{
    [URLRequest setURL:aURL];
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
    [URLRequest addValue:value forHTTPHeaderField:header];
}

-(void)doFinishCallBack{
    if (delegate &&[delegate respondsToSelector:finishSelector]) {
        [delegate performSelector:finishSelector withObject:self];
    }
}

-(void)doFailCallBack{
    if (delegate &&[delegate respondsToSelector:failSelector]) {
        [delegate performSelector:failSelector withObject:self];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    SecTrustRef trust = challenge.protectionSpace.serverTrust;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:CERNAME ofType:@"cer"];
    
    NSData *certData =[[NSData alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:CERNAME ofType:@"cer"]];
    SecCertificateRef cert = SecCertificateCreateWithData(NULL, (CFDataRef)certData);
    
    CFArrayRef certArrayRef = CFArrayCreate(NULL, (void *)&cert, 1, NULL);
    
    SecTrustSetAnchorCertificates(trust, certArrayRef);
    
    OSStatus status;
    
    SecTrustResultType result = kSecTrustResultFatalTrustFailure;
    
    status = SecTrustEvaluate(trust, &result);
    
    if (status == errSecSuccess && (result==kSecTrustResultConfirm || result == kSecTrustResultUnspecified || result == kSecTrustResultProceed)) {
        
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    }
    else {
        
        NSLog(@"验证证书失败: %lu", status);
        [challenge.sender cancelAuthenticationChallenge:challenge];
    }
}
- (BOOL)connection:(NSURLConnection *)conn canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return [protectionSpace.authenticationMethod isEqualToString: NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)conn didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *) response;
    
    if ((httpResponse.statusCode / 100) != 2) {
        NSLog(@"连接失败");
    }
}

- (void)connection:(NSURLConnection *)conn didReceiveData:(NSData *)data
{
    [recvData appendData:data];
}

- (void)connection:(NSURLConnection *)conn didFailWithError:(NSError *)Error
{
    if (loading) {
        [self removeLoading];
    }
    switch (Error.code) {
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
        NSLog(@"JQHTTPSConnect-debug error:%@", Error);
    }
    self.error = Error;
    [self performSelectorOnMainThread:@selector(doFailCallBack) withObject:nil waitUntilDone:YES];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)conn
{
    if (loading) {
        [self performSelectorOnMainThread:@selector(removeLoading) withObject:nil waitUntilDone:YES];
    }
    NSData* respData= recvData;
    NSString *result=[[NSString alloc]initWithData:respData encoding:NSUTF8StringEncoding];
    
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
    if (decode) {
        jqEncode *encode = [[jqEncode alloc] init];
        result = [encode decodeString:result];
        [encode release];
    }
    
    if (debug) {
        NSLog(@"JQHTTPSConnect-debug responseData:%@", result);
    }
    NSString* filterStr=[self filterSpecialChat:result];
    self.responseData = filterStr;
    
    [self performSelectorOnMainThread:@selector(doFinishCallBack) withObject:nil waitUntilDone:YES];
}

-(void)dealloc{
    if (loading) {
        [loading release],loading=nil;
    }
    if (progressMessage!=nil) {
        progressMessage=nil;
    }
    if (responseData!=nil) {
        [responseData release];
        responseData=nil;
    }
    if (error!=nil) {
        error=nil;
    }
    if (connection) {
        [connection release];
        connection=nil;
    }
    if (URLRequest) {
        [URLRequest release];
        URLRequest=nil;
    }
    if (recvData) {
        [recvData release];
        recvData=nil;
    }
    [super dealloc];
}

@end
