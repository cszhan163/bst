//
//  BidItemDetailViewController.m
//  BSTell
//
//  Created by cszhan on 14-2-9.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "BidItemDetailViewController.h"
#import "LeftTitleListCell.h"
#import "BidAdjustAlertView.h"
#define kLeftPendingX  10

#define kItemPendingY   @20

@interface BidItemDetailViewController ()<BidAdjustAlertViewDelegate>{

    LeftTitleListCell *leftTitleCellView;
    
    UILabel     *currBidPriceLabel;
    UILabel     *bidStepPriceLabel;
    UILabel     *delegateBidPriceLabel;
    
    UITextField *customBidPriceTextFiled;
    
    UIButton *bidStatusBtn;
    UIButton *bidBtn;
    BidAdjustAlertView *bidAdjustView;
    
    UILabel *indictorView;
    UIControl *indictorViewBg;
    
    UITextField *bidPriceTextFiled;
    
    BOOL  adjustOneTime;
    
    int bidMode;
}
@end

@implementation BidItemDetailViewController
- (void)dealloc{
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        bidMode = 3;
        adjustOneTime = YES;
    }
    return self;
}
- (void)startReflushjTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:kBidReflushTimer target:self selector:@selector(reflushData) userInfo:nil repeats:YES];
    
}
- (void)stopReflushTimer{
    [self.timer invalidate];
    self.timer = nil;
}
- (void)reflushData{
    [self shouldLoadData];
}
- (void)addObservers
{
    
}
- (void)setNavgationBarRightButton{
    
    UIImageWithFileName(UIImage *bgImage, @"reflush_btn.png");
    CGRect newRect = CGRectMake(kDeviceScreenWidth-10.f-bgImage.size.width/2.f, 10.f, bgImage.size.width/kScale, bgImage.size.height/kScale);
    self.rightBtn.frame = newRect;
    [self.rightBtn setBackgroundImage:bgImage forState:UIControlStateNormal];
    [self.rightBtn setBackgroundImage:bgImage forState:UIControlStateSelected];
    [self.rightBtn setTitle:@"刷新" forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"刷新" forState:UIControlStateHighlighted];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addObservers];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self removeObservers];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setHiddenRightBtn:NO];
    [self setNavgationBarRightButton];
    CGFloat currY = kMBAppTopToolBarHeight;
    CGFloat buttomHeight = 120.f;
#if 0
    UILabel *headerView = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:18.f] withTextColor:[UIColor blackColor] withText:@"交易保证金相关说明" withFrame:CGRectMake(0.f,currY,kDeviceScreenWidth,44.f)];
    headerView.backgroundColor = HexRGB(190, 221, 238);
    [self.view addSubview:headerView];
    SafeRelease(headerView);
    
    
    
    currY = currY+60.f;
#else
    currY = currY+10.f;
#endif
    
    UIImageWithFileName(UIImage *image , @"bid_confirm_bg.png");
    
#if 1
    
    UIImageView *bgView = [[UIImageView alloc]initWithFrame:CGRectMake(kLeftPendingX, currY, image.size.width/kScale, kDeviceScreenHeight-kMBAppBottomToolBarHeght-kMBAppTopToolBarHeight-kMBAppStatusBar-buttomHeight)];
    [self.view  addSubview:bgView];
    bgView.userInteractionEnabled = YES;
    bgView.image = image;
    SafeRelease(bgView);
    
    UIScrollView *confirmTextBgView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f,5.f, image.size.width/kScale, kDeviceScreenHeight-kMBAppBottomToolBarHeght-kMBAppTopToolBarHeight-kMBAppStatusBar-buttomHeight-10.f)];
    confirmTextBgView.bounces = NO;
    
    //confirmTextBgView.layer.contents = (id)image.CGImage;
    confirmTextBgView.backgroundColor = [UIColor clearColor];
    
    //confirmTextBgView.frame = CGRectMake(10, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
    
    
#else
    UIImageView *confirmTextBgView = [[UIImageView alloc]initWithFrame:CGRectMake(kLeftPendingX, currY, image.size.width/kScale, image.size.height/kScale)];
    confirmTextBgView.image = image;
    confirmTextBgView.userInteractionEnabled = YES;
