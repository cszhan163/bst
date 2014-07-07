//
//  AppDelegate.m
//  BSTell
//
//  Created by cszhan on 14-1-30.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "AppDelegate.h"
#import "AppMainUIViewManage.h"
#import "CarServiceNetDataMgr.h"

#import "JQConnect_bsteelPay.h"

#import "KeychainItemWrapper.h"

#import "BidAdjustAlertView.h"

#import "MobClick.h"

@implementation AppDelegate

- (void)didClickCancelButton:(id)sender{

     [AppSetting setFirstOpen:NO];
    [sender removeFromSuperview];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
  
    [MobClick  startWithAppkey:@"53aee53b56240b79860dbaa0"];
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    AppMainUIViewManage *appMg = [AppMainUIViewManage getSingleTone];
    appMg.window = self.window;
    
  
    
    [appMg addMainViewUI];
//    KeychainItemWrapper *keyChainItem =  [[KeychainItemWrapper alloc] initWithIdentifier:@"cszhan" accessGroup:@"test"];
//    [keyChainItem setObject:@"1000" forKey:kSecValueData];
//    
//    KeychainItemWrapper *keyChainItem2 = [[KeychainItemWrapper alloc] initWithIdentifier:@"cszhan" accessGroup:@"test"];
//    id value = [keyChainItem2 objectForKey:kSecValueData];
    //[self startLoginRequest];
    
    //[self startLoginRequest];
    if([AppSetting getFirstOpen]){
        
        BidAdjustAlertView *firstAlertView = [[BidAdjustAlertView alloc]initWithAlertFirstViewFrame:CGRectMake(0.f,0.f,kDeviceScreenWidth,kDeviceScreenHeight)];
        firstAlertView.delegate = self;
        [self.window addSubview:firstAlertView];
       
        
    }
    if([AppSetting getLoginUserId]&&![[AppSetting getLoginUserId]isEqualToString:@""]){
        //[ZCSNotficationMgr postMSG: obj:<#(id)#>]
        
    }
    else
    {
        [self performSelector:@selector(needLogin) withObject:nil afterDelay:0.f];
    }
    return YES;
}
- (void)needLogin{
    [[self class] needUserRelogin];
}
+ (void)needUserRelogin
{
    [ZCSNotficationMgr postMSG:kUserDidLogOut obj:nil];
    [ZCSNotficationMgr postMSG:kUserDidLoginCancel obj:nil];
}

//发起登录请求
-(void)startLoginRequest
{
    JQConnect_bsteelPay *connect = [[JQConnect_bsteelPay alloc] initWithDelegate:self successCallBack:@selector(callBackConnect:) failedCallBack:@selector(callBackFail:) andMethodName:@"HgbLogin_v1"];
    [connect addParam:@"shanghai_1" forKey:@"umcLoginName"];
    [connect addParam:@"123" forKey:@"loginPassword"];
    [connect addParam:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:@"version"];
    [connect sendRequest];
    
    /*
    if (![self.window isKeyWindow]) {
        loading =[[jqLoading alloc]initWithRequest:connect.jqConnect.request andMessage:@"登录中"];
        [loading showInView:self.view];
    }
    */
    // Do any additional setup after loading the view from its nib.
}

-(void)callBackConnect:(NSString *)responseData
{
    CarServiceNetDataMgr *carServiceNetDataMgr = [CarServiceNetDataMgr getSingleTone];
    
    //[carServiceNetDataMgr  queryBidPubmsg4Move:nil];
    //[carServiceNetDataMgr  querySitePubmsg4Move:nil];
    //[carServiceNetDataMgr queryAuctionPps4Move:nil];
    //[carServiceNetDataMgr queryAuctionPpInfo4Move:nil];
    //[carServiceNetDataMgr getAccountInfo:nil];
    //[carServiceNetDataMgr getOrderList:nil];
    //[carServiceNetDataMgr getOrderDetail:nil];
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"结果"
//                                                    message:responseData
//                                                   delegate:self
//                                          cancelButtonTitle:@"确定"
//                                          otherButtonTitles:nil];
//    [alert show];
//    [alert release];
//    if (loading!=nil) {
//        [loading removeFromSuperview];
//        [loading release];
//        loading = nil;
//    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
