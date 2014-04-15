//
//  BidStartViewController.m
//  BSTell
//
//  Created by cszhan on 14-2-5.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "BidStartedViewController.h"
#import "BidStartedTableViewCell.h"

#import "BidItemDetailViewController.h"

#import "BidDetailTableViewCell_V2.h"

#define kHeaderColounmItemWidthArray @[@80.f,@80.f,@80.f]

#define kCellTitleColorArray @[[UIColor blackColor],[UIColor blackColor],[UIColor blackColor],[UIColor blackColor],[UIColor blackColor],[UIColor blackColor],[UIColor blackColor]]

#define kCellTitleFontArray  @[[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:14]]


#define kCellValueColorArray @[[UIColor blackColor],[UIColor blackColor],[UIColor blackColor],[UIColor blackColor],[UIColor redColor],[UIColor blackColor],[UIColor blackColor]]

#define kCellValueFontArray  @[[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:14]]


#define kCellItemHeightArray @[@20.f,@20.f,@20.f,@20.f,@20.f,@20.f,@20.f]

@interface BidStartedViewController(){

    NSTimer *timer;
}
@property(nonatomic,retain)NSTimer *timer;
@end

@implementation BidStartedViewController
- (void)dealloc{
    [super dealloc];
    //self.timer = nil;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self startReflushjTimer];
    //[self reflushData];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //[self stopReflushTimer];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTopNavBarHidden:YES];
    CGRect rect =  tweetieTableView.frame;
    tweetieTableView.frame = CGRectMake(rect.origin.x, rect.origin.y, kDeviceScreenWidth, rect.size.height-43.f);
    //[self startReflushjTimer];
	// Do any additional setup after loading the view.
}
- (void)startReflushjTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:kBidReflushTimer target:self selector:@selector(reflushData) userInfo:nil repeats:YES];
    
}
- (void)stopReflushTimer{
    [self.timer invalidate];
    self.timer = nil;
}
- (void)reflushData{
    [self shouldLoadOlderData:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	//return  5;
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    
    
    LeftTitleListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
#if 0
        NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:@"BidItemCell"
                                                        owner:self options:nil];
        for (id oneObject in nibArr)
            if ([oneObject isKindOfClass:[BidItemCell class]])
                cell = (BidItemCell*)oneObject;
#else
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
        
        cell = [[BidDetailTableViewCell_V2 alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier
                withTitleArray:@[
                                 @"场次",
                                 @"品名",
                                 @"重量",
                                 @"当前价",
                                 @"报价状态",
                                 @"竞价模式",
                                 @"结束时间"
                                 ]
                withTitleAttributeArray:titleArray
                withValueAttributeArray:valueArray
                withHeightArray:kCellItemHeightArray];
        [cell setActionTarget:self withSelecotr:@selector(bidConfirmAlert:)];
        
#endif
#if 0
         [cell addColumWithKeyTitleArray:@[@"场次",@"物资号",@"当前价"] withColumWidthArray:kHeaderColounmItemWidthArray];
         
         [cell addColumWithKeyTitleArray:@[@"结束时间",@"竞价梯度",@"我的出价"] withColumWidthArray:kHeaderColounmItemWidthArray];
#else
        
        
#endif
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.clipsToBounds = YES;
        
        UIImageWithFileName(UIImage* image, @"bid_started_cell_bg.png");
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        cell.backgroundView = imageView;
        [cell setPendingX:15.f];
        cell.frame = CGRectMake(0.f, 0.f, 290, 80.f);
    }
    /*
     返回JSON数据参数	参数名称	参数类型
     wtmc	场次名称
     zys	资源数
     qpj	起拍价
     dqj	当前价
     myPrice	我的出价
     
     */
    NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
    int row = 0;
    int index = 0;
    NSString *value = @"";
    //id
    value = [item objectForKey:@"wtmc"];
    //[cell setCellItemValue:value withIndex:index++];
    [cell setCellItemValue:value withRow:row withCol:index++];
    //
#if 0
    value = [item objectForKey:@"id"];
   [cell setCellItemValue:value withRow:row withCol:index++];
    
    //sell company
    value = [item objectForKey:@"dqj"];
    
    [cell setCellItemValue:value withRow:row withCol:index++];
    row = 1;
    index =0;
    //sell company
    value = [item objectForKey:@"jssj"];
    value = [NSDate  dateFormart:value fromFormart:@"yyyyMMddHHmm" toFormart:@"HH:mm"];
    [cell setCellItemValue:value withRow:row withCol:index++];
    
    //起拍价
    value = [item objectForKey:@"bjtd"];
    
    [cell setCellItemValue:value withRow:row withCol:index++];
    
    //是否参加
    value = [item objectForKey:@"myPrice"];
    
   
    [cell setCellItemValue:value withRow:row withCol:index++];
#else
    
    
    
    value = [item objectForKey:@"goodName"];
    [cell setCellItemValue:value withRow:row withCol:index++];
    
    
    //sell company
    value = [item objectForKey:@"weight"];
    
    value = [NSString stringWithFormat:@"%0.2lf 吨",[value floatValue]];
    
    [cell setCellItemValue:value withRow:row withCol:index++];
    
    
    
    value = [item objectForKey:@"auctionStatus"];
    BOOL isOverTag = NO;
    if([value intValue] == 3){
        
        [cell setBidButtonTitle:@"已经\n结束"];
        isOverTag = YES;
        [cell  setButtonDisableStatus:YES];
        
    }
    else{
        [cell setBidButtonTitle:@"加1\n梯度"];
        [cell  setButtonDisableStatus:NO];
    }
    
    //sell company
    value = [item objectForKey:@"myprice"];
    CGFloat myPrice = [value floatValue];
    
    
    //sell company
    value = [item objectForKey:@"dqj"];
    
    CGFloat currPrice = [value floatValue];
    
    if(currPrice == 0.f){
        [cell setBidButtonTitle:@"底价\n出价"];
        value = @"----";
    }
    else{
        if(isOverTag){
            
             if(myPrice<currPrice){
                 value = @"----";
             }
             else {
             
                 value = [NSString stringWithFormat:@"%0.2lf元",[value floatValue]];
                 
             }
            
        }
        else{
            value = [NSString stringWithFormat:@"%0.2lf元",[value floatValue]];
        }
    }
    [cell setCellItemValue:value withRow:row withCol:index++];

    
 
    
    NSString *statusStr = @"落后";
    
    if(myPrice>=currPrice ){
        statusStr = @"领先";
        [cell  setValueColorByIndex:index withColor:HexRGB(200, 0, 0)];
    }
    else{
        [cell setValueColorByIndex:index withColor:HexRGB(0, 128, 0)];
    }
    value = [item objectForKey:@"qpj"];
    CGFloat basePrice = [value floatValue];
    if(currPrice == 0.f){
        statusStr = @"未出价";
        [cell setValueColorByIndex:index withColor:[UIColor blackColor]];
        
    }
    [cell setCellItemValue:statusStr withRow:row withCol:index++];
    
    //jjms
    NSString *bidType = @"公开增价";
    value = [item objectForKey:@"jjms"];
    if([value isEqualToString:@"2"]){
        bidType = @"自由报价";
        
        
        [cell setTitle:@"我的出价" withIndex:index-1];
        value = @"----";
        if(myPrice){
            value = [NSString stringWithFormat:@"%0.2lf元",myPrice];
        }
        [cell setCellItemValue:value withRow:row withCol:index-1];
        
        [cell setTitle:@"起拍价" withIndex:3];
        value = [NSString stringWithFormat:@"%0.2lf元",basePrice];
        [cell setCellItemValue:value withRow:row withCol:index-2];
        [cell setButtonHiddenStatus:YES];
        
    }
    else{
      
        [cell setTitle:@"当前价" withIndex:3];
        [cell setTitle:@"报价状态" withIndex:4];
        [cell setButtonHiddenStatus:NO];
    }
    [cell setCellItemValue:bidType withRow:row withCol:index++];
    
    //sell company
    value = [item objectForKey:@"jssj"];
    value = [NSDate  dateFormart:value fromFormart:@"yyyyMMddHHmm" toFormart:@"HH:mm"];
    [cell setCellItemValue:value withRow:row withCol:index++];
    
#endif
    //time
    [cell setBidButtonTag:indexPath.row];
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 143.f+30.f;//125.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSDictionary *item = self.dataArray[indexPath.row];
    
    NSString *goodId = [item objectForKey:@"id"];
    
    BidItemDetailViewController *vc = [[BidItemDetailViewController alloc]initWithNibName:nil bundle:nil];
    vc.bidType = Bid_Prepare;
    vc.goodId = goodId;
    vc.data = [self.dataArray objectAtIndex:indexPath.row];
    [vc  setNavgationBarTitle:@"交易详情"];
    /*
     vc.delegate = self;
     NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
     //NSDictionary *data = [item objectForKey:@"DayDetailInfo"];
     vc.mData = item;
     */
#if 1
    [self.parentNav pushViewController:vc animated:YES];
#else
    
    [ZCSNotficationMgr postMSG:kPushNewViewController obj:vc];
#endif
    //[self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SafeRelease(vc);
    
}


