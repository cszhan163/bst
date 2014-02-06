//
//  JQConnect_bsteelPay.m
//  bsteelPay
//
//  Created by haifeng on 13-5-23.
//  Copyright (c) 2013年 wangxuhua. All rights reserved.
//

#import "JQConnect_bsteelPay.h"
#import "global.h"
#import "jqEncode.h"
#import "SFHFKeychainUtils.h"
#import "AppDelegate.h"
#import "JSON.h"

@implementation JQConnect_bsteelPay
@synthesize postString;
@synthesize appCode;
@synthesize MethodString;
@synthesize compressdata;
@synthesize encryptdata;
@synthesize progress;
@synthesize encodeYN;
@synthesize jqConnect;

-(id)init{
    self=[super init];
    if (self) {
//        compressdata = YES;
//        encryptdata = YES;
        compressdata = NO;
        encryptdata = YES;
        progress = YES;
        encodeYN = YES;
        isHTTPS = YES;
        postString = [[NSMutableString alloc] init];
        count = 1;
    }
    return self;
}

-(id)initWithDelegate:(id)delegate successCallBack:(SEL)didFinishSelector failedCallBack:(SEL)didFailSelector andMethodName:(NSString *)methodName
{
    self=[self init];
    NSURL *URL;
    if (isHTTPS) {
        URL=[NSURL URLWithString:[@"https://211.144.193.11:8000/demo/" stringByAppendingString:methodName]];
    } else {
        URL=[NSURL URLWithString:[@"http://211.144.193.11:8000/demo/" stringByAppendingString:methodName]];
        //NSURL *URL=[NSURL URLWithString:[@"http://192.168.0.106:8000/" stringByAppendingString:methodName]];
    }
    
    MethodString = methodName;
    obj = delegate;
    failSelector = didFailSelector;
    finishSelector = didFinishSelector;
    
    if (isHTTPS) {
        connect = [[JQHTTPSConnect alloc] initWithURL:URL];
        
        connect.delegate=self;
        [connect setSuccessCallBack:@selector(doWhileFinishHTTPS:)];
        [connect setFailedCallBack:@selector(doWhileFailHTTPS:)];
        
        //    jqConnect.JQNetworkHelperDelegate=delegate;
        //    [jqConnect setSuccessCallBack:didFinishSelector];
        //    [jqConnect setFailedCallBack:didFailSelector];
        
        connect.progress = YES;                                  //是否显示连接中文字
        [connect setProgressMessage:@"loading..."];              //连接中文字提示
        connect.debug = YES;                                     //开启debug模式，可看到一些log
        connect.decode = YES;
        
        if (![methodName isEqualToString:@"login"]) {
            if ([methodName isEqualToString:@"logout"]) {
                [connect addRequestHeader:@"close" value:@"Connection"];
                [global getGlobal].sessionID = @"";
            }
            [connect addRequestHeader:@"xmas-session" value:[global getGlobal].sessionID];
        }
    } else {
        jqConnect = [[JQNetworkHelper alloc] initWithURL:URL];
        
        jqConnect.JQNetworkHelperDelegate=self;
        [jqConnect setSuccessCallBack:@selector(doWhileFinish:)];
        [jqConnect setFailedCallBack:@selector(doWhileFail:)];
        
        //    jqConnect.JQNetworkHelperDelegate=delegate;
        //    [jqConnect setSuccessCallBack:didFinishSelector];
        //    [jqConnect setFailedCallBack:didFailSelector];
        
        jqConnect.progress = YES;                                  //是否显示连接中文字
        [jqConnect setProgressMessage:@"loading..."];              //连接中文字提示
        jqConnect.debug = YES;                                     //开启debug模式，可看到一些log
        jqConnect.decode = YES;
        
        if (![methodName isEqualToString:@"login"]) {
            if ([methodName isEqualToString:@"logout"]) {
                [jqConnect addRequestHeader:@"close" value:@"Connection"];
                [global getGlobal].sessionID = @"";
            }
            [jqConnect addRequestHeader:@"xmas-session" value:[global getGlobal].sessionID];
        }
    }
    
    return self;
}

