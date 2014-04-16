//
//  OrderDetailViewController.m
//  BSTell
//
//  Created by cszhan on 14-2-19.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "LeftTitleListCell.h"


#define kPendingX  20.f

#define kPendingY  20.f

/*
 
 */



#define  kOrderTitleArray \
@[@"物资号",\
@"品名",\
@"重量",\
@"金额",\
@"竞价日",\
@"结果",]

#define  kAgreeTitleArray \
@[@"合同号码",\
@"合同性质",\
@"合同状态",\
]
/*
 seller
 卖家
 sellerManager
 卖家负责人
 sellerTel
 卖家电话
 sellerMobile
 卖家手机
 sellerMail
 卖家邮件
 sellerAddr
 卖家地址

 */
#define  kSellerTitleArray \
@[@"卖家",\
@"卖家负责人",\
@"卖家电话",\
@"卖家手机",\
@"卖家邮件",\
@"卖家地址",]

@interface OrderDetailViewController (){

    LeftTitleListCell  *agreementInfoView;
    LeftTitleListCell *sellUserInfoView;
    LeftTitleListCell *orderInfoView;
}
@end

@implementation OrderDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#define kCellValueColorArray @[[UIColor blackColor],[UIColor blueColor],[UIColor greenColor],[UIColor redColor]]

#define kCellValueFontArray  @[[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:16],[UIFont systemFontOfSize:16],[UIFont systemFontOfSize:14]]

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setHiddenRightBtn:YES];
    CGFloat currY = 0.f;
    
    UIScrollView *bgScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0.f, kPendingY+kMBAppTopToolBarHeight,kDeviceScreenWidth,kDeviceScreenHeight-kMBAppBottomToolBarHeght-kMBAppTopToolBarHeight-kMBAppStatusBar-80.f)];
    bgScrollerView.backgroundColor = [UIColor clearColor];
    bgScrollerView.scrollEnabled = YES;
   
    CGFloat width = bgScrollerView.frame.size.width;
    
    
    NSMutableArray *valueArray = [NSMutableArray array];
    for (int i = 0; i<4; i++) {
        NSMutableDictionary *itemDict = [NSMutableDictionary dictionary];
        [itemDict setObject:kCellValueColorArray[i] forKey:@"color"];
        [itemDict setObject:kCellValueFontArray[i] forKey:@"font"];
        [valueArray addObject:itemDict];
    }
    
    
    orderInfoView = [[LeftTitleListCell alloc]initWithFrame:CGRectMake(kPendingX,currY,width,130.f) withTitleArray:kOrderTitleArray withTitle:@"订单信息" withValueAtrArray:valueArray withItemPending:15.f  withOrderCell:YES];
    //s[orderInfoView setYItemPendingY:10.f];
    //[orderInfoView   ];
    [bgScrollerView addSubview:orderInfoView];
    orderInfoView.userInteractionEnabled = NO;
    orderInfoView.backgroundColor = [UIColor clearColor];
    SafeRelease(orderInfoView);
    
    currY = currY+orderInfoView.frame.size.height;
    
#if 1
    UIView *split = [UIComUtil createSplitViewWithFrame:CGRectMake(0.f,currY,kDeviceScreenWidth,1.f) withColor:[UIColor grayColor]];
    [bgScrollerView addSubview:split];
    SafeRelease(split);
    currY = currY+1.f;
#endif
    
    agreementInfoView = [[LeftTitleListCell alloc]initWithFrame:CGRectMake(kPendingX,currY,width,83.f) withTitleArray:kAgreeTitleArray withTitle:@"合同信息" withValueAtrArray:valueArray withItemPending:15.f  withOrderCell:YES];
    //s[orderInfoView setYItemPendingY:10.f];
    //[orderInfoView   ];
    [bgScrollerView addSubview:agreementInfoView];
    agreementInfoView.backgroundColor = [UIColor clearColor];
    agreementInfoView.userInteractionEnabled = NO;
    SafeRelease(agreementInfoView);
    currY = currY+agreementInfoView.frame.size.height;
    
#if 1
    split = [UIComUtil createSplitViewWithFrame:CGRectMake(0.f,currY,kDeviceScreenWidth,1.f) withColor:[UIColor grayColor]];
    [bgScrollerView addSubview:split];
    SafeRelease(split);
    currY = currY+1.f;
