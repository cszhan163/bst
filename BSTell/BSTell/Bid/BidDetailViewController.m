//
//  BidDetailViewController.m
//  BSTell
//
//  Created by cszhan on 14-2-1.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "BidDetailViewController.h"
#import "BidDetailTableViewCell.h"
#import "BidConfirmViewController.h"

#import "BidMainViewController.h"

#import "BidDetailTableViewCell_V2.h"

#import  "GoodsItemDetailViewController.h"

#define kOld    0

#define kLeftPendingX 25.f



#define kMaxItemClounm 3

#if kOld
#define kHeaderColounmItemWidthArray @[@100.f,@100.f,@100.f]

#define kTableColounmItemWidthArray @[@110.f,@65.f,@65.f,@65.f]

#define kCellHeight  18.f;

#else
#define kHeaderColounmItemWidthArray @[\
                                        @[@90.f,@170.f,@0.f],\
                                        @[@90.f,@85.f,@85.f],\
                                        @[@130.f,@130.f,@0.f]]

#define kTableColounmItemWidthArray @[@110.f,@65.f,@65.f,@65.f]

#define kCellHeight  18.f;
#endif


#define kCellTitleColorArray @[[UIColor blackColor],[UIColor blackColor],[UIColor blackColor],[UIColor blackColor],[UIColor blackColor],[UIColor blackColor]]

#define kCellTitleFontArray  @[[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:14]]


#define kCellValueColorArray @[[UIColor blackColor],[UIColor blackColor],[UIColor blackColor],[UIColor blackColor],[UIColor blackColor],[UIColor blackColor]]

#define kCellValueFontArray  @[[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:14]]


#define kCellItemHeightArray @[@20.f,@20.f,@20.f,@20.f,@20.f,@20.f]



@interface BidDetailViewController (){

    BidDetailTableViewCell *headerView;
    UIButton            *oilAnalaysisBtn;
    UIScrollView *bgGoodsView;
    BOOL canLoger;
}
@end

@implementation BidDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        canLoger = YES;
    }
    return self;
}
- (void)setNavgationBarRightButton{
    
    UIImageWithFileName(UIImage *bgImage, @"bid_btn.png");
    CGRect newRect = CGRectMake(kDeviceScreenWidth-30.f-bgImage.size.width/2.f, 10.f, bgImage.size.width/kScale, bgImage.size.height/kScale);
    self.rightBtn.frame = newRect;
    [self.rightBtn setBackgroundImage:bgImage forState:UIControlStateNormal];
    [self.rightBtn setBackgroundImage:bgImage forState:UIControlStateSelected];
    [self.rightBtn setTitle:@"竞价大厅" forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"竞价大厅" forState:UIControlStateHighlighted];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:13];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self setHiddenRightBtn:YES];
    
    [self setNavgationBarRightButton];
    
	// Do any additional setup after loading the view.
    
    /*
    tweetieTableView.dataSource = nil;
    tweetieTableView.delegate = nil;
    tweetieTableView.hidden = YES;
    */
    //add headerview;
    CGFloat currY = kMBAppTopToolBarHeight+5.f;
    UIImageWithFileName(UIImage *image , @"bid_detail_header.png");
    
    if([[self.data objectForKey:@"isCanJoin"]intValue]){
        canLoger = NO;
    }
    else{
        canLoger = YES;
    }

    
#if kOld
    headerView = [[BidDetailTableViewCell alloc]initWithFrame:CGRectMake(kLeftPendingX, currY,image.size.width/kScale, image.size.height/kScale) withRowCount:2 withColumCount:3 withCellHeight:20 withHeaderTitle:@"场次信息"];
    
    [headerView setHeaderLabelText:@"场次信息"];
    [headerView addColumWithKeyTitleArray:@[@"场次编号",@"场次名称",@"参与方式"] withColumWidthArray:kHeaderColounmItemWidthArray];
    
    [headerView addColumWithKeyTitleArray:@[@"竞价日",@"开始时间",@"结束时间"] withColumWidthArray:kHeaderColounmItemWidthArray];
    
    headerView.layer.contents = (id)image.CGImage;
    [self.view addSubview:headerView];
    SafeRelease(headerView);
     currY = 195.f;
    CGFloat goodViewHeight = 170.f;
    if(kDeviceCheckIphone5){
        goodViewHeight = goodViewHeight+80.f;
    }
