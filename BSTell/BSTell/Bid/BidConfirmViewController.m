//
//  BidConfirmViewController.m
//  BSTell
//
//  Created by cszhan on 14-2-1.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "BidConfirmViewController.h"
#import "BidMainViewController.h"

#define kLeftPendingX 10.f
#define kValueLeftPendingX 22.f
#define kValueFontSize 13

#define kAgrementText  @"为了给所有注册会员创造一个公平公正、竞争有序的网上交易环境，严肃交易行为，保证买卖双方按交易结果签约付款，强化交易信用的保证机制，“化工宝”对会员交易保证金作如下相关说明：\
\n1. 凡交易会员在通过“化工宝”从事网上交易（挂牌交易或竞价交易）时，为了保证买卖双方能够按照成交信息按时签约付款，减少违约情况的发生, 买卖双方各\自的东方付通账户内一定数额的备付金将自动锁定为保证金，保证金金额由卖方根据实际场次的要求而定。\
\n2. 交易过程中，东方付通信息技术有限公司有权依据交易会员在化工宝交易平台上提交的锁定保证金的指令执行保证金锁定直至交易结束。\
\n3. 交易结束后，未中标客户保证金解锁，中标客户待双方买卖合同签订确认后解锁，解锁后的会员可自由申请取回账户中金额，若买卖双方中任何一方如不能按照相应条款签订合同，化工宝将有权遵照有关流程将违约方的保证金扣除，交予守约方。\
\n4. 交易会员可随时申请提取交易保证金，在经交易中心审核确认后的1-2个工作日内完成资金的划转。划转的资金将直接退还到会员注册时预留的银行账户中。"
@interface BidConfirmViewController (){

    /*
     agreement	协议内容
     dfyj	本场次保证金
     kyye	账户余额
     */
    UITextView *contentTextView;
    UILabel    *bidMoneyLabel;
    UILabel    *accoutMoneyLabel;
    UIImageView *bidMoneyBgView;
    UILabel *headerView;
    BOOL isNextStep;
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
     [self setHiddenRightBtn:YES];
    [self setNavgationBarTitle:@"参加竞买"];
    CGFloat currY = kMBAppTopToolBarHeight;
    headerView = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:18.f] withTextColor:[UIColor blackColor] withText:@"交易保证金相关说明" withFrame:CGRectMake(0.f,currY,kDeviceScreenWidth,44.f)];
    headerView.backgroundColor = HexRGB(190, 221, 238);
    [self.view addSubview:headerView];
    SafeRelease(headerView);
    
    
    
    currY = currY+60.f;
    
    
    
    UIImageWithFileName(UIImage *image , @"bid_confirm_bg.png");
    
    UIImageView *confirmTextBgView = [[UIImageView alloc]initWithFrame:CGRectMake(10.f, currY, image.size.width/kScale,kDeviceScreenHeight-currY-kMBAppBottomToolBarHeght-80.f)];
    confirmTextBgView.image = image;
    confirmTextBgView.userInteractionEnabled = YES;
    [self.view addSubview:confirmTextBgView];
    SafeRelease(confirmTextBgView);
    
    
    //
    CGFloat offsetY = 90.f;
//    if(self.agreeType == 1){
//    
//        offsetY = 10.f;
//    }
//    if(
    contentTextView = [[UITextView alloc]initWithFrame:CGRectMake(kLeftPendingX,kLeftPendingX,image.size.width/2.f-2*kLeftPendingX, confirmTextBgView.frame.size.height-90.f)];
    contentTextView.font = [UIFont systemFontOfSize:13];
    contentTextView.editable = NO;
    contentTextView.backgroundColor = [UIColor clearColor];
    contentTextView.text = kAgrementText;
    //contentTextView.scrollEnabled = YES;
    [confirmTextBgView addSubview:contentTextView];
    SafeRelease(contentTextView);
    
    
