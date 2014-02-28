//
//  BidItemDetailViewController.m
//  BSTell
//
//  Created by cszhan on 14-2-9.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "BidItemDetailViewController.h"
#import "LeftTitleListCell.h"

#define kLeftPendingX  10

#define kItemPendingY   @20

@interface BidItemDetailViewController (){

    LeftTitleListCell *leftTitleCellView;
    
    UILabel     *currBidPriceLabel;
    UILabel     *bidStepPriceLabel;
    UILabel     *delegateBidPriceLabel;
    
    UITextField *customBidPriceTextFiled;
    
    UIButton *bidStatusBtn;

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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setHiddenRightBtn:YES];
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
    UIScrollView *confirmTextBgView = [[UIScrollView alloc] initWithFrame:CGRectMake(kLeftPendingX, currY, image.size.width/kScale, kDeviceScreenHeight-kMBAppBottomToolBarHeght-kMBAppTopToolBarHeight-kMBAppStatusBar-buttomHeight)];
    confirmTextBgView.bounces = NO;
    
    confirmTextBgView.layer.contents = (id)image.CGImage;
    
    //confirmTextBgView.frame = CGRectMake(10, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
#else
    UIImageView *confirmTextBgView = [[UIImageView alloc]initWithFrame:CGRectMake(kLeftPendingX, currY, image.size.width/kScale, image.size.height/kScale)];
    confirmTextBgView.image = image;
    confirmTextBgView.userInteractionEnabled = YES;
#endif
    /*
    */
    leftTitleCellView = [[LeftTitleListCell alloc] initWithFrame:CGRectMake(10.f, 0.f, 300.f, 350.f) withTitleArray:@[                                                       @"场次",
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

    [self.view addSubview:confirmTextBgView];
    SafeRelease(confirmTextBgView);
    
    confirmTextBgView.contentSize = leftTitleCellView.frame.size;
    
    
    currY = currY+confirmTextBgView.frame.size.height;
    
    
    
    
    currY = currY+5.f;
    
    currBidPriceLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:14] withTextColor:[UIColor blackColor] withText:@"当前价:--" withFrame:CGRectMake(kLeftPendingX, currY, 120.f, 20.f)];
    currBidPriceLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:currBidPriceLabel];
    SafeRelease(currBidPriceLabel);
    
    bidStepPriceLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:14] withTextColor:[UIColor blackColor] withText:@"竞价梯度:--" withFrame:CGRectMake(kLeftPendingX+160.f, currY, 140.f, 20.f)];
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
    delegateBidPriceLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:14] withTextColor:[UIColor greenColor] withText:@"当前委托:--" withFrame:CGRectMake(kLeftPendingX+160.f, currY, 140.f, 20.f)];
    
    delegateBidPriceLabel.textAlignment = NSTextAlignmentRight;
    
    [self.view addSubview:delegateBidPriceLabel];
    SafeRelease(delegateBidPriceLabel);
    
    
    currY = currY+15.f;
    
    UIButton *bidBtn = [UIComUtil createButtonWithNormalBGImageName:@"bid_price_btn.png" withHightBGImageName:@"bid_price_btn.png" withTitle:@"梯度出价" withTag:0];
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
        
        
        
        [self performSelectorOnMainThread:@selector(updateUIData:) withObject:data waitUntilDone:NO];
        
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
    currBidPriceLabel.text = [NSString stringWithFormat:@"当前价:%0.2lf",[value floatValue]];
    
    value = [item objectForKey:@"bjtd"];
    bidStepPriceLabel.text = [NSString stringWithFormat:@"竞价梯度:%0.2lf",[value floatValue]];
    
    value = [item objectForKey:@"wtprice"];
    delegateBidPriceLabel.text = [NSString stringWithFormat:@"当前委托:%0.2lf",[value floatValue]];
    
    value = [item objectForKey:@"wtprice"];
    if([value isEqualToString:@"0"]){
        self.isDelegate = NO;
        [bidStatusBtn setTitle:@"取消委托" forState:UIControlStateNormal];
        [bidStatusBtn setTitle:@"取消委托" forState:UIControlStateSelected];
    }
    else{
        
        [bidStatusBtn setTitle:@"委托出价" forState:UIControlStateNormal];
        [bidStatusBtn setTitle:@"委托出价" forState:UIControlStateSelected];
        
    }
     value = [item objectForKey:@"wtmc"];
    [leftTitleCellView setCellItemValue:value withRow:index++];
    
    value = [item objectForKey:@"goodName"];
    [leftTitleCellView setCellItemValue:value withRow:index++];
    
    
    value = [item objectForKey:@"auctionStatus"];
    if([value intValue] == 1){
        [leftTitleCellView setCellItemValue:@"竞价中" withRow:index++];
    }
    else{
    
        [leftTitleCellView setCellItemValue:@"完成" withRow:index++];
    }
    
    value = [item objectForKey:@"jssj"];
    [leftTitleCellView setCellItemValue:value withRow:index++];
    
    
    value = [item objectForKey:@"qpj"];
    [leftTitleCellView setCellItemValue:value withRow:index++];
    
    
    value = [item objectForKey:@"myPrice"];
    [leftTitleCellView setCellItemValue:value withRow:index++];
    
    
    
    
    value = [item objectForKey:@"dqj"];
    CGFloat currPrice = [value floatValue];
    //sell company
    value = [item objectForKey:@"myPrice"];
    NSString *statusStr = @"落后";
    if([value floatValue]>=currPrice){
        statusStr = @"领先";
        
    }

    
    //value = [item objectForKey:@"goodName"];
    [leftTitleCellView setCellItemValue:statusStr withRow:index++];
    
    value = [item objectForKey:@"priceUnit"];
    [leftTitleCellView setCellItemValue:value withRow:index++];
    
    
    value = [NSString stringWithFormat:@"%@ %@",[item objectForKey:@"weight"],[item objectForKey:@"unit"]];
    
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
    [leftTitleCellView setCellItemValue:value withRow:index++];
    //@{@"": @"",@"",@""};
    
    
}
-(void)didNetDataFailed:(NSNotification*)ntf
{
    //kNetEndWithErrorAutoDismiss
}
#pragma mark -
#pragma mark -

- (void)startBidPrice:(id)sender{
    
    ////弹出梯度设置框（梯度出价，委托出价）
    
    NSInteger index = [sender tag];
    switch (index) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            break;
        default:
            break;
    }

}
@end