#else
    currY = currY-5.f;
    headerView = [[BidDetailTableViewCell alloc]initWithIIFrame:CGRectMake(kLeftPendingX, currY,image.size.width/kScale, image.size.height/kScale) withRowCount:3 withColumCount:3 withCellHeight:20.f withHeaderTitle:@"场次信息"];
    
    [headerView setHeaderLabelText:@""];
    [headerView addColumIIWithKeyTitleArray:@[@"",@"",@""] withColumWidthArray:kHeaderColounmItemWidthArray[0]];
    
    [headerView addColumIIWithKeyTitleArray:@[@"",@"",@""] withColumWidthArray:kHeaderColounmItemWidthArray[1]];
    
    [headerView addColumIIWithKeyTitleArray:@[@"",@"",@""] withColumWidthArray:kHeaderColounmItemWidthArray[2]];
    
    headerView.layer.contents = (id)image.CGImage;
    [self.view addSubview:headerView];
    SafeRelease(headerView);
    currY = 200.f;
    
    CGFloat goodViewHeight = 150.f;
    if(canLoger && 0){
        goodViewHeight = goodViewHeight+40.f;
    }
    if(kDeviceCheckIphone5){
        goodViewHeight = goodViewHeight+80.f;
    }
    
#endif
    
    bgGoodsView = [[UIScrollView alloc]initWithFrame:CGRectMake(0.f,currY,kDeviceScreenWidth, goodViewHeight)];
    
    [self.view addSubview:bgGoodsView];
    
    SafeRelease(bgGoodsView);
    //if(!canLoger)
    {
        
        [self addFonterView];
    }
   

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setJoinButtonHiddenStatus:(BOOL)status{
    oilAnalaysisBtn.hidden = status;
}
- (void)addFonterView{
    
    //    logInfo.frame = CGRectMake(0,kMBAppTopToolBarHeight-self.mainContentViewPendingY,kDeviceScreenWidth,kDeviceScreenHeight-kMBAppTopToolBarHeight-kMBAppStatusBar-kMBAppBottomToolBarHeght- 60 );
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0.f,0.f,300.f,80)];
    bgView.backgroundColor = HexRGB(202, 202, 204);
    NSString *showTitle =  @"参加竞价";
    if(canLoger){
        showTitle =  @"退出竞价";
    }
    CGFloat currY = kDeviceScreenHeight-kMBAppTopToolBarHeight-kMBAppStatusBar-kMBAppBottomToolBarHeght- 60+10.f;
    oilAnalaysisBtn = [UIComUtil createButtonWithNormalBGImageName:@"bid_start_btn.png" withHightBGImageName:@"bid_start_btn.png" withTitle:showTitle withTag:0];
    
    CGSize btnsize= oilAnalaysisBtn.frame.size;
    btnsize = CGSizeMake(btnsize.width-20, btnsize.height);
    //currY = 10.f;
    currY = currY+40.f;
     oilAnalaysisBtn.frame = CGRectMake((kDeviceScreenWidth-btnsize.width)/2.f,currY,btnsize.width,btnsize.height);
    [oilAnalaysisBtn addTarget:self action:@selector(logOutConfirm:) forControlEvents:UIControlEventTouchUpInside];
    //[logInfo addSubview:oilAnalaysisBtn];
    //
#if 1
    [self.view addSubview:oilAnalaysisBtn];
    
#else
   
    [bgView addSubview:oilAnalaysisBtn];
    [tweetieTableView setTableFooterView:bgView];