#endif

    
    sellUserInfoView = [[LeftTitleListCell alloc]initWithFrame:CGRectMake(kPendingX,currY,width,130.f) withTitleArray:kSellerTitleArray withTitle:@"卖家信息" withValueAtrArray:valueArray withItemPending:15.f  withOrderCell:YES];
    //s[orderInfoView setYItemPendingY:10.f];
    //[orderInfoView   ];
    [bgScrollerView addSubview:sellUserInfoView];
     sellUserInfoView.userInteractionEnabled = NO;
    sellUserInfoView.backgroundColor = [UIColor clearColor];
    SafeRelease(sellUserInfoView);
    
    currY = currY+sellUserInfoView.frame.size.height;
    
#if 0
    split = [UIComUtil createSplitViewWithFrame:CGRectMake(0.f,currY,kDeviceScreenWidth,1.f) withColor:[UIColor grayColor]];
    [bgScrollerView addSubview:split];
    SafeRelease(split);
    currY = currY+1.f;
#endif
    currY = currY+sellUserInfoView.frame.size.height;
    
    bgScrollerView.contentSize = CGSizeMake(bgScrollerView.frame.size.width, currY);
    [self.view addSubview:bgScrollerView];
    SafeRelease(bgScrollerView);
    
    currY = bgScrollerView.frame.size.height+bgScrollerView.frame.origin.y+5.f;
    
    LeftTitleListCell *confirmStatusView = [[LeftTitleListCell alloc]initWithFrame:CGRectMake(kPendingX,currY,width,130.f) withTitleArray:@[] withTitle:@"状态" withValueAtrArray:@[] withItemPending:15.f ];
    //s[orderInfoView setYItemPendingY:10.f];
    //[orderInfoView   ];
    [self.view addSubview:confirmStatusView];
    confirmStatusView.userInteractionEnabled = NO;
    confirmStatusView.backgroundColor = [UIColor clearColor];
    SafeRelease(confirmStatusView);
    NSString *strTitle = @"到货确认";
    if(self.isConfirmTag){
       strTitle = @"已确认";
    }
    UIButton *bidBtn = [UIComUtil createButtonWithNormalBGImageName:@"bid_price_btn.png" withHightBGImageName:@"bid_price_btn.png" withTitle:strTitle withTag:0];
    [self.view  addSubview:bidBtn];
    bidBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [bidBtn addTarget:self action:@selector(startConfirmOrderStatus:) forControlEvents:UIControlEventTouchUpInside];
    bidBtn.frame = CGRectMake(kDeviceScreenWidth-20.f-bidBtn.frame.size.width,currY, bidBtn.frame.size.width, bidBtn.frame.size.height);
    
    
}