-(void)addParam:(NSString*)value forKey:(NSString*)key
{
    if (postString.length==0) {
        [postString appendString:@"{"];
        
        [postString appendFormat:@"\"%@\":\"%@\"", key , value];
    } else {
        [postString appendFormat:@",\"%@\":\"%@\"", key , value];
    }
}

-(void)sendRequest
{
    if (isHTTPS) {
        connect.progress = progress;
        [connect send:[self getPostString]];
    } else {
        jqConnect.progress = progress;
        [jqConnect send:[self getPostString]];
    }
}

-(void)cancelConnect
{
    if (isHTTPS) {
        [connect cancelConnect];
        [self release];
    }
}

-(void)doWhileFinishHTTPS:(JQHTTPSConnect *)conn
{
    if ([conn.responseData rangeOfString:@"SessionNotFound"].length>0) {
        [self AutoLogin];
    } else {
        if (obj&&[obj respondsToSelector:finishSelector]) {
            [obj performSelector:finishSelector withObject:conn.responseData];
            //[self release];
        }
    }
}

-(void)doWhileFailHTTPS:(JQHTTPSConnect *)conn
{
    if (obj &&[obj respondsToSelector:failSelector]) {
        [obj performSelector:failSelector withObject:conn.responseData];
        [self release];
    }
}

-(void)AutoLogin
{
    NSString *userName = [SFHFKeychainUtils getPasswordForUsername:@"UserID" andServiceName:@"Login" error:nil];
    NSString *passWord = [SFHFKeychainUtils getPasswordForUsername:@"Password" andServiceName:@"Login" error:nil];
    
        if (userName!=nil&&passWord!=nil) {
            if (isHTTPS) {
                failedHTTPSConnect = connect;
                NSURL *URL=[NSURL URLWithString:@"https://211.144.193.11/demo/login_v10"];
                connect = [[JQHTTPSConnect alloc] initWithURL:URL];
                connect.delegate=self;
                [connect setSuccessCallBack:@selector(autoLoginCallBack:)];
                [connect setFailedCallBack:@selector(autoLoginFail:)];
                connect.progress = YES;                                  //是否显示连接中文字
                connect.debug = YES;                                     //开启debug模式，可看到一些log
                [connect setProgressMessage:@"loading..."];
                connect.decode = YES;
                [postString release];
                postString = [[NSMutableString alloc] init];
                [self addParam:userName forKey:@"username"];
                [self addParam:passWord forKey:@"password"];
                [self addParam:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:@"version"];
                [connect send:[self getPostString]];
            }
//            else {
//                JQNetworkHelper *jqConnect = [[JQNetworkHelper alloc] initWithURL:failedConnect.request.url];
//                jqConnect.JQNetworkHelperDelegate=failedConnect.JQNetworkHelperDelegate;
//                [jqConnect setSuccessCallBack:failedConnect.finishSelector];
//                [jqConnect setFailedCallBack:failedConnect.failSelector];
//                jqConnect.progress = YES;
//                jqConnect.debug = YES;
//                jqConnect.decode = YES;
//                
//                [jqConnect addRequestHeader:@"xmas-session" value:[global getGlobal].sessionID];
//                
//                NSString *postData = [[NSString alloc] initWithData:failedConnect.request.postBody encoding:NSUTF8StringEncoding];
//                [jqConnect send:failedConnect.sendData];
//                [postData release];
//            }
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"由于您长时间未操作，请重新登录"
                                                            message:@""
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            alert.tag = 101;
            [alert show];
            [alert release];
        }
}

-(void)autoLoginCallBack:(JQHTTPSConnect *)conn
{
    NSDictionary *dic = [conn.responseData JSONValue];
    if ([dic objectForKey:@"dataList"]!=nil&&[[dic objectForKey:@"dataList"] count]!=0) {
        NSDictionary *tempDic = [[dic objectForKey:@"dataList"] objectAtIndex:0];
        if ([[tempDic objectForKey:@"retcode"] isEqualToString:@"2"]) {
            [global getGlobal].sessionID = [dic objectForKey:@"sessionid"];
            [global getGlobal].companyName = [tempDic objectForKey:@"details"];
            [self setFailedConnect];
            count++;
        } else {
            [SFHFKeychainUtils deleteItemForUsername:@"UserID" andServiceName:@"Login" error:nil];
            [SFHFKeychainUtils deleteItemForUsername:@"Password" andServiceName:@"Login" error:nil];
            [SFHFKeychainUtils deleteItemForUsername:@"PIN" andServiceName:@"Login" error:nil];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"账号密码验证失败，请重新登录。"
                                                            message:@""
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            alert.tag = 101;
            [alert show];
            [alert release];
        }
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络连接失败"
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:@"重试"
                                              otherButtonTitles:@"取消", nil];
        alert.tag = 100;
        [alert show];
        [alert release];
    }
}

