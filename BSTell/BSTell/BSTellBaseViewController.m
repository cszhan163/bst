//
//  BSTellBaseViewController.m
//  BSTell
//
//  Created by cszhan on 14-1-31.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "BSTellBaseViewController.h"
#import "CardShopLoginViewController.h"
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
- (void)addObservers{
    [super addObservers];
    [ZCSNotficationMgr addObserver:self call:@selector(didUserLogin:) msgName:kUserDidLoginOk];
    [ZCSNotficationMgr addObserver:self call:@selector(didUserLogout:) msgName:kUserDidLogOut];
    [ZCSNotficationMgr addObserver:self call:@selector(didUserLoginCancel:) msgName:kUserDidLoginCancel];
}

- (void)didUserLogin:(NSNotification*)ntf{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didUserLogout:(NSNotification*)ntf{
    
}
- (void)didUserLoginCancel:(NSNotification*)ntf{
    //[self.navigationController popViewControllerAnimated:YES];
    [ZCSNotficationMgr postMSG:kNavTabItemMSG obj:[NSNumber numberWithInt:2]];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(![self needCheckLogin]){
            [self shouldLoadData];
    }
    if([self respondsToSelector:@selector(startReflushjTimer)])
        [self startReflushjTimer];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    NSString *usrId = [AppSetting getLoginUserId];
    if(usrId)
    {
        NSDictionary *usrData = [AppSetting getLoginUserData:usrId];
        self.userId = [usrData objectForKey:@"hydm"];
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if([self respondsToSelector:@selector(stopReflushTimer)])
        [self stopReflushTimer];
}
- (BOOL)needCheckLogin{

    NSString *usrId = [AppSetting getLoginUserId];
    if(self.needLogin &&(!usrId || [usrId isEqualToString:@""])){
        /*
        [ZCSNotficationMgr postMSG:kNavTabItemMSG obj:[NSNumber numberWithInt:2]];
        [ZCSNotficationMgr postMSG:kNeedUserLoginMSG obj:nil];
         */
        [self.navigationController popToRootViewControllerAnimated:NO];
        CardShopLoginViewController *noteListVc = [[CardShopLoginViewController alloc]init];
        //noteListVc.type = 1;
        //[noteListVc setNavgationBarTitle:[sender titleLabel].text];
        noteListVc.view.frame = CGRectMake(0.f,20.f, kDeviceScreenWidth, kDeviceScreenHeight);
#if 1
        [self.navigationController pushViewController:noteListVc  animated:NO];
#else
        [ZCSNotficationMgr postMSG:kPresentModelViewController  obj:noteListVc];
        
#endif
        SafeRelease(noteListVc);

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


@end