#endif
   
}
#pragma mark -
#pragma mark tableView dataSource
//- (NSInteger)tableView:(UITableView *)tableView section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
    return 2;
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if(indexPath.row == 1){
    
        return 127.f;
    }
    return  263.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  0.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *LabelTextFieldCell = @"LabelTextFieldCell";
	
	UITableViewCell *cell = nil;
    
    //[KokTool endTimeCheckPoint:@"tableViewCell"];
    
	cell = [tableView dequeueReusableCellWithIdentifier:LabelTextFieldCell];
	
    return cell;
    
}
- (void)logOutConfirm:(id)sender{

    if(canLoger){
      kUIAlertConfirmView(@"提示", @"是否确认退出竞价", @"确定", @"取消");
    }
    else{
        BidConfirmViewController *bidConfirmVc = [[BidConfirmViewController alloc]init];
        bidConfirmVc.wtid = self.wtid;
        [self.navigationController pushViewController:bidConfirmVc animated:YES];
        
        SafeRelease(bidConfirmVc);
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == 0){
        
        NSString *operId = [[AppSetting getLoginUserData:[AppSetting getLoginUserId]] objectForKey:@"czy"];
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                               self.userId,@"hydm",
                               self.wtid,@"wtid",
                               operId,@"czy",
                               nil];
        CarServiceNetDataMgr *carServiceNetDataMgr = [CarServiceNetDataMgr getSingleTone];
        self.request = [carServiceNetDataMgr  quitWt4Move:param];
        
        
    }
    
}