#endif
    /*
    */
    leftTitleCellView = [[LeftTitleListCell alloc] initWithFrame:CGRectMake(0,0.f,confirmTextBgView.frame.size.width, 380.f) withTitleArray:@[                                                       @"场次",
                                                                                                                     @"品名",
                                                                                                                      
                                                                                @"竞价状态",
                                                                                @"结束时间",                                                                                            @"起拍价",
                                                                                @"我的出价",                                     @"报价状态",
                                                                                @"计价单位",
                                                                                                                      
                                                                                                                      
                                                                                                                     
                                                                                                                     @"重量",
                                                                                                                                                                            @"包装",
                                                                                                                                                                            @"产地",
                                                                                                                                                                            @"质量标准",
                                                                                                                                                                            @"仓库",
                                                                                                                     @"备注",
                                                                                ]
                                                                withItemPendingArray:@[
                                                                                       kItemPendingY,
                                                                                       //kItemPendingY,
                                                                                       @28,
                                                                                       //kItemPendingY,
                                                                                       kItemPendingY,
                                                                                       kItemPendingY,
                                                                                       kItemPendingY,
                                                                                       kItemPendingY,
                                                                                       kItemPendingY,
                                                                                       @28,
                                                                                       kItemPendingY,
                                                                                       kItemPendingY,
                                                                                       kItemPendingY,
                                                                                       kItemPendingY,
                                                                                       kItemPendingY,
                                                                                       kItemPendingY
                                                                                       ]
                                                                                    ];
    
    [confirmTextBgView addSubview:leftTitleCellView];
    leftTitleCellView.backgroundColor = [UIColor clearColor];
    SafeRelease(leftTitleCellView);

    [bgView addSubview:confirmTextBgView];
    SafeRelease(confirmTextBgView);
    
    confirmTextBgView.contentSize = leftTitleCellView.frame.size;
    
    
    currY = currY+confirmTextBgView.frame.size.height;
    
    
    
    
    currY = currY+5.f;
    
    currBidPriceLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:14] withTextColor:[UIColor blackColor] withText:@"当前价:" withFrame:CGRectMake(kLeftPendingX, currY, 120.f, 20.f)];
    currBidPriceLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:currBidPriceLabel];
    SafeRelease(currBidPriceLabel);
    
    bidStepPriceLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:14] withTextColor:[UIColor blackColor] withText:@"竞价梯度:" withFrame:CGRectMake(kLeftPendingX+160.f, currY, 140.f, 20.f)];
    bidStepPriceLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:bidStepPriceLabel];
    SafeRelease(bidStepPriceLabel);
    
    
    //next line
    currY = currY+20.f;
#if 0
    customBidPriceTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(kLeftPendingX,currY,80.f, 20.f)];
    customBidPriceTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    [self.view  addSubview:customBidPriceTextFiled];
    SafeRelease(customBidPriceTextFiled);
#endif
    delegateBidPriceLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:14] withTextColor:[UIColor blackColor] withText:@"当前委托:" withFrame:CGRectMake(kLeftPendingX+160.f, currY, 140.f, 20.f)];
    
    delegateBidPriceLabel.textAlignment = NSTextAlignmentRight;
    
    [self.view addSubview:delegateBidPriceLabel];
    SafeRelease(delegateBidPriceLabel);
    
    
    currY = currY+15.f;
    
    bidBtn = [UIComUtil createButtonWithNormalBGImageName:@"bid_price_btn.png" withHightBGImageName:@"bid_price_btn.png" withTitle:@"梯度出价" withTag:0];
    [self.view  addSubview:bidBtn];
    bidBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [bidBtn addTarget:self action:@selector(startBidPrice:) forControlEvents:UIControlEventTouchUpInside];
    bidBtn.frame = CGRectMake(20.f,currY+15.f, bidBtn.frame.size.width, bidBtn.frame.size.height);
    
#if 0
    bidBtn = [UIComUtil createButtonWithNormalBGImageName:@"bid_item_price.png" withHightBGImageName:@"bid_item_price.png" withTitle:@"+1" withTag:1];
    [self.view  addSubview:bidBtn];
    bidBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [bidBtn addTarget:self action:@selector(startBidPrice:) forControlEvents:UIControlEventTouchUpInside];
    bidBtn.frame = CGRectMake(kDeviceScreenWidth/2-bidBtn.frame.size.width/2,currY, bidBtn.frame.size.width, bidBtn.frame.size.height);
    