-(void)setFailedConnect
{
    if (isHTTPS) {
        [jqConnect addRequestHeader:@"xmas-session" value:[global getGlobal].sessionID];
        NSString *body = [[NSString alloc]initWithData:failedHTTPSConnect.URLRequest.HTTPBody encoding:NSUTF8StringEncoding];
        [failedHTTPSConnect send:body];
        [body release];
        [failedHTTPSConnect release];
        failedHTTPSConnect = nil;
    }
}

-(void)autoLoginFail:(JQHTTPSConnect *)conn
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络连接失败"
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:@"重试"
                                          otherButtonTitles:@"取消", nil];
    alert.tag = 100;
    [alert show];
    [alert release];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==100) {
        if (buttonIndex==0) {
            [self AutoLogin];
        }
    } else if (alertView.tag==101) {
        [[AppDelegate shareApp] setLoginView];
        [self release];
    }
}

-(void)doWhileFinish:(JQNetworkHelper *)conn
{
    if ([conn.responseData rangeOfString:@"SessionNotFound"].length>0) {
    //if ([conn.responseData rangeOfString:@"操作成功"].length>0&&count==1) {
        [self AutoLogin];
    } else {
        if (obj &&[obj respondsToSelector:finishSelector]) {
            [obj performSelector:finishSelector withObject:conn.responseData];
            [self release];
        }
    }
}

-(void)doWhileFail:(JQNetworkHelper *)conn
{
    if (obj &&[obj respondsToSelector:failSelector]) {
        [obj performSelector:failSelector withObject:conn.responseData];
        [self release];
    }
}

-(NSString *)getPostString
{
    NSMutableString *backString=[NSMutableString stringWithString:@"xmas-json={\"biz\":"];
    
    if (encodeYN) {
        [backString appendString:@"\""];
        
        if (postString.length!=0) {
            [postString appendString:@"}"];
            NSLog(@"%@", postString);
            jqEncode *encode = [[jqEncode alloc] init];
            NSString *encodeString = [encode encodeString:postString];
            [backString appendString:[encodeString stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"]];
            [encode release];
        }
        [backString appendString:@"\""];
    } else {
        [postString appendString:@"}"];
        [backString appendString:postString];
    }
    
    [backString appendString:@",\"sys\":{"];
    if (appCode != NULL) {
        [backString appendString:[NSString stringWithFormat:@"\"appcode\":\"%@\",",appCode]];
    }else{
        [backString appendString:@"\"appcode\":\"\","];
    }
    if (compressdata) {
        [backString appendString:@"\"compressdata\":\"true\","];
    }else{
        [backString appendString:@"\"compressdata\":\"false\","];
    }
    
    if (encryptdata) {
        [backString appendString:@"\"encryptdata\":\"true\","];
    }else{
        [backString appendString:@"\"encryptdata\":\"false\","];
    }
    
    [backString appendString:@"\"keycode\":\"pkznf6585535555660675056396297413\","];
    
    if (MethodString) {
        [backString appendString: [NSString stringWithFormat:@"\"method\":\"%@\"",MethodString]];
    }else{
        [backString appendString:@"\"method\":\"\""];
    }
    [backString appendString:@"}}"];
    
    return backString;
}

-(void)dealloc
{
    if (jqConnect!=nil) {
        [jqConnect release];
        jqConnect = nil;
    }
    if (failedConnect!=nil) {
        [failedConnect release];
        failedConnect = nil;
    }
    if (connect!=nil) {
        [connect release];
        connect = nil;
    }
    if (postString!=nil) {
        [postString release];
        postString = nil;
    }
    if (MethodString != nil) {
        [MethodString release];
        MethodString = nil;
    }
    if (appCode != nil) {
        [appCode release];
        appCode = nil;
    }
    [super dealloc];
}

@end