#pragma mark-
#pragma mark -net data
- (void) shouldLoadData{
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           //catStr,@"cat",
                           //@"001",@"hydm",
                           [self.data objectForKey:@"wtid"],@"wtid",
                           nil];
    CarServiceNetDataMgr *carServiceNetDataMgr = [CarServiceNetDataMgr getSingleTone];
    self.request = [carServiceNetDataMgr  getAuctionWtInfo:param];
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
        
        self.data = data;
        [self performSelectorOnMainThread:@selector(updateUIData:) withObject:data waitUntilDone:NO];
        
    }
    if([resKey isEqualToString:kResBidQuit]){
         if([[data objectForKey:@"result"]intValue] == 1){
             kUIAlertView(@"提示", @"退出竞价成功");
             [self.navigationController popViewControllerAnimated:YES];
         }
    }
    
    //self.view.userInteractionEnabled = YES;
}
- (void)addTableCellView:(NSDictionary*)netData{
    NSArray *dataArray = [self.data objectForKey:@"data"];
    UIImageWithFileName(UIImage *image , @"bid_detail_table.png");
    //CGRect rect = headerView.frame;
    CGFloat currY = bgGoodsView.frame.origin.y;
    CGRect headRect = CGRectMake(kLeftPendingX,currY,kDeviceScreenWidth-2*kLeftPendingX,40);
    UILabel *headerLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:16] withTextColor:[UIColor blackColor] withText:@"物资信息" withFrame:headRect];
    headerLabel.backgroundColor = [UIColor whiteColor];
    [self.view  addSubview:headerLabel];
    //headerLabel.backgroundColor = [UIColor blueColor];
    SafeRelease(headerLabel);
    CGRect rect = bgGoodsView.frame;
    
    bgGoodsView.frame = CGRectMake(rect.origin.x, rect.origin.y+40.f, rect.size.width,rect.size.height-40.f);
    
    currY = 0.f;
    
    for(int i = 0;i<[dataArray count];i++){
        NSDictionary *itemData = dataArray[i];
 #if kOld
//     BidDetailTableViewCell   *tableView = [[BidDetailTableViewCell alloc]initWithFrame:CGRectMake(kLeftPendingX, currY,image.size.width/kScale, image.size.height/kScale) withRowCount:5 withColumCount:4 withCellHeight:20 withHeaderTitle:@"物资信息"];
//        tableView.layer.contents = (id)image.CGImage;
//        /*
//         物资编号
//         竞价模式
//         报盘方式
//         计价方式
//         起拍价
//         总量
//         拼盘梯度
//         成交价
//         竞价状态
//         品名
//         包装
//         产地
//         仓库
//         重量
//         计量单位
//         付款方式
//         提货方式
//         交货时间
//         质量标准
//         备注
//         */
//        
//
//        [tableView addColumWithKeyTitleArray:@[@"物资编号",@"竞价模式",@"报盘方式",@"计价方式"] withColumWidthArray:kTableColounmItemWidthArray];
//        
//        [tableView addColumWithKeyTitleArray:@[@"起拍价",@"总量",@"竞价梯度",@"成交价"] withColumWidthArray:kTableColounmItemWidthArray];
//        /*
//         @"竞价状态",
//         @"品名",
//         @"包装",
//         @"产地",
//         */
//        [tableView addColumWithKeyTitleArray:@[@"竞价状态",
//                                               @"品名",
//                                               @"包装",
//                                               @"产地"
//                                               ] withColumWidthArray:kTableColounmItemWidthArray];
//        
//        /*
//         @"仓库",
//         @"重量",
//         @"计量单位",
//         @"付款方式",
//         */
//        [tableView addColumWithKeyTitleArray:@[@"仓库",
//                                               @"重量",
//                                               @"计量单位",
//                                               @"付款方式"
//                                               ] withColumWidthArray:kTableColounmItemWidthArray];
//        
//        /*
//         @"提货方式",
//         @"交货时间",
//         @"质量标准",
//         @"备注",
//         */
//        
//        [tableView addColumWithKeyTitleArray:@[@"提货方式",
//                                               @"交货时间",
//                                               @"质量标准",
//                                               @"备注"
//                                               ] withColumWidthArray:kTableColounmItemWidthArray];
//
//        [self setTableCellView:tableView byData:itemData];
#else
     
//        BidDetailTableViewCell   *tableView = [[BidDetailTableViewCell alloc]initWithCustomFrame:CGRectMake(kLeftPendingX, currY,image.size.width/kScale, image.size.height/kScale) withRowCount:5 withColumCount:4 withCellHeight:20 withHeaderTitle:@""];
//        tableView.layer.contents = (id)image.CGImage;
//       
//        CGFloat cellHeight = 20.f;
//        
//        [tableView addColumWithKeyTitleArray:@[@"",
//                                               ]withColumWidthArray:@[@260]
//                          withKeyTitleHeight:30 withValueHeight:25];
//        
//        
//        [tableView addColumWithKeyTitleArray:@[@"",@"",@""
//                                               ]withColumWidthArray:@[@145,
//                                                                      @60,@55]
//                          withKeyTitleHeight:cellHeight withValueHeight:cellHeight];
//        
//        [tableView addColumWithKeyTitleArray:@[@"",@"",@"",@""
//                                               ]withColumWidthArray:@[@90,
//                                                                      @55,@55,@60]
//                          withKeyTitleHeight:cellHeight withValueHeight:cellHeight];
//        [tableView addColumWithKeyTitleArray:@[@"",@"",@"",@""
//                                               ]withColumWidthArray:@[@90,
//                                                                      @60,@50,@60]
//                          withKeyTitleHeight:cellHeight withValueHeight:cellHeight];
//        
//        [tableView addColumWithKeyTitleArray:@[@"",@""
//                                               ]withColumWidthArray:@[@145,
//                                                                      @115]
//                          withKeyTitleHeight:cellHeight withValueHeight:cellHeight];
//
//
        
     
        
        NSMutableArray *titleArray = [NSMutableArray array];
        
        NSMutableArray *valueArray = [NSMutableArray array];
        for (int i = 0; i<[kCellTitleColorArray count]; i++) {
            NSMutableDictionary *itemDict = [NSMutableDictionary dictionary];
            [itemDict setObject:kCellTitleColorArray[i] forKey:@"color"];
            [itemDict setObject:kCellTitleFontArray[i] forKey:@"font"];
            [titleArray addObject:itemDict];
        }
        
        for (int i = 0; i<[kCellValueColorArray count]; i++) {
            NSMutableDictionary *itemDict = [NSMutableDictionary dictionary];
            [itemDict setObject:kCellValueColorArray[i] forKey:@"color"];
            [itemDict setObject:kCellValueFontArray[i] forKey:@"font"];
            [valueArray addObject:itemDict];
        }
        
        BidDetailTableViewCell_V2 *tableView = [[BidDetailTableViewCell_V2 alloc]initWithFrame:CGRectMake(kLeftPendingX,currY,kDeviceScreenWidth-2*kLeftPendingX,130.f) withHeaderTitle:@"物资信息"
                                                                                withTitleArray:@[
                                                                                                 @"物资编号",
                                                                                                 @"品名",
                                                                                                 @"重量",
                                                                                                 @"起拍价",
                                                                                                 @"竞价梯度",
                                                            ]
                                                                       withTitleAttributeArray:titleArray
                                                                       withValueAttributeArray:valueArray
                                                                               withHeightArray:kCellItemHeightArray];
        
        
        [self setTableCellView:tableView byData:itemData];
        tableView.tag = i;

#endif
        [bgGoodsView addSubview:tableView];
        SafeRelease(tableView);
        currY = currY+150.f;
    }
    bgGoodsView.contentSize = CGSizeMake(kDeviceScreenWidth, currY);
}
- (void)setTableHeaderViewByData:(NSDictionary*)netData{
    int index = 0;
    int row = 0;
    NSString *value = @"";
    /*
     ggmc	场次名称
     joinWay	参与方式
     auctionDate	竞价日
     kssj	开始时间
     jssj	结束时间
     */
    value = self.wtid;//[self.data objectForKey:@"wtid"];
    [headerView setCellItemValue:self.wtid withRow:row withCol:index++];
    
    value = [netData objectForKey:@"wtmc"];
    [headerView setCellItemValue:value withRow:row withCol:index++];
    
    
    
    index = 0;
    row++;
    value = [netData objectForKey:@"auctionDate"];
    
    value = [NSDate  dateFormart:value fromFormart:@"yyMMdd" toFormart:@"yyyy-MM-dd"];
    
    [headerView setCellItemValue:value withRow:row withCol:index++];
    
    value = [netData objectForKey:@"joinWay"];
    NSString *joinStr = @"定向";
    if([value intValue] == 0){
        joinStr = @"不定向";
    }
    [headerView setCellItemValue:joinStr withRow:row withCol:index++];
    
    value = [netData objectForKey:@"kssj"];
    NSString *startStr = [NSDate  dateFormart:value fromFormart:@"yyyyMMddHHmm" toFormart:@"HH:mm"];
    //[headerView setCellItemValue:value withRow:row withCol:index++];
    
    value = [netData objectForKey:@"jssj"];
    NSString *endStr = [NSDate  dateFormart:value fromFormart:@"yyyyMMddHHmm" toFormart:@"HH:mm"];
    
    [headerView setCellItemValue:[NSString stringWithFormat:@"%@-%@",startStr,endStr] withRow:row withCol:index++];
    
    index = 0;
    row++;
    
    
    NSArray *itemsArray = [netData objectForKey:@"data"];
    value = [itemsArray[0] objectForKey:@"auctionMode"];
    NSString *valueStr = @"自由报价";
    if([value intValue] == 1){
        valueStr = @"公开增价";
    }
    [headerView setCellItemValue:valueStr withRow:row withCol:index++];
    
    value = [itemsArray[0] objectForKey:@"offerWay"];
    
    valueStr = @"总价";
    if([value intValue] == 1){
        valueStr = @"单价";
    }
    
    [headerView setCellItemValue:valueStr withRow:row withCol:index++];
    
    
}
- (void)setTableCellView:(BidDetailTableViewCell_V2*)tableView byData:(NSDictionary*)netData{
    
    int index = 0;
    int row = 0;
    NSString *value = @"";
    
#if kOld
    /*
     goodId
     auctionMode
     offerWay
     pricingWay
     */
    index = 0;
    row = 0;
    //netData = [[netData objectForKey:@"data"]objectAtIndex:0];
    value = [netData objectForKey:@"goodId"];
    [tableView setCellItemValue:value withRow:0 withCol:index++];
    
    value = [netData objectForKey:@"auctionMode"];
    NSString *valueStr = @"自由报价";
    if([value intValue] == 1){
        valueStr = @"公开增价";
    }
    [tableView setCellItemValue:valueStr withRow:0 withCol:index++];
    
    value = [netData objectForKey:@"offerWay"];
    
    valueStr = @"总价";
    if([value intValue] == 1){
        valueStr = @"单价";
    }
    
    [tableView setCellItemValue:valueStr withRow:0 withCol:index++];
    
    
    
    value = [netData objectForKey:@"pricingWay"];
    [tableView setCellItemValue:value withRow:0 withCol:index++];
    /*
     
     startPrice
     totalCount
     bjtd
     soldPrice
     */
    
    index = 0;
    row++;
    value = [netData objectForKey:@"startPrice"];
    value = [NSString stringWithFormat:@"%0.2lf 元",[value floatValue]];
    [tableView setCellItemValue:value withRow:row withCol:index++];
    
    value = [netData objectForKey:@"totalCount"];
    [tableView setCellItemValue:value withRow:row withCol:index++];
    
    value = [netData objectForKey:@"bjtd"];
    value = [NSString stringWithFormat:@"%0.2lf 元",[value floatValue]];
    [tableView setCellItemValue:value withRow:row withCol:index++];
    
    value = @"";//[netData objectForKey:@"soldPrice"];
    [tableView setCellItemValue:value withRow:row withCol:index++];
    
    /*
     auctionStatus
     goodName
     package
     place
     */
    index = 0;
    row++;
    value = [netData objectForKey:@"auctionStatus"];
    NSString *statusStr = @"";
    if([value intValue] == 1){
        statusStr = @"未开始";
    }
    else{
        statusStr = @"已开始";
    }
    [tableView setCellItemValue:statusStr withRow:row withCol:index++];
    
    value = [netData objectForKey:@"goodName"];
    [tableView setCellItemValue:value withRow:row withCol:index++];
    
    value = [netData objectForKey:@"package"];
    [tableView setCellItemValue:value withRow:row withCol:index++];
    value = [netData objectForKey:@"place"];
    [tableView setCellItemValue:value withRow:row withCol:index++];
    
    /*
     warehouse
     weight
     unit
     payment
     */
    index = 0;
    row++;
    value = [netData objectForKey:@"warehouse"];
    [tableView setCellItemValue:value withRow:row withCol:index++];
    
    value = [netData objectForKey:@"weight"];
    value = [NSString stringWithFormat:@"%0.2lf吨",[value floatValue]];
    [tableView setCellItemValue:value withRow:row withCol:index++];
    
    value = [netData objectForKey:@"unit"];
    [tableView setCellItemValue:value withRow:row withCol:index++];
    value = [netData objectForKey:@"payment"];
    [tableView setCellItemValue:value withRow:row withCol:index++];
    
    /*
     
     deliveryWay
     deliveryTime
     QS
     note
     */
    index = 0;
    row++;
    value = [netData objectForKey:@"deliveryWay"];
    [tableView setCellItemValue:value withRow:row withCol:index++];
    
    value = [netData objectForKey:@"deliveryTime"];
    [tableView setCellItemValue:value withRow:row withCol:index++];
    
    value = [netData objectForKey:@"QS"];
    [tableView setCellItemValue:value withRow:row withCol:index++];
    value = [netData objectForKey:@"note"];
    [tableView setCellItemValue:value withRow:row withCol:index++];
#else
    
    
#if 0
    index = 0;
    row = 0;
    //netData = [[netData objectForKey:@"data"]objectAtIndex:0];
    value = [netData objectForKey:@"goodId"];
    [tableView setCellItemValue:value withRow:0 withCol:index++];
    
    /*
     
     startPrice
     totalCount
     bjtd
     soldPrice
     */
    
    index = 0;
    row++;
    value = [netData objectForKey:@"goodName"];
    [tableView setCellItemValue:value withRow:row withCol:index++];
    
    value = [netData objectForKey:@"weight"];
     value = [NSString stringWithFormat:@"%0.2lf吨",[value floatValue]];
    [tableView setCellItemValue:value withRow:row withCol:index++];
    
    value = [netData objectForKey:@"bjtd"];
    value = [NSString stringWithFormat:@"%0.2lf元",[value floatValue]];
    [tableView setCellItemValue:value withRow:row withCol:index++];
    
    
    /*
     auctionStatus
     goodName
     package
     place
     */
    index = 0;
    row++;
    
    value = [netData objectForKey:@"startPrice"];
     value = [NSString stringWithFormat:@"%0.2lf元",[value floatValue]];
    [tableView setCellItemValue:value withRow:row withCol:index++];
    
    value = [netData objectForKey:@"packages"];
    [tableView setCellItemValue:value withRow:row withCol:index++];
    value = [netData objectForKey:@"place"];
    [tableView setCellItemValue:value withRow:row withCol:index++];
    
    value = [netData objectForKey:@"payment"];
    [tableView setCellItemValue:value withRow:row withCol:index++];
    
    
    index = 0;
    row++;
    
    
    
    value = [netData objectForKey:@"auctionStatus"];
    NSString *statusStr = @"";
    if([value intValue] == 1){
        statusStr = @"未开始";
    }
    else{
        statusStr = @"已开始";
    }
    [tableView setCellItemValue:statusStr withRow:row withCol:index++];
    
    value = [netData objectForKey:@"deliveryTime"];
    [tableView setCellItemValue:value withRow:row withCol:index++];
    
    value = [netData objectForKey:@"QS"];
    [tableView setCellItemValue:value withRow:row withCol:index++];
    
    value = [netData objectForKey:@"deliveryWay"];
    [tableView setCellItemValue:value withRow:row withCol:index++];
    
    
    
   
    /*
     warehouse
     weight
     unit
     payment
     */
    index = 0;
    row++;
    value = [netData objectForKey:@"warehouse"];
    [tableView setCellItemValue:value withRow:row withCol:index++];
   
    value = [netData objectForKey:@"note"];
    [tableView setCellItemValue:value withRow:row withCol:index++];
    
    
    /*
     
     deliveryWay
     deliveryTime
     QS
     note
     */
#else
    
    //id
    value = [netData objectForKey:@"goodId"];
    //[cell setCellItemValue:value withIndex:index++];
    [tableView setCellItemValue:value withRow:row withCol:index++];
    
    
    value = [netData objectForKey:@"goodName"];
    //[cell setCellItemValue:value withIndex:index++];
    [tableView setCellItemValue:value withRow:row withCol:index++];
    
    value = [netData objectForKey:@"weight"];
    value = [NSString stringWithFormat:@"%0.2lf 吨",[value floatValue]];
    [tableView setCellItemValue:value withRow:index++];
    

    value = [netData objectForKey:@"startPrice"];
     value = [NSString stringWithFormat:@"%0.2lf 元",[value floatValue]];
    [tableView setCellItemValue:value withRow:row withCol:index++];
    value = [netData objectForKey:@"auctionMode"];
    if([value intValue] == 1){
        [tableView setTitleHidden:NO withIndex:index];
        value = [netData objectForKey:@"bjtd"];
        value  = [NSString stringWithFormat:@"%0.2lf 元",[value floatValue]];
        //[cell setCellItemValue:value withIndex:index++];
        [tableView setCellItemValue:value withRow:row withCol:index++];
    
    }
    else{
        
        [tableView setTitleHidden:YES withIndex:index++];
    }
    
    [tableView setActionTarget:self withSelecotr:@selector(didSElectorGoodsDetailItem:)];
    
    tableView.backgroundColor = HexRGB(254, 254,188);
    
    
#endif
   
    
    
    

   
    
#endif
    
}
- (void)updateUIData:(NSDictionary*)netData{
    kNetEnd(self.view);

  
    [self setTableHeaderViewByData:netData];
    [self addTableCellView:netData];
    
    //[self setTableCellViewByData:netData];
    
}

-(void)didNetDataFailed:(NSNotification*)ntf
{
    //kNetEndWithErrorAutoDismiss
}

-(void)didSelectorTopNavigationBarItem:(id)sender{
    
    if([sender tag] == 0){
        [self.navigationController popViewControllerAnimated:YES];
    }
    if([sender tag] == 1){
        
        BidMainViewController *bidMainVc = [[BidMainViewController alloc]init];
        [self.navigationController pushViewController:bidMainVc animated:YES];
        SafeRelease(bidMainVc);
    }
}

#pragma mark -

#pragma mark - selector good item

- (void)didSElectorGoodsDetailItem:(id)sender{

    int index = [sender tag];
    
    GoodsItemDetailViewController *goodItemDetailCtl = [[GoodsItemDetailViewController alloc]init];
    goodItemDetailCtl.data   = [[self.data objectForKey:@"data"] objectAtIndex:index];
    [self.navigationController pushViewController:goodItemDetailCtl animated:YES];
    SafeRelease(goodItemDetailCtl);

}
@end