#endif
    
    bidStatusBtn = [UIComUtil createButtonWithNormalBGImageName:@"bid_price_btn.png" withHightBGImageName:@"bid_price_btn.png" withTitle:@"委托出价" withTag:2];
    [self.view  addSubview:bidStatusBtn];
    bidStatusBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [bidStatusBtn addTarget:self action:@selector(startBidPrice:) forControlEvents:UIControlEventTouchUpInside];
    bidStatusBtn.frame = CGRectMake(kDeviceScreenWidth-20.f-bidStatusBtn.frame.size.width,currY+15.f, bidStatusBtn.frame.size.width, bidStatusBtn.frame.size.height);
	// Do any additional setup after loading the view.
    
    bidAdjustView = [[BidAdjustAlertView alloc]initWithFrame:CGRectMake(0.f, 0.f,300.f,280.f) withHeadTitle:@""];
    bidAdjustView.delegate = self;
    
   
    
    bidPriceTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(kLeftPendingX,currY+10.f,150.f,40.f)];
    bidPriceTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    
    
    [self.view addSubview:bidPriceTextFiled];
    
    SafeRelease(bidPriceTextFiled);
    
    UILabel *priceUnitLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:14] withTextColor:[UIColor blackColor] withText:@"元" withFrame:CGRectMake(kLeftPendingX+150.f+10.f,currY+20.f,60.f,20.f)];
    priceUnitLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:priceUnitLabel];
    SafeRelease(priceUnitLabel);
    priceUnitLabel.hidden = YES;
    bidPriceTextFiled.hidden = YES;
    
    indictorView = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:16] withTextColor:[UIColor blackColor] withText:@"" withFrame:CGRectMake(0.f,0.f,kDeviceScreenWidth, 40.f)];
    indictorView.backgroundColor = [UIColor whiteColor];
    
    /*
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self    action:@selector(didTapView)];
    [indictorView addGestureRecognizer:tap];
    //SafeRelease(tap);
     */
    indictorViewBg = [[UIControl alloc]initWithFrame:indictorView.frame];
    [indictorViewBg addSubview:indictorView];
    [indictorViewBg addTarget:self action:@selector(didTapView) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn setTitle:@"完成" forState:UIControlStateSelected];
    btn.frame = CGRectMake(kDeviceScreenWidth- 60.f,0.f,40.f, 40.f);
    [btn addTarget:self action:@selector(didTapView) forControlEvents:UIControlEventTouchUpInside];
    [indictorViewBg addSubview:btn];
    
    
    SafeRelease(indictorView);
    indictorViewBg.backgroundColor = [UIColor clearColor];
    
    bidPriceTextFiled.inputAccessoryView = indictorViewBg;
    [bidPriceTextFiled addTarget:self action:@selector(didchangeTextFiledValue) forControlEvents:UIControlEventEditingChanged];
    bidPriceTextFiled.delegate = self;
    bidPriceTextFiled.returnKeyType = UIReturnKeyDone;
    bidPriceTextFiled.keyboardType = UIKeyboardTypeDecimalPad;
    
    if(self.bidType == Bid_Prepare)
    {
        
        [leftTitleCellView setTitleHidden:YES withIndex:5];
        [leftTitleCellView setTitleHidden:YES withIndex:6];
        bidBtn.hidden = YES;
        currBidPriceLabel.hidden = YES;
        bidStepPriceLabel.hidden = YES;
        delegateBidPriceLabel.hidden = YES;
        bidStatusBtn.hidden = YES;
        
        CGFloat currY = kDeviceScreenHeight-kMBAppTopToolBarHeight-kMBAppStatusBar-kMBAppBottomToolBarHeght- 60+10.f;
        UIButton *oilAnalaysisBtn = [UIComUtil createButtonWithNormalBGImageName:@"bid_start_btn.png" withHightBGImageName:@"bid_start_btn.png" withTitle:@"退出竞价" withTag:0];
        
        CGSize btnsize= oilAnalaysisBtn.frame.size;
        btnsize = CGSizeMake(btnsize.width-20, btnsize.height);
        //currY = 10.f;
        currY = currY+10.f;
        oilAnalaysisBtn.frame = CGRectMake((kDeviceScreenWidth-btnsize.width)/2.f,currY,btnsize.width,btnsize.height);
        [oilAnalaysisBtn addTarget:self action:@selector(logOutConfirm:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:oilAnalaysisBtn];
    }
    else
    {
    
        NSString *value = [self.data objectForKey:@"jjms"];
        if([value isEqualToString:@"2"]){
            bidBtn.hidden = YES;
            currBidPriceLabel.hidden = YES;
            bidStepPriceLabel.hidden = YES;
            delegateBidPriceLabel.hidden = YES;
            bidPriceTextFiled.hidden = NO;
            priceUnitLabel.hidden = NO;
            [bidStatusBtn setTitle:@"出价" forState:UIControlStateNormal];
            bidMode = 2;
        }
    }
    
}

