//
//  MyInfoViewController.m
//  BSTell
//
//  Created by cszhan on 14-1-30.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "MyInfoViewController.h"

#import "OrderListMainViewController.h"

#define kLeftTextPendingX  28.f
#define kLeftPendingX 190.f

#define USE_SPLIT 0

@interface MyInfoViewController (){

    UILabel *userNameLabel;
    UILabel *userAccountLabel;
    UILabel *userAvaiableLabel;
    UILabel *userLockLabel;
    UILabel *userAgreeLabel;
}
@end

@implementation MyInfoViewController
- (void)dealloc{
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.needLogin = YES;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    NSString *userNameId = [AppSetting getLoginUserId];
    if(userNameId && ![userNameId isEqual:@""])
    {
        NSDictionary *data = [AppSetting getLoginUserData:userNameId];
        userNameLabel.text = [data objectForKey:@"company"];
    }
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //[self  shouldLoadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setHiddenLeftBtn:YES];
    [self setHiddenRightBtn:YES];
    [self setNavgationBarTitle:@"我的信息"];
    CGFloat currY = kMBAppTopToolBarHeight+80.f;
    userNameLabel = [UIComUtil createLabelWithFont:[UIFont boldSystemFontOfSize:26] withTextColor:[UIColor blackColor] withText:@"模拟公司" withFrame:CGRectMake(kLeftTextPendingX,currY,300.f, 30.f)];
    userNameLabel.textAlignment = NSTextAlignmentLeft;

    [self.view addSubview:userNameLabel];
    SafeRelease(userNameLabel);
      currY = currY+50.f;
    
#if USE_SPLIT
    UIView *split = [UIComUtil createSplitViewWithFrame:CGRectMake(0.f,currY,kDeviceScreenWidth,2.f) withColor:[UIColor grayColor]];
    [self.view addSubview:split];
    SafeRelease(split);
#endif
    
    UIImageWithFileName(UIImage*image, @"word.png");
    
    UIImageView *accountView = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, currY,image.size.width/kScale, image.size.height/kScale)];
    accountView.image = image;
    [self.view addSubview: accountView];
    SafeRelease(accountView);
    accountView.frame = CGRectMake(0.f, currY, image.size.width/kScale, image.size.height/kScale);
    
    
    userAccountLabel = [UIComUtil createLabelWithFont:[UIFont boldSystemFontOfSize:16]
                                        withTextColor:HexRGB(0, 161, 231)
                                             withText:@"80,000.00"
                                            withFrame:CGRectMake(kLeftPendingX,currY+10.f,300.f, 30.f)];
    currY = currY+30.f;
    userAccountLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:userAccountLabel];
    SafeRelease(userAccountLabel);
    
    
    userAvaiableLabel = [UIComUtil createLabelWithFont:[UIFont boldSystemFontOfSize:16]
                                         withTextColor:HexRGB(12, 136, 6)
                                              withText:@"80,000.00"
                                             withFrame:CGRectMake(kLeftPendingX,currY+8.f,300.f, 30.f)];
    userAvaiableLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:userAvaiableLabel];
    SafeRelease(userAvaiableLabel);
    
    currY = currY+30.f;
    userLockLabel = [UIComUtil createLabelWithFont:[UIFont boldSystemFontOfSize:14]
                                     withTextColor:HexRGB(194, 11, 33)
                                          withText:@"0.00"
                                         withFrame:CGRectMake(kLeftPendingX,currY+6.f,300.f, 30.f)];
    userLockLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:userLockLabel];
    SafeRelease(userLockLabel);
    
    
    currY = currY+30.f;
    
#if USE_SPLIT
    split = [UIComUtil createSplitViewWithFrame:CGRectMake(0.f,currY,kDeviceScreenWidth,2.f) withColor:[UIColor grayColor]];
    [self.view addSubview:split];
    SafeRelease(split);
