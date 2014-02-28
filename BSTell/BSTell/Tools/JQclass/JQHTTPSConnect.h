//
//  JQHTTPSConnect.h
//  bsteelPay
//
//  Created by haifeng on 13-6-18.
//  Copyright (c) 2013年 wangxuhua. All rights reserved.
//

#import <Foundation/Foundation.h>



@class jqLoading;
@interface JQHTTPSConnect : NSObject
{
    id delegate;
    BOOL progress;
    BOOL debug;
    jqLoading *loading;
    SEL failSelector;
    SEL finishSelector;
    NSString *progressMessage;
    NSString *responseData;
    NSError *error;
    BOOL decode;
    
    NSURLConnection* connection;
    NSMutableURLRequest *URLRequest;
    NSMutableData *recvData;
}
@property(nonatomic,assign)SEL failSelector, finishSelector;
//属性，设置是否显示进度条
@property(nonatomic,assign)BOOL progress;
//是否解密
@property(nonatomic,assign)BOOL decode;
//属性，只读，便于调用ASIFormDataRequest原始的属性
@property(nonatomic,readonly)NSMutableURLRequest *URLRequest;
//属性，当有多个网络请求时使用该值区分
@property(nonatomic,assign)NSInteger tag;
//属性，使用该实例的代理
@property(nonatomic,assign)id delegate;
//属性，是否开启调试模式
@property(nonatomic,assign)BOOL debug;
//进度条文字
@property (nonatomic,copy)NSString *progressMessage;
@property (nonatomic,copy)NSString *responseData;
@property (retain) NSError *error;
//设置连接失败时的回调函数
-(void)setFailedCallBack:(SEL)sel;
//设置连接成功时的回调函数
-(void)setSuccessCallBack:(SEL)sel;
//设置发送的内容，参数为字符串, 启动异步请求
-(void)send:(NSString*)data;
//初始化
-(id)initWithURL:(NSURL *)newURL;
//设置URL
-(void)setURL:(NSURL*)aURL;
//设置进度条上的提示信息，不实现该方法则显示默认的提示信息
-(void)setProgressMessage:(NSString*)msg;
//设置头信息
-(void)addRequestHeader:(NSString *)header value:(NSString*)value;

-(void)cancelConnect;
@end
