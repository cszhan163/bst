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
#define kLeftPendingX 10.f



#define kMaxItemClounm 3
#define kHeaderColounmItemWidthArray @[@100.f,@100.f,@100.f]

#define kTableColounmItemWidthArray @[@110.f,@65.f,@65.f,@65.f]
#define kCellHeight  18.f;

@interface BidDetailViewController (){

    BidDetailTableViewCell *headerView;
    BidDetailTableViewCell *tableView;
}
@end

@implementation BidDetailViewController

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
    
    /*
    tweetieTableView.dataSource = nil;
    tweetieTableView.delegate = nil;
    tweetieTableView.hidden = YES;
    */
    //add headerview;
    CGFloat currY = kMBAppTopToolBarHeight+5.f;
    UIImageWithFileName(UIImage *image , @"bid_detail_header.png");
    
    
    headerView = [[BidDetailTableViewCell alloc]initWithFrame:CGRectMake(kLeftPendingX, currY,image.size.width/kScale, image.size.height/kScale) withRowCount:2 withColumCount:3 withCellHeight:20 withHeaderTitle:@"场次信息"];
    
    [headerView setHeaderLabelText:@"场次信息"];
    [headerView addColumWithKeyTitleArray:@[@"场次编号",@"场次名称",@"参与方式"] withColumWidthArray:kHeaderColounmItemWidthArray];
    
    [headerView addColumWithKeyTitleArray:@[@"竞价日",@"开始时间",@"结束时间"] withColumWidthArray:kHeaderColounmItemWidthArray];
    
    headerView.layer.contents = (id)image.CGImage;
    [self.view addSubview:headerView];
    SafeRelease(headerView);
    
    currY = 185.f;
    UIImageWithFileName(image , @"bid_detail_table.png");
    
    tableView = [[BidDetailTableViewCell alloc]initWithFrame:CGRectMake(kLeftPendingX, currY,image.size.width/kScale, image.size.height/kScale) withRowCount:5 withColumCount:4 withCellHeight:20 withHeaderTitle:@"物资信息"];
    tableView.layer.contents = (id)image.CGImage;
    /*
     物资编号
     竞价模式
     报盘方式
     计价方式
     起拍价
     总量
     拼盘梯度
     成交价
     竞价状态
     品名
     包装
     产地
     仓库
     重量
     计量单位
     付款方式
     提货方式
     交货时间
     质量标准
     备注
     */
    [tableView addColumWithKeyTitleArray:@[@"物资编号",@"竞价模式",@"报盘方式",@"计价方式"] withColumWidthArray:kTableColounmItemWidthArray];
    
    [tableView addColumWithKeyTitleArray:@[@"起拍价",@"总量",@"竞价梯度",@"成交价"] withColumWidthArray:kTableColounmItemWidthArray];
    /*
     @"竞价状态",
     @"品名",
     @"包装",
     @"产地",
     */
    [tableView addColumWithKeyTitleArray:@[@"竞价状态",
                                           @"品名",
                                           @"包装",
                                           @"产地"
                                           ] withColumWidthArray:kTableColounmItemWidthArray];
    
    /*
     @"仓库",
     @"重量",
     @"计量单位",
     @"付款方式",
     */
    [tableView addColumWithKeyTitleArray:@[@"仓库",
                                           @"重量",
                                           @"计量单位",
                                           @"付款方式"
                                           ] withColumWidthArray:kTableColounmItemWidthArray];
    
    /*
     @"提货方式",
     @"交货时间",
     @"质量标准",
     @"备注",
     */

    [tableView addColumWithKeyTitleArray:@[@"提货方式",
                                           @"交货时间",
                                           @"质量标准",
                                           @"备注"
                                           ] withColumWidthArray:kTableColounmItemWidthArray];
    

    
    [self.view addSubview:tableView];
    SafeRelease(tableView);
    
    [self addFonterView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addFonterView{
    
    //    logInfo.frame = CGRectMake(0,kMBAppTopToolBarHeight-self.mainContentViewPendingY,kDeviceScreenWidth,kDeviceScreenHeight-kMBAppTopToolBarHeight-kMBAppStatusBar-kMBAppBottomToolBarHeght- 60 );
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0.f,0.f,300.f,80)];
    bgView.backgroundColor = HexRGB(202, 202, 204);
    
    CGFloat currY = kDeviceScreenHeight-kMBAppTopToolBarHeight-kMBAppStatusBar-kMBAppBottomToolBarHeght- 60+10.f;
    UIButton *oilAnalaysisBtn = [UIComUtil createButtonWithNormalBGImageName:@"bid_start_btn.png" withHightBGImageName:@"bid_start_btn.png" withTitle:@"参加竞价" withTag:0];
    
    CGSize btnsize= oilAnalaysisBtn.frame.size;
    //currY = 10.f;
    currY = currY+50.f;
     oilAnalaysisBtn.frame = CGRectMake(10.f,currY,btnsize.width,btnsize.height);
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

    BidConfirmViewController *bidConfirmVc = [[BidConfirmViewController alloc]init];
    
    [self.navigationController pushViewController:bidConfirmVc animated:YES];

    SafeRelease(bidConfirmVc);
}
#pragma mark- 
#pragma mark -net data
- (void) shouldLoadData{
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           //catStr,@"cat",
                           //@"001",@"hydm",
                           @"10",@"wtid",
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
     ggmc	场次名称
     joinWay	参与方式
     auctionDate	竞价日
     kssj	开始时间
     jssj	结束时间
     */
    value = [netData objectForKey:@"wtid"];
    [headerView setCellItemValue:value withRow:row withCol:index++];
    
    value = [netData objectForKey:@"ggmc"];
    [headerView setCellItemValue:value withRow:row withCol:index++];
    
    value = [netData objectForKey:@"joinWay"];
    [headerView setCellItemValue:value withRow:row withCol:index++];
    
    index = 0;
    row++;
    value = [netData objectForKey:@"auctionDate"];
    [headerView setCellItemValue:value withRow:row withCol:index++];
    
    value = [netData objectForKey:@"kssj"];
    [headerView setCellItemValue:value withRow:row withCol:index++];
    
    value = [netData objectForKey:@"jssj"];
    [headerView setCellItemValue:value withRow:row withCol:index++];
    
    
   
    /*
     goodId
     auctionMode
     offerWay
     pricingWay
     */
    index = 0;
    row = 0;
    netData = [[netData objectForKey:@"data"]objectAtIndex:0];
    value = [netData objectForKey:@"goodId"];
    [tableView setCellItemValue:value withRow:0 withCol:index++];
    
    value = [netData objectForKey:@"auctionMode"];
    [tableView setCellItemValue:value withRow:0 withCol:index++];
    
    value = [netData objectForKey:@"offerWay"];
    [tableView setCellItemValue:value withRow:0 withCol:index++];
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
    [tableView setCellItemValue:value withRow:row withCol:index++];
    
    value = [netData objectForKey:@"totalCount"];
    [tableView setCellItemValue:value withRow:row withCol:index++];
    
    value = [netData objectForKey:@"bjtd"];
    [tableView setCellItemValue:value withRow:row withCol:index++];
    value = [netData objectForKey:@"soldPrice"];
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
    [tableView setCellItemValue:value withRow:row withCol:index++];
    
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
    
}
-(void)didNetDataFailed:(NSNotification*)ntf
{
    //kNetEndWithErrorAutoDismiss
}

@end
