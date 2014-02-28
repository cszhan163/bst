//
//  JQNetworkHelper.h
//  jqConnectTest
//
//  Created by haifeng on 13-1-14.
//  Copyright (c) 2013年 haifeng. All rights reserved.
//
/* 使用时加载以下文件和Framework
 ASI工具包
 CFNetwork.framework
 SystemConfiguration.framework
 MobileCoreServices.framework
 libz.1.2.5.dylib
*/
#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

//#define CERNAME @"bchemMW"

@class jqLoading;

@interface JQNetworkHelper : NSObject
{
@protected
    id JQNetworkHelperDelegate;
@private
    BOOL progress;
    ASIFormDataRequest *request;
    NSInteger tag;
    BOOL debug;
    jqLoading *loading;
    SEL failSelector;
    SEL finishSelector;
    NSString *progressMessage;
    NSString *responseData;
    NSError *error;
    BOOL decode;
    NSString *sendData;
}
@property(nonatomic, retain)NSString *sendData;
@property(nonatomic,assign)SEL failSelector, finishSelector;
//属性，设置是否显示进度条
@property(nonatomic,assign)BOOL progress;
//是否解密
@property(nonatomic,assign)BOOL decode;
//属性，只读，便于调用ASIFormDataRequest原始的属性
@property(nonatomic,readonly)ASIFormDataRequest* request;
//属性，当有多个网络请求时使用该值区分
@property(nonatomic,assign)NSInteger tag;
//属性，使用该实例的代理
@property(nonatomic,assign)id JQNetworkHelperDelegate;
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
//检查当前网络是否可用
+(BOOL)isExistenceNetwork;
//初始化
-(id)initWithURL:(NSURL *)newURL;
//设置URL
-(void)setURL:(NSURL*)aURL;
//设置进度条上的提示信息，不实现该方法则显示默认的提示信息
-(void)setProgressMessage:(NSString*)msg;
//设置头信息
-(void)addRequestHeader:(NSString *)header value:(NSString*)value;

@end