- (void) shouldLoadOlderData:(NTESMBTweetieTableView *) tweetieTableView{

    
    NSString *usrId = [AppSetting getLoginUserId];
    if(usrId){
        NSDictionary *usrData = [AppSetting getLoginUserData:usrId];
        self.userId = [usrData objectForKey:@"hydm"];
    }
    CarServiceNetDataMgr *cardShopMgr = [CarServiceNetDataMgr getSingleTone];
    
    //kNetStartShow(@"数据加载...", self.view);
    /*
     NSString *month = [NSString stringWithFormat:@"%02d",self.mCurrDate.month];
     NSString *year = [NSString stringWithFormat:@"%d",self.mCurrDate.year];
     NSString *carId = [AppSetting getUserCarId:[AppSetting getLoginUserId]];
     */
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.userId,@"hydm",
                           //@"10",@"limit",
                           //@"1",@"offset",
                           @"1",@"startflag",
                           nil];
    
    self.request = [cardShopMgr  queryAuctionPps4Move:param];
}
-(void)didNetDataOK:(NSNotification*)ntf
{
    [super didNetDataOK:ntf];
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];
    //NSString *resKey = [respRequest resourceKey];
    if([resKey isEqualToString:kResBidAllListData])
    {
        //kNetEnd(self.view);
#if 1
        self.dataArray = [data objectForKey:@"data"];
#else
        [self reloadNetData:data];
#endif
        //self.dataArray = [data objectForKey:@"economicData"];
        [self  performSelectorOnMainThread:@selector(updateUIData:) withObject:data waitUntilDone:NO ];
        //[mDataDict setObject:netData forKey:mMothDateKey];
        //}
        //
        
    }
    if([resKey isEqualToString:kResBidSaveData]){
        //[self.dataArray removeAllObjects];
       
        NSString *msg = [data objectForKey:@"msg"];
        if([[data objectForKey:@"result"]intValue] == 1){
            
            kUIAlertView(@"提示", @"出价成功");
        }
        else{
            
            kUIAlertView(@"提示", msg);
        }
        [self shouldLoadOlderData:tweetieTableView];
    }
    
}
- (void)updateUIData:(NSDictionary*)data{
    
    [tweetieTableView reloadData];
    
//    BidStartedViewController *oilDataVc = [navItemCtrl.navControllersArr objectAtIndex:0];
//    
//    oilDataVc.dataArray = [data objectForKey:@"data"];
//    [oilDataVc updateUIData:nil];
    
    /*
     CarDriveMannerDataGraphViewController *analysisVc = [navItemCtrl.navControllersArr objectAtIndex:1];
     [analysisVc updateUIData:newData];
     */
    return;
    
    NSArray *economicData = [data objectForKey:@"safeData"];
    economicData = [economicData sortedArrayUsingComparator:^(id param1,id param2){
        
        id arg1 = [param1 objectForKey:@"day"];
        id arg2 = [param2 objectForKey:@"day"];
        if([arg1 intValue]>[arg2 intValue]){
            return NSOrderedDescending;
        }
        else if([arg1 intValue]<[arg1 intValue]){
            return NSOrderedAscending;
        }
        else{
            return NSOrderedSame;
        }
        
    }];
    //[data ]
    NSMutableDictionary *newData = [NSMutableDictionary dictionaryWithDictionary:data];
    [newData setValue:economicData forKey:@"safeData"];
    
    
    
    
}
#pragma mark -
#pragma mark -button action

- (void)bidConfirmAlert:(id)sender{
    int i = [sender tag];
    NSDictionary *item = self.dataArray[i];
    currBidItem = item;
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
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"出价确认" message:msg delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
    [alertView show];
    SafeAutoRelease(alertView);
}
// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
    
    
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
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                               self.userId,@"hydm",
                               @"3",@"bjlb",
                               [NSString stringWithFormat:@"%lf",finalPrice],@"price",
                               [currBidItem objectForKey:@"id"],@"id",
                               operId,@"czy",
                               nil];
        
        self.request = [cardShopMgr  saveAuction4Move:param];
        
        
    }

}
//- (void)addObservers{
//    [super addObservers];
//}
//-(void)removeObservers
//{
//    [super removeObservers];
//}
@end