#endif
    
    
    UIButton *oilAnalaysisBtn = [UIComUtil createButtonWithNormalBGImageName:@"info_btn.png" withHightBGImageName:@"info_btn.png" withTitle:@"到货确认" withTag:0];
    
    CGSize btnsize= oilAnalaysisBtn.frame.size;
    //currY = 10.f;
    currY = currY+30.f;
    oilAnalaysisBtn.frame = CGRectMake(kLeftTextPendingX,currY,btnsize.width,btnsize.height);
    [oilAnalaysisBtn addTarget:self action:@selector(myInforAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:oilAnalaysisBtn];
    
    //SafeRelease(oilAnalaysisBtn);
    
    
    currY = currY +30.f;
    
    userAgreeLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:16] withTextColor:[UIColor blueColor] withText:@"您共有0笔竞价合同未做到货确认" withFrame:CGRectMake(kLeftTextPendingX,currY,300.f, 30.f)];
    userAgreeLabel.hidden = NO;
    userAgreeLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:userAgreeLabel];
    SafeRelease(userAgreeLabel);
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
- (void)myInforAction:(id)sender{

//     kUIAlertView(@"提示", @"正在建设,敬请期待!");
//    return;
    OrderListMainViewController *vc = [[OrderListMainViewController alloc]initWithNibName:nil bundle:nil];
//    NSDictionary *item = self.dataArray[indexPath.row];
//    vc.orderId = [item objectForKey:@""];
//    [vc  setNavgationBarTitle:@"订单详情"];
    
    //[vc  setHiddenTableHeaderView:NO];
    //[vc  setH]
    /*
     vc.delegate = self;
     NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
     //NSDictionary *data = [item objectForKey:@"DayDetailInfo"];
     vc.mData = item;
     */
#if 1
    [self.navigationController pushViewController:vc animated:YES];
#else
    
    [ZCSNotficationMgr postMSG:kPushNewViewController obj:vc];
#endif
    //[self.navigationController pushViewController:vc animated:YES];
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    SafeRelease(vc);
}
- (void) shouldLoadData{
    [super shouldLoadData];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           //catStr,@"cat",
                           self.userId,@"hydm",
                           //@"10",@"wtid",
                           nil];
    CarServiceNetDataMgr *carServiceNetDataMgr = [CarServiceNetDataMgr getSingleTone];
    [carServiceNetDataMgr  getAccountInfo:param];
}
//
-(void)didNetDataOK:(NSNotification*)ntf
{
    
    
    
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];//[respRequest resourceKey];
    //NSString *resKey = [respRequest resourceKey];
    if([resKey isEqualToString:kCarUserInfo])
    {
        //        if ([self.externDelegate respondsToSelector:@selector(commentDidSendOK:)]) {
        //            [self.externDelegate commentDidSendOK:self];
        //        }
        //        kNetEndSuccStr(@"评论成功",self.view);
        //        [self dismissModalViewControllerAnimated:YES];
        
        self.data = data;
        
        [self performSelectorOnMainThread:@selector(updateUIData:) withObject:data waitUntilDone:NO];
        
    }
    
    //self.view.userInteractionEnabled = YES;
}
- (void)updateUIData:(NSDictionary*)netData{
    
    kNetEnd(self.view);
    //contentTextView.text = [netData objectForKey:@"agreement"];
    
    //userNameLabel.text =  @"上海化工交易公司";
    NSString *moneyValue = nil;
#if 0
    moneyValue = [netData objectForKey:@"availability"];

    userAccountLabel.text = [NSString stringWithFormat:@"您的帐户总额: %@ 元",moneyValue];
    //您的帐户上的自由资金余额:             元
    moneyValue = [netData objectForKey:@"balance"];
    
    userAvaiableLabel.text = [NSString stringWithFormat:@"您的可用资金: %@ 元",moneyValue];
    
    moneyValue = [netData objectForKey:@"locked"];
    
    userLockLabel.text = [NSString stringWithFormat:@"您的锁定资金: %@ 元",moneyValue];
#else
    moneyValue = [netData objectForKey:@"balance"];
    
    userAccountLabel.text = [NSString stringWithFormat:@" %0.2lf ",[moneyValue doubleValue]];
    //您的帐户上的自由资金余额:             元
    moneyValue = [netData objectForKey:@"availability"];
    
    userAvaiableLabel.text = [NSString stringWithFormat:@" %0.2lf ",[moneyValue doubleValue]];
    
    moneyValue = [netData objectForKey:@"locked"];
    
    userLockLabel.text = [NSString stringWithFormat:@"  %0.2lf ",[moneyValue doubleValue]];
#endif
    
    moneyValue = [netData objectForKey:@"unconfirmed"];
    
    if([moneyValue intValue]>=0)
    {
    
        userAgreeLabel.text = [NSString stringWithFormat:@"您共有%d笔竞购合同未做到货确认",[moneyValue intValue]];
        userAgreeLabel.hidden = NO;
    }
    else{
    
        userAgreeLabel.hidden = YES;
        
    }
    
    
    

}
- (void)didUserLogout:(NSNotification*)ntf{
    //isLogin = NO;
    [self.navigationController popToRootViewControllerAnimated:YES];
    //self.dataArray = nil;
    //currentPageNum = 0;
    [AppSetting setLogoutUser];
    
}
@end
