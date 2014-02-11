//
//  BidConfirmViewController.m
//  BSTell
//
//  Created by cszhan on 14-2-1.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "BidConfirmViewController.h"
#import "BidMainViewController.h"

#define kLeftPendingX 20.f

@interface BidConfirmViewController (){

    /*
     agreement	协议内容
     dfyj	本场次保证金
     kyye	账户余额
     */
    UITextView *contentTextView;
    UILabel    *bidMoneyLabel;
    UILabel    *accoutMoneyLabel;
}
@end

@implementation BidConfirmViewController

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
    //tweetieTableView.hidden = YES;
    
    CGFloat currY = kMBAppTopToolBarHeight;
    UILabel *headerView = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:18.f] withTextColor:[UIColor blackColor] withText:@"交易保证金相关说明" withFrame:CGRectMake(0.f,currY,kDeviceScreenWidth,44.f)];
    headerView.backgroundColor = HexRGB(190, 221, 238);
    [self.view addSubview:headerView];
    SafeRelease(headerView);
    
    
    
    currY = currY+60.f;
    
    UIImageWithFileName(UIImage *image , @"bid_confirm_bg.png");
    
    UIImageView *confirmTextBgView = [[UIImageView alloc]initWithFrame:CGRectMake(10.f, currY, image.size.width/kScale, image.size.height/kScale)];
    confirmTextBgView.image = image;
    confirmTextBgView.userInteractionEnabled = YES;
    [self.view addSubview:confirmTextBgView];
    SafeRelease(confirmTextBgView);
    //
    contentTextView = [[UITextView alloc]initWithFrame:CGRectMake(kLeftPendingX,kLeftPendingX-10.f,kDeviceScreenWidth-2*kLeftPendingX-20, 250.f)];
    contentTextView.font = [UIFont systemFontOfSize:10];
    contentTextView.editable = NO;
    //contentTextView.scrollEnabled = YES;
    [confirmTextBgView addSubview:contentTextView];
    SafeRelease(contentTextView);
    
    bidMoneyLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:13] withTextColor:[UIColor blackColor] withText:@"" withFrame:CGRectMake(kLeftPendingX, contentTextView.frame.origin.y+contentTextView.frame.size.height+10.f,250.f, 20.f)];
    bidMoneyLabel.textAlignment = NSTextAlignmentLeft;
    [confirmTextBgView addSubview:bidMoneyLabel];
    SafeRelease(bidMoneyLabel);
    
    accoutMoneyLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:13] withTextColor:[UIColor blackColor] withText:@"" withFrame:CGRectMake(kLeftPendingX, contentTextView.frame.origin.y+contentTextView.frame.size.height+30.f,250.f, 20.f)];
    accoutMoneyLabel.textAlignment = NSTextAlignmentLeft;
    [confirmTextBgView addSubview:accoutMoneyLabel];
    SafeRelease(accoutMoneyLabel);
    
    
    
    currY = currY + image.size.height/kScale+ 10.f;
    
    UIButton *okBtn = [UIComUtil createButtonWithNormalBGImageName:@"bid_confirm_btn.png" withHightBGImageName:@"bid_confirm_btn.png" withTitle:@"同意" withTag:0];
    
    UIButton *failedBtn  = [UIComUtil createButtonWithNormalBGImageName:@"bid_confirm_btn.png" withHightBGImageName:@"bid_confirm_btn.png" withTitle:@"不同意" withTag:1];
    
    okBtn.frame = CGRectMake(40.f, currY, okBtn.frame.size.width, okBtn.frame.size.height);
    [self.view addSubview:okBtn];
    
    [okBtn addTarget:self action:@selector(pressConfirmButton:) forControlEvents:UIControlEventTouchUpInside];
    failedBtn.frame = CGRectMake(160.f, currY, okBtn.frame.size.width, okBtn.frame.size.height);
    [self.view addSubview:failedBtn];
    [failedBtn addTarget:self action:@selector(pressConfirmButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}
- (void) shouldLoadData{
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           //catStr,@"cat",
                           @"001",@"hydm",
                           @"10",@"wtid",
                           nil];
    CarServiceNetDataMgr *carServiceNetDataMgr = [CarServiceNetDataMgr getSingleTone];
    self.request = [carServiceNetDataMgr  showAgreement4Move:param];
}
//
-(void)didNetDataOK:(NSNotification*)ntf
{
    
    
    
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];//[respRequest resourceKey];
    //NSString *resKey = [respRequest resourceKey];
    if([resKey isEqualToString:kResBidAgreementData])
    {
        //        if ([self.externDelegate respondsToSelector:@selector(commentDidSendOK:)]) {
        //            [self.externDelegate commentDidSendOK:self];
        //        }
        //        kNetEndSuccStr(@"评论成功",self.view);
        //        [self dismissModalViewControllerAnimated:YES];
        
        
        
        [self performSelectorOnMainThread:@selector(updateUIData:) withObject:data waitUntilDone:NO];
        
    }
    if([resKey isEqualToString:kResBidAgreeAction]){
        [self performSelectorOnMainThread:@selector(bidAgreeAction:) withObject:nil  waitUntilDone:NO];
    }
    
    //self.view.userInteractionEnabled = YES;
}
- (void)bidAgreeAction:(id)data{

    BidMainViewController *bidMainVc = [[BidMainViewController alloc]init];
    [self.navigationController pushViewController:bidMainVc animated:YES];
    SafeRelease(bidMainVc);
}
- (void)updateUIData:(NSDictionary*)netData{
    kNetEnd(self.view);
    contentTextView.text = [netData objectForKey:@"agreement"];
    NSString *moneyValue = [netData objectForKey:@"dfyj"];
    bidMoneyLabel.text = [NSString stringWithFormat:@"您的竞价所需锁定的保证金: %@ 元",moneyValue];
    //您的帐户上的自由资金余额:             元
    moneyValue = [netData objectForKey:@"kyye"];
    accoutMoneyLabel.text = [NSString stringWithFormat:@"您的帐户上的自由资金余额: %@ 元",moneyValue];
    
}
- (void)pressConfirmButton:(id)sender{

    if([sender tag] == 0){
        
        /*
         
         */
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"001",@"hydm",
                               @"",@"wtid",
                               @"",@"czy",
                               nil];
        CarServiceNetDataMgr *carServiceNetDataMgr = [CarServiceNetDataMgr getSingleTone];
        self.request = [carServiceNetDataMgr  joinBuy4Move:param];
       
    }
    else{
    
        [self.navigationController popViewControllerAnimated:YES];
    }

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