- (void)logOutConfirm:(id)sender{

    //if(canLoger)
    {
        kUIAlertConfirmView(@"提示", @"是否确认退出竞价", @"确定", @"取消");
    }

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-
#pragma mark -net data
- (void) shouldLoadData{
    [super shouldLoadData];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           //catStr,@"cat",
                           self.userId,@"hydm",
                           self.goodId,@"id",
                           nil];
    CarServiceNetDataMgr *carServiceNetDataMgr = [CarServiceNetDataMgr getSingleTone];
    self.request = [carServiceNetDataMgr  queryAuctionPpInfo4Move:param];
}
-(void)didNetDataOK:(NSNotification*)ntf
{
    
    
    
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];//[respRequest resourceKey];
    //NSString *resKey = [respRequest resourceKey];
    if([resKey isEqualToString:kResBidItemData])
    {
        //        if ([self.externDelegate respondsToSelector:@selector(commentDidSendOK:)]) {
        //            [self.externDelegate commentDidSendOK:self];
        //        }
        //        kNetEndSuccStr(@"评论成功",self.view);
        //        [self dismissModalViewControllerAnimated:YES];
        NSString *msg = [data objectForKey:@"msg"];
        if([[data objectForKey:@"ret"]intValue] == 1){
            self.data = data;
            [self performSelectorOnMainThread:@selector(updateUIData:) withObject:data waitUntilDone:NO];
        }
        else{
            
            kUIAlertView(@"提示", msg);
            [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:@1 afterDelay:1];
        }
        
    }
    
    if([resKey isEqualToString:kResBidDetailSaveData])
    {
        //        if ([self.externDelegate respondsToSelector:@selector(commentDidSendOK:)]) {
        //
        NSString *msg = [data objectForKey:@"msg"];
        if([[data objectForKey:@"result"]intValue] == 1){
            if(bidMode == 5){
                kUIAlertView(@"提示", @"取消委托成功");
            }
            else if(bidMode == 0)
            {
                kUIAlertView(@"提示", @"委托出价成功");
            }
            else
            {
                kUIAlertView(@"提示", @"出价成功");
            }
        }
        else{
            
            kUIAlertView(@"提示", msg);
        }
        
        [self shouldLoadData];
    }
    
    if([resKey isEqualToString:kResBidQuit]){
        NSString *msg = [data objectForKey:@"msg"];
        if([[data objectForKey:@"result"]intValue] == 1){
            kUIAlertView(@"提示", @"退出竞价成功");
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
        
             kUIAlertView(@"提示", msg);
        }
        
    }
    //self.view.userInteractionEnabled = YES;
}
- (void)updateUIData:(NSDictionary*)netData{
    kNetEnd(self.view);
    
    int index = 0;
    int row = 0;
    NSString *value = @"";
    /*
     
    
     QS	质量标准
     note	备注
    
     
     priceUnit	计价单位
     wtmc	场次名称
     */
   
    NSDictionary *item = netData;
    //id
    value = [item objectForKey:@"dqj"];
    //[cell setCellItemValue:value withIndex:index++];
   
    {
        if([value floatValue] == 0.f){
            self.isBasePriceBid = YES;
            [bidBtn setTitle:@"底价出价" forState:UIControlStateNormal];
            [bidBtn setTitle:@"底价出价" forState:UIControlStateSelected];
        }
        else{
            self.isBasePriceBid = NO;
            [bidBtn setTitle:@"梯度出价" forState:UIControlStateNormal];
            [bidBtn setTitle:@"梯度出价" forState:UIControlStateSelected];
            value = [NSString stringWithFormat:@"%0.2lf元",[value floatValue]];
        }
    }
    if([value floatValue] == 0){
        value = @"----";
    }
    else{
        value = [NSString stringWithFormat:@"%0.2lf元",[value floatValue]];
    }
    currBidPriceLabel.text = [NSString stringWithFormat:@"当前价:%@ ",value];
    
    value = [item objectForKey:@"bjtd"];
    bidStepPriceLabel.text = [NSString stringWithFormat:@"竞价梯度:%0.2lf 元",[value floatValue]];
    
    value = [item objectForKey:@"wtprice"];
    
    if([value floatValue] == 0){
        value = @"----";
    }
    else{
        value = [NSString stringWithFormat:@"%0.2lf元",[value floatValue]];
    }
    
    delegateBidPriceLabel.text = [NSString stringWithFormat:@"当前委托:%@ ",value];
    
    value = [item objectForKey:@"wtprice"];
    
    if(bidMode != 2){
        if([value isEqualToString:@"0"]){
            
            [bidStatusBtn setTitle:@"委托出价" forState:UIControlStateNormal];
            [bidStatusBtn setTitle:@"委托出价" forState:UIControlStateSelected];
            delegateBidPriceLabel.text = [NSString stringWithFormat:@"当前委托:%@",@"----"];
        }
        else{
            self.isDelegate = NO;
            [bidStatusBtn setTitle:@"取消委托" forState:UIControlStateNormal];
            [bidStatusBtn setTitle:@"取消委托" forState:UIControlStateSelected];
            
            
        }
    }
    else{
        if(adjustOneTime){
            [leftTitleCellView setTitleHidden:YES withIndex:6 withAdjust:YES];
            adjustOneTime = NO;
        }
    }
     value = [item objectForKey:@"wtmc"];
    [leftTitleCellView setCellItemValue:value withRow:index++];
    
    value = [item objectForKey:@"goodName"];
    [leftTitleCellView setCellItemValue:value withRow:index++];
    
    
    value = [item objectForKey:@"auctionStatus"];
    if([value intValue] == 2){
        [leftTitleCellView setCellItemValue:@"竞价中" withRow:index++];
    }
    else{
    
        [leftTitleCellView setCellItemValue:@"未开始" withRow:index++];
    }
    
    value = [item objectForKey:@"jssj"];
    value = [NSDate  dateFormart:value fromFormart:@"yyyyMMddHHmm" toFormart:@"HH:mm"];
    [leftTitleCellView setCellItemValue:value withRow:index++];
    
    
    value = [item objectForKey:@"qpj"];
    value = [NSString stringWithFormat:@"%0.2lf元",[value floatValue]];
    
    [leftTitleCellView setCellItemValue:value withRow:index++];
    
    
    value = [item objectForKey:@"myPrice"];
    if([value floatValue] ==0){
        value = @"----";
        
    }
    else{
        value = [NSString stringWithFormat:@"%0.2lf元",[value floatValue]];
    }
    [leftTitleCellView setCellItemValue:value withRow:index++];
    
    
    
    
    value = [item objectForKey:@"dqj"];
    CGFloat currPrice = [value floatValue];
    //sell company
    value = [item objectForKey:@"myPrice"];
    
    CGFloat myPrice = [value floatValue];
    NSString *statusStr = @"落后";
    if([value floatValue]>=currPrice){
        statusStr = @"领先";
        [leftTitleCellView setValueColorByIndex:index withColor:HexRGB(200, 0, 0)];
    }
    else{
        [leftTitleCellView setValueColorByIndex:index withColor:HexRGB(0, 128, 0)];
    }

    value = [item objectForKey:@"qpj"];
    CGFloat basePrice = [value floatValue];
    if(myPrice<basePrice){
        statusStr = @"未出价";
        [leftTitleCellView setValueColorByIndex:index withColor:[UIColor blackColor]];
    }
    //value = [item objectForKey:@"goodName"];
    [leftTitleCellView setCellItemValue:statusStr withRow:index++];
    
    value = [item objectForKey:@"priceUnit"];
    [leftTitleCellView setCellItemValue:value withRow:index++];
    
    
    value = [NSString stringWithFormat:@"%0.2lf %@",[[item objectForKey:@"weight"]floatValue],[item objectForKey:@"priceUnit"]];
    
    [leftTitleCellView setCellItemValue:value withRow:index++];
    
    
    value = [item objectForKey:@"packages"];
    [leftTitleCellView setCellItemValue:value withRow:index++];
    
    value = [item objectForKey:@"place"];
    [leftTitleCellView setCellItemValue:value withRow:index++];
    
    value = [item objectForKey:@"QS"];
    [leftTitleCellView setCellItemValue:value withRow:index++];
    
    value = [item objectForKey:@"warehouse"];
    [leftTitleCellView setCellItemValue:value withRow:index++];
    
    value = [item objectForKey:@"note"];
    //value = @"撒旦；垃圾开始对尕说；立刻就发生的高考觉得萨流口水；噶蛋糕";
    [leftTitleCellView setCellItemValue:value withRow:index++];
    //@{@"": @"",@"",@""};
    
    
}
-(void)didNetDataFailed:(NSNotification*)ntf
{
    //kNetEndWithErrorAutoDismiss
}
#pragma mark -
#pragma mark -
- (void)bidConfirmAlert:(id)sender{
    int i = [sender tag];
    NSDictionary *item = self.data;
    //currBidItem = item;
    NSString *msg = @"";
    NSString *sessionId = [item objectForKey:@"wtmc"];
    NSString *goodName = [item objectForKey:@"goodName"];
    NSString *price = [item objectForKey:@"dqj"];
    CGFloat currStep = [[item objectForKey:@"bjtd"] floatValue];
    finalPrice = [price floatValue];
    if([price floatValue] == 0.f){
        
        finalPrice = [[item objectForKey:@"qpj"]floatValue];
        //finalPrice = @"---";
        msg = [NSString stringWithFormat:@"请确认是否对下列物资出价\n 场次:%@ \n 品名:%@ \n 出价:%0.2lf元",sessionId,goodName,finalPrice];
    }
    else{
        finalPrice = [price floatValue]+currStep;
        msg = [NSString stringWithFormat:@"请确认是否对下列物资出价\n 场次:%@ \n 品名:%@ \n 出价:%0.2lf元",sessionId,goodName,finalPrice];
    }
    //NSString *msg = [NSString stringWithFormat:@"请确认是否对下列物资出价\n 场次:%@ \n 品名:%@ \n 出价:%0.2f",sessionId,goodName,finalPrice];
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"出价确认" message:msg delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消" , nil];
    alertView.tag = -111;
    [alertView show];
    SafeAutoRelease(alertView);
}

