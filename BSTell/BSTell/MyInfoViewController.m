//
//  MyInfoViewController.m
//  BSTell
//
//  Created by cszhan on 14-1-30.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "MyInfoViewController.h"

#import "OrderListViewController.h"

#define kLeftPendingX 30.f

@interface MyInfoViewController (){

    UILabel *userNameLabel;
    UILabel *userAccountLabel;
    UILabel *userAvaiableLabel;
    UILabel *userLockLabel;
    UILabel *userAgreeLabel;
}
@end

@implementation MyInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    CGFloat currY = kMBAppTopToolBarHeight+80.f;
    userNameLabel = [UIComUtil createLabelWithFont:[UIFont boldSystemFontOfSize:16] withTextColor:[UIColor blackColor] withText:@"" withFrame:CGRectMake(kLeftPendingX,currY,300.f, 30.f)];
    userNameLabel.textAlignment = NSTextAlignmentLeft;
    currY = currY+30.f;
    
    [self.view addSubview:userNameLabel];
    SafeRelease(userNameLabel);
    
    UIView *split = [UIComUtil createSplitViewWithFrame:CGRectMake(0.f,currY,kDeviceScreenWidth,2.f) withColor:[UIColor grayColor]];
    [self.view addSubview:split];
    SafeRelease(split);
    
    
    
    userAccountLabel = [UIComUtil createLabelWithFont:[UIFont boldSystemFontOfSize:14] withTextColor:[UIColor blueColor] withText:@"" withFrame:CGRectMake(kLeftPendingX,currY,300.f, 30.f)];
    currY = currY+30.f;
    userAccountLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:userAccountLabel];
    SafeRelease(userAccountLabel);
    
    
    userAvaiableLabel = [UIComUtil createLabelWithFont:[UIFont boldSystemFontOfSize:14] withTextColor:[UIColor greenColor] withText:@"" withFrame:CGRectMake(kLeftPendingX,currY,300.f, 30.f)];
    userAvaiableLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:userAvaiableLabel];
    SafeRelease(userAvaiableLabel);
    
    currY = currY+30.f;
    userLockLabel = [UIComUtil createLabelWithFont:[UIFont boldSystemFontOfSize:12] withTextColor:[UIColor redColor] withText:@"" withFrame:CGRectMake(kLeftPendingX,currY,300.f, 30.f)];
    userLockLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:userLockLabel];
    SafeRelease(userLockLabel);
    
    
    currY = currY+30.f;
    
    split = [UIComUtil createSplitViewWithFrame:CGRectMake(0.f,currY,kDeviceScreenWidth,2.f) withColor:[UIColor grayColor]];
    [self.view addSubview:split];
    SafeRelease(split);

    
    
    UIButton *oilAnalaysisBtn = [UIComUtil createButtonWithNormalBGImageName:@"info_btn.png" withHightBGImageName:@"info_btn.png" withTitle:@"我的信息" withTag:0];
    
    CGSize btnsize= oilAnalaysisBtn.frame.size;
    //currY = 10.f;
    currY = currY+30.f;
    oilAnalaysisBtn.frame = CGRectMake(kLeftPendingX,currY,btnsize.width,btnsize.height);
    [oilAnalaysisBtn addTarget:self action:@selector(myInforAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:oilAnalaysisBtn];
    
    SafeRelease(oilAnalaysisBtn);
    
    
    currY = currY +30.f;
    
    userAgreeLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:14] withTextColor:[UIColor blueColor] withText:@"" withFrame:CGRectMake(kLeftPendingX,currY,300.f, 30.f)];
    userAgreeLabel.hidden = YES;
    [self.view addSubview:userAgreeLabel];
    SafeRelease(userAgreeLabel);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
- (void)myInforAction:(id)sender{

    
    OrderListViewController *vc = [[OrderListViewController alloc]initWithNibName:nil bundle:nil];
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
    
    userNameLabel.text = @"上海化工交易公司";
    
    NSString *moneyValue = [netData objectForKey:@"availability"];
    
    userAccountLabel.text = [NSString stringWithFormat:@"您的帐户余额: %@ 元",moneyValue];
    //您的帐户上的自由资金余额:             元
    moneyValue = [netData objectForKey:@"balance"];
    
    userAvaiableLabel.text = [NSString stringWithFormat:@"您的可用资金: %@ 元",moneyValue];
    
    moneyValue = [netData objectForKey:@"locked"];
    
    userLockLabel.text = [NSString stringWithFormat:@"您的锁定资金: %@ 元",moneyValue];
    
    moneyValue = [netData objectForKey:@"unconfirmed"];
    
    userAgreeLabel.text = [NSString stringWithFormat:@"您共有%d笔竞购合同未做到货确认",[moneyValue intValue]];
    
    
}
@end