#if 0
  

    bidMoneyLabel = [UIComUtil createLabelWithFont:[UIFont boldSystemFontOfSize:12] withTextColor:[UIColor blackColor] withText:@"0" withFrame:CGRectMake(kLeftPendingX, contentTextView.frame.origin.y+contentTextView.frame.size.height,250.f, 20.f)];
    bidMoneyLabel.textAlignment = NSTextAlignmentLeft;
    [confirmTextBgView addSubview:bidMoneyLabel];
    SafeRelease(bidMoneyLabel);
    
    accoutMoneyLabel = [UIComUtil createLabelWithFont:[UIFont boldSystemFontOfSize:12] withTextColor:[UIColor blackColor] withText:@"0" withFrame:CGRectMake(kLeftPendingX, contentTextView.frame.origin.y+contentTextView.frame.size.height+20.f,250.f, 20.f)];
    accoutMoneyLabel.textAlignment = NSTextAlignmentLeft;
    [confirmTextBgView addSubview:accoutMoneyLabel];
    SafeRelease(accoutMoneyLabel);
#else
    UIImageWithFileName(image , @"bid_money_bg.png");
    
    bidMoneyBgView = [[UIImageView alloc]initWithFrame:CGRectZero];
    bidMoneyBgView.frame = CGRectMake(-10.f, 10.f+currY+confirmTextBgView.frame.size.height-image.size.height/2.f-100.f, image.size.width/kScale,image.size.height/kScale);
    bidMoneyBgView.image = image;
    bidMoneyBgView.userInteractionEnabled = YES;
    [confirmTextBgView insertSubview:bidMoneyBgView belowSubview:contentTextView];
    SafeRelease(bidMoneyBgView);
    
    
    
    bidMoneyLabel = [UIComUtil createLabelWithFont:[UIFont boldSystemFontOfSize:kValueFontSize] withTextColor:[UIColor blackColor] withText:@"0" withFrame:CGRectMake(kValueLeftPendingX,45,230.f, 20.f)];
    bidMoneyLabel.textAlignment = NSTextAlignmentRight;
    bidMoneyLabel.textColor = [UIColor redColor];
    [bidMoneyBgView addSubview:bidMoneyLabel];
    SafeRelease(bidMoneyLabel);
    
    accoutMoneyLabel = [UIComUtil createLabelWithFont:[UIFont boldSystemFontOfSize:kValueFontSize] withTextColor:[UIColor blackColor] withText:@"0" withFrame:CGRectMake(kValueLeftPendingX,75,230.f, 20.f)];
    accoutMoneyLabel.textAlignment = NSTextAlignmentRight;
    accoutMoneyLabel.textColor = [UIColor redColor];
    [bidMoneyBgView addSubview:accoutMoneyLabel];
    SafeRelease(accoutMoneyLabel);
    
    