- (void)startBidPrice:(UIButton*)sender{
    
    ////弹出梯度设置框（梯度出价，委托出价）
    CGFloat currPrice = [[self.data objectForKey:@"dqj"]floatValue];
    if(currPrice == 0.f){
        currPrice = [[self.data objectForKey:@"qpj"]floatValue];
    }
    CGFloat stepPrice = [[self.data objectForKey:@"bjtd"]floatValue];
    
    NSInteger index = [sender tag];
    switch (index) {
        case 0:
            
            if(self.isBasePriceBid){
                
                [self bidConfirmAlert:nil];
                
            }
            else
            {
            
            
                /*
                 BidAdjustAlertView *bidAdjustView = [[BidAdjustAlertView alloc]initWithFrame:CGRectMake(0.f, 0.f,300.f,280.f) withHeadTitle:@""];
                 */
                //bidAdjustView.priceModeString =
                bidAdjustView.stepPrice = stepPrice;
                bidAdjustView.basePrice = currPrice;
                [bidAdjustView setHeadTitle:@"出价确认"];
                bidAdjustView.formartStr = @"出价价格为";
                bidAdjustView.priceModeString = @"当前价格";
                [bidAdjustView updateUILayout];
                [bidAdjustView show];
                bidMode = 3;
                
            }
           
            break;
        case 1:
            
            break;
        case 2:
            
            if(bidMode == 2){
                if([bidPriceTextFiled.text floatValue]<currPrice){
                    kUIAlertView(@"提示", @"您出的价格必须要高于或者等于底价");
                    
                    return;
                }
                
                kUIAlertConfirmView(@"提示", @"是否确定出价", @"确定", @"取消");
            }
            else{
                if([sender.titleLabel.text isEqualToString:@"取消委托"]){
                    bidMode = 5;
                    
                    kUIAlertConfirmView(@"提示", @"是否取消委托", @"确定", @"取消");
                }
                else{
                    bidAdjustView.stepPrice = stepPrice;
                    bidAdjustView.basePrice = currPrice;
                    if(self.isBasePriceBid){
                        bidAdjustView.priceModeString = @"起拍价格";
                    }
                    else{
                        bidAdjustView.priceModeString = @"当前价格";
                    }
                    //bidAdjustView.priceModeString =
                    [bidAdjustView setHeadTitle:@"委托出价确认"];
                    bidAdjustView.formartStr = @"委托价格为";
                    [bidAdjustView updateUILayout];
                    [bidAdjustView show];
                    bidMode = 0;
                }
            }
            break;
        default:
            break;
    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == 0){
        NSString *operId = [[AppSetting getLoginUserData:[AppSetting getLoginUserId]] objectForKey:@"czy"];
        
        if(self.bidType == Bid_Prepare){
            NSString *operId = [[AppSetting getLoginUserData:[AppSetting getLoginUserId]] objectForKey:@"czy"];
            NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                                   self.userId,@"hydm",
                                   [self.data objectForKey:@"wtid"],@"wtid",
                                   operId,@"czy",
                                   nil];
            CarServiceNetDataMgr *carServiceNetDataMgr = [CarServiceNetDataMgr getSingleTone];
            self.request = [carServiceNetDataMgr  quitWt4Move:param];
            
        }
        else{
        
            if(bidMode == 2){
                finalPrice = [bidPriceTextFiled.text floatValue];
                
                [self startBid:finalPrice];
            }
            else{
                [self startBid:0.f];
            }
        }
        
    }
    
}

