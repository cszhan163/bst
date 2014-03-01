//
//  BSTellBaseViewController.m
//  BSTell
//
//  Created by cszhan on 14-1-31.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "BSTellBaseViewController.h"

@interface BSTellBaseViewController ()

@end

@implementation BSTellBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.userId = @"";
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self needCheckLogin];
    if([self respondsToSelector:@selector(startReflushjTimer)])
        [self startReflushjTimer];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if([self respondsToSelector:@selector(stopReflushTimer)])
        [self stopReflushTimer];
}
- (BOOL)needCheckLogin{

    NSString *usrId = [AppSetting getLoginUserId];
    if(self.needLogin &&(!usrId || [usrId isEqualToString:@""])){
        
        [ZCSNotficationMgr postMSG:kNavTabItemMSG obj:[NSNumber numberWithInt:2]];
        [ZCSNotficationMgr postMSG:kNeedUserLoginMSG obj:nil];
        return YES;
    }
    return NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    mainView.topBarView.backgroundColor = HexRGB(1, 159, 233);
    mainView.backgroundColor = HexRGB(239, 239, 241);
    self.delegate = self;
    if(![self needCheckLogin])
        [self shouldLoadData];
}
- (void)shouldLoadData{
   
    NSString *usrId = [AppSetting getLoginUserId];
    if(usrId){
        NSDictionary *usrData = [AppSetting getLoginUserData:usrId];
        self.userId = [usrData objectForKey:@"hydm"];
    }

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    NSString *usrId = [AppSetting getLoginUserId];
    if(usrId){
        NSDictionary *usrData = [AppSetting getLoginUserData:usrId];
        self.userId = [usrData objectForKey:@"hydm"];
    }
}

@end