#endif
    
    
    currY = currY + confirmTextBgView.frame.size.height+ 10.f;
    
    UIButton *okBtn = [UIComUtil createButtonWithNormalBGImageName:@"bid_confirm_btn.png" withHightBGImageName:@"bid_confirm_btn.png" withTitle:@"同意" withTag:0];
    
    UIButton *failedBtn  = [UIComUtil createButtonWithNormalBGImageName:@"bid_confirm_btn.png" withHightBGImageName:@"bid_confirm_btn.png" withTitle:@"不同意" withTag:1];
    
    okBtn.frame = CGRectMake(50.f, currY, okBtn.frame.size.width, okBtn.frame.size.height);
    [self.view addSubview:okBtn];
    
    [okBtn addTarget:self action:@selector(pressConfirmButton:) forControlEvents:UIControlEventTouchUpInside];
    failedBtn.frame = CGRectMake(170.f, currY, okBtn.frame.size.width, okBtn.frame.size.height);
    [self.view addSubview:failedBtn];
    [failedBtn addTarget:self action:@selector(pressConfirmButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self updateUIData:self.data];
    
    if(self.agreeType == 1){
        
        NSString *moneyValue = [self.data objectForKey:@"dfyj"];
        bidMoneyLabel.text = [NSString stringWithFormat:@"%0.2lf",[moneyValue  doubleValue]];
        //您的帐户上的自由资金余额:             元
        moneyValue = [self.data objectForKey:@"kyye"];
        accoutMoneyLabel.text = [NSString stringWithFormat:@"%0.2lf",[moneyValue  doubleValue]];
    
    }
  
    
}
- (void)setHiddenMoneyAgreement{

    {
        bidMoneyBgView.hidden = YES;
        bidMoneyLabel.hidden = YES;
        accoutMoneyLabel.hidden = YES;
        
    }

}
- (void)shouldLoadData{
    
    if(self.agreeType == 1){
        return;
    }
    
}
//
-(void)didNetDataOK:(NSNotification*)ntf
{
    

    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];//[respRequest resourceKey];
    //NSString *resKey = [respRequest resourceKey];
   
    if([resKey isEqualToString:kResBidAgreeAction] ){
        
        //[self.navigationController  popToRootViewControllerAnimated:YES];
        //[self performSelector:@selector(didEnterBidMain) withObject:nil afterDelay:0.f];
        //[self performSelectorOnMainThread:@selector(bidAgreeAction:) withObject:nil  waitUntilDone:NO];
        if(self.agreeType == 1|| (isNextStep == NO && self.agreeType == 0))
            [self didEnterBidMain];
    }
    
    //self.view.userInteractionEnabled = YES;
}

- (void)didEnterBidMain
{
    BidMainViewController *bidMainVc = [[BidMainViewController alloc]init];
    [self.navigationController pushViewController:bidMainVc animated:YES];
    SafeRelease(bidMainVc);

}

- (void)bidAgreeAction:(id)data{
    if(isNextStep){
        kUIAlertConfirmView(@"提示", @"您要参加本场竞价吗?", @"确定", @"取消");
    }
    else{
        kUIAlertConfirmView(@"提示", @"您确定要同意条款并锁定保证金吗?", @"确定", @"取消");
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(isNextStep  == NO && buttonIndex == 0){
        
        NSString *operId = [[AppSetting getLoginUserData:[AppSetting getLoginUserId]] objectForKey:@"czy"];
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                               self.userId,@"hydm",
                               self.wtid,@"wtid",
                               operId,@"czy",
                               nil];
        CarServiceNetDataMgr *carServiceNetDataMgr = [CarServiceNetDataMgr getSingleTone];
        self.request = [carServiceNetDataMgr  joinBuy4Move:param];
        
       
    }
    else{
        if(buttonIndex == 0){
            BidConfirmViewController *bidConfirmVc = [[BidConfirmViewController alloc]init];
            bidConfirmVc.wtid = self.wtid;
            bidConfirmVc.agreeType = 1;
            bidConfirmVc.data = self.data;
            [self.navigationController pushViewController:bidConfirmVc animated:YES];
            SafeRelease(bidConfirmVc);
        }
    }
    
}
- (void)updateUIData:(NSDictionary*)netData{
    kNetEnd(self.view);
    if(1){
        
        NSString *moneyValue = [netData objectForKey:@"dfyj"];
        bidMoneyLabel.text = [NSString stringWithFormat:@"%0.2lf",[moneyValue  doubleValue]];
        //您的帐户上的自由资金余额:             元
        moneyValue = [netData objectForKey:@"kyye"];
        accoutMoneyLabel.text = [NSString stringWithFormat:@"%0.2lf",[moneyValue  doubleValue]];
    }
    NSString *agreement = [netData objectForKey:@"agreement"];
    if(agreement && ![agreement isEqualToString:@""] && (self.agreeType == 0)){
        headerView.text = @"协议条款";
        contentTextView.text = agreement;
        [self setHiddenMoneyAgreement];
        isNextStep = YES;
        
    }
    else{
        self.agreeType = 1;
    }
}
- (void)pressConfirmButton:(id)sender{

    if([sender tag] == 0){
        
        /*
         */
        [self bidAgreeAction:nil];
       
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