- (void)didClickCancelButton:(id)sender {


}
- (void)didClickOkButton:(id)sender withPrice:(CGFloat)price{

    finalPrice  = price;
    [self startBid:price];

}
- (void)startBid:(CGFloat)price {

    
    CarServiceNetDataMgr *cardShopMgr = [CarServiceNetDataMgr getSingleTone];
    
    //kNetStartShow(@"数据加载...", self.view);
    /*
     NSString *month = [NSString stringWithFormat:@"%02d",self.mCurrDate.month];
     NSString *year = [NSString stringWithFormat:@"%d",self.mCurrDate.year];
     NSString *carId = [AppSetting getUserCarId:[AppSetting getLoginUserId]];
     */
    /*
     
     报价类型
     price
     价格
     id
     拼盘号
     hydm
     
     会员代码
     jjms
     竞价模式
     
     1 公开增价
     2 自由报价
     bpfs
     报盘方式
     
     1 单价
     2 总价
     
     
     
     "委托出价",
     "一口价",
     "自由报价模式出价",
     "公开增价模式出价",
     "公开降价模式出价",
     "取消委托出价"
     分别对应0，1，2，3，4，5，其它
     */
    NSString *operId = [[AppSetting getLoginUserData:[AppSetting getLoginUserId]] objectForKey:@"czy"];
    /*
     NSString *myPrice = [currBidItem objectForKey:@"myPrice"];
     assert(myPrice);
     */
    NSString *bidModeStr = [NSString stringWithFormat:@"%d",bidMode];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.userId,@"hydm",
                           bidModeStr,@"bjlb",
                           [NSString stringWithFormat:@"%lf",finalPrice],@"price",
                           self.goodId,@"id",
                           operId,@"czy",
                           nil];
    
    self.request = [cardShopMgr  saveAuction4MoveDetail:param];

}
-(void)didSelectorTopNavigationBarItem:(id)sender{
    //[super didSelectorTopNavigationBarItem:sender];
    if([sender tag] == 0){
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        [self reflushData];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
  
    return YES;
}
- (void)didchangeTextFiledValue{
    indictorView.text = bidPriceTextFiled.text;
}
- (void)didTapView{
    [bidPriceTextFiled resignFirstResponder];
}
@end