- (void)startConfirmOrderStatus:(id)sender{

    if(self.isConfirmTag)
        return;
    kUIAlertConfirmView(@"提示", @"您确定到货确认后，将释放您的竞买保证金", @"确定", @"取消");


}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if(buttonIndex == 0){
        [self didConfirmClickConfirmFunction];
    }
    
}
- (void)didConfirmClickConfirmFunction{
    
    NSDictionary *param  = nil;
    CarServiceNetDataMgr *carServiceNetDataMgr = [CarServiceNetDataMgr getSingleTone];
    {
        /*
         fphm
         合同号
         kplb
         交易类型
         hzfs
         结算方式
         lx
         到款状态
         dhczy
         操作员
         
         */
        
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 //self.orderId,@"orderId",
                 [self.orderItem objectForKey:@"fphm"],@"fphm",
                 self.userId,@"dhczy",
                 nil];
        self.request = [carServiceNetDataMgr  updateStatus4Move:param];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark -net
- (void)shouldLoadData{
    
    NSDictionary *param  = nil;
    CarServiceNetDataMgr *carServiceNetDataMgr = [CarServiceNetDataMgr getSingleTone];
    {
        /*
         公告ID	ggid
         会员代码	hydm
         */
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 self.orderId,@"orderId",
                 //@"1",@"zc",
                 //@"",@"wtzt",
                 //@"001",@"hydm",
                 //@"10",@"limit",
                 //@"",@"rqStart",
                 //@"",@"rqEnd",
                 nil];
        self.request = [carServiceNetDataMgr  getOrderDetail:param];
    }
}
-(void)didNetDataOK:(NSNotification*)ntf
{
    [super didNetDataOK:ntf];
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];//[respRequest resourceKey];
    //NSString *resKey = [respRequest resourceKey];
    if([resKey isEqualToString:kCarUserOrderDetail])
    {
        //        if ([self.externDelegate respondsToSelector:@selector(commentDidSendOK:)]) {
        //            [self.externDelegate commentDidSendOK:self];
        //        }
        //        kNetEndSuccStr(@"评论成功",self.view);
        //        [self dismissModalViewControllerAnimated:YES];
        
        //[self reloadNetData:data];
        
        [self performSelectorOnMainThread:@selector(updateUIData:) withObject:data waitUntilDone:NO];
        
    }
    if([resKey isEqualToString:kResUserOrderConfirm]){
    
//        if([[data objectForKey:@"result"] intValue]){
//           kUIAlertView(@"提示",@"确认成功")
//        }
        //kUIAlertView(<#y#>, <#x#>)
        //[self dismissModalViewControllerAnimated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)updateUIData:(NSDictionary*)netData{
    
    kNetEnd(self.view);
    
    /*
   
     
     seller
     卖家
     
     sellerManager
     卖家负责人
     
     sellerTel
     卖家电话
     
     sellerMobile
     卖家手机
     
     sellerMail
     卖家邮件
     
     sellerAddr
     卖家地址
     
    
     
     
     

     */
    
    /*
     goodId
     物资号
     
     goodName
     品名
     
     weight
     重量
     
     acutionState
     订单状态（是否确认收货）
     
     turnover
     成交金额
     auctionDate
     竞价日
     result
     订单结果
     */
    
    NSInteger index = 0;
    NSString *value = nil;
    value = [netData objectForKey:@"goodId"];
    [orderInfoView setCellItemValue:value withRow:index++];
    value = [netData objectForKey:@"goodName"];
    [orderInfoView setCellItemValue:value withRow:index++];
    value = [netData objectForKey:@"weight"];
    value = [NSString stringWithFormat:@"%0.2lf 吨",[value floatValue]];
    [orderInfoView setCellItemValue:value withRow:index++];
    value = [netData objectForKey:@"turnover"];
    value = [NSString stringWithFormat:@"%0.2lf 元",[value floatValue]];
    [orderInfoView setCellItemValue:value withRow:index++];
    value = [netData objectForKey:@"auctionDate"];
    value = [NSDate  dateFormart:value fromFormart:@"yyyyMMdd" toFormart:@"yyyy-MM-dd"];
    [orderInfoView setCellItemValue:value withRow:index++];
    value = [netData objectForKey:@"acutionStatus"];
    //[orderInfoView setCellItemValue:value withRow:index++];
    /*
     
     0：卖家未到款确认
     1：已完成
     2：卖家已到款确认
     */
    
    
    NSString *relResult = @"已完成";
    if([value intValue] == 0){
        relResult = @"卖家未到款确认";
    }
    else if([value intValue] == 2){
    
         relResult = @"卖家已到款确认";
    }
    [orderInfoView setCellItemValue:relResult withRow:index++];
    
    index = 0;
    /*
     fphm
     合同号
     
     agreementProperty
     合同性质
     
     agreementState
     状态
     */
   
    value = [netData objectForKey:@"fphm"];
    [agreementInfoView setCellItemValue:value withRow:index++];
    value = [netData objectForKey:@"agreementProperty"];
    NSString *strValue = @"其他";
    if([value intValue]== 3){
    
        strValue = @"场外结算";
    }
    
    [agreementInfoView setCellItemValue:strValue withRow:index++];
    value = [netData objectForKey:@"agreementState"];
    strValue = @"未生效";
    if([value intValue]== 2){
        
        strValue = @"生效";
    }
    
    [agreementInfoView setCellItemValue:strValue withRow:index++];
    index = 0;
    /*
     seller
     卖家
     
     sellerManager
     卖家负责人
     
     sellerTel
     卖家电话
     
     sellerMobile
     卖家手机
     
     sellerMail
     卖家邮件
     
     sellerAddr
     卖家地址
     
   

     */
    value = [netData objectForKey:@"seller"];
    [sellUserInfoView setCellItemValue:value withRow:index++];
    value = [netData objectForKey:@"sellerManager"];
    [sellUserInfoView setCellItemValue:value withRow:index++];
    value = [netData objectForKey:@"sellerTel"];
    [sellUserInfoView setCellItemValue:value withRow:index++];
    value = [netData objectForKey:@"sellerMobile"];
    [sellUserInfoView setCellItemValue:value withRow:index++];
    value = [netData objectForKey:@"sellerMail"];
    [sellUserInfoView setCellItemValue:value withRow:index++];
    value = [netData objectForKey:@"sellerAddr"];
    [sellUserInfoView setCellItemValue:value withRow:index++];
   
}

@end
