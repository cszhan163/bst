//
//  OrderListConfirmedViewController.m
//  BSTell
//
//  Created by cszhan on 14-3-30.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "OrderListConfirmedViewController.h"

#import "OrderDetailViewController.h"

#import "OrderListCell.h"
#import "OrderTableViewCell.h"


#define kCellTitleColorArray @[[UIColor blackColor],[UIColor blackColor],[UIColor blackColor],[UIColor blackColor],[UIColor blackColor],[UIColor blackColor]]

#define kCellTitleFontArray  @[[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:14]]


#define kCellValueColorArray @[[UIColor blackColor],[UIColor blackColor],[UIColor blackColor],[UIColor blackColor],[UIColor blackColor],[UIColor blackColor]]

#define kCellValueFontArray  @[[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:14]]


#define kCellItemHeightArray @[@20.f,@20.f,@20.f,@20.f,@20.f,@20.f]

@interface OrderListConfirmedViewController ()

@end

@implementation OrderListConfirmedViewController

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
  
    
    [self setNavgationBarTitle:@"我的订单"];
    CGRect rect =  tweetieTableView.frame;
    tweetieTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tweetieTableView.frame = CGRectMake(rect.origin.x, rect.origin.y, kDeviceScreenWidth, rect.size.height-43.f);
    NSString *usrId = [AppSetting getLoginUserId];
    if(usrId){
        NSDictionary *usrData = [AppSetting getLoginUserData:usrId];
        self.userId = [usrData objectForKey:@"hydm"];
    }
	// Do any additional setup after loading the view.
}

- (void) shouldLoadOlderData:(NTESMBTweetieTableView *) tweetieTableView
{
    [super shouldLoadOlderData:tweetieTableView];
    NSDictionary *param  = nil;
    CarServiceNetDataMgr *carServiceNetDataMgr = [CarServiceNetDataMgr getSingleTone];
    {
        /*
         公告ID	ggid
         会员代码	hydm
         */
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 [NSString stringWithFormat:@"%d",self.pageNum],@"offset",
                 //@"1",@"zc",
                 //@"",@"wtzt",
                 self.userId,@"hydm",
                 @"10",@"limit",
                 [NSString stringWithFormat:@"%d",1],@"confirmflag",
                 //@"",@"rqStart",
                 //@"",@"rqEnd",
                 nil];
        self.request = [carServiceNetDataMgr  getOrderListConfirmed:param];
    }
    
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
    
    
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
#if 0
        NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:@"OrderTableViewCell"
                                                        owner:self options:nil];
        for (id oneObject in nibArr)
            if ([oneObject isKindOfClass:[OrderTableViewCell class]])
                cell = (OrderTableViewCell*)oneObject;
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
        
        
        cell = [[OrderListCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier
                withTitleArray:@[
                                 @"品名",
                                 @"重量",
                                 @"卖方会员",
                                 @"成交时间",
                                 @"成交金额",
                                 @"订单结果"
                                 ]
                withTitleAttributeArray:titleArray
                withValueAttributeArray:valueArray
                withHeightArray:kCellItemHeightArray];
        [cell setActionTarget:self withSelecotr:@selector(bidConfirmAlert:)];
#endif
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        
        cell.clipsToBounds = YES;
        //cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
        //cell.contentView.frame = CGRectMake(10.f, 0.f, 300, cell.frame.size.height);
        UIImageWithFileName(UIImage* image, @"order_cell_bg.png");
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        cell.backgroundView = imageView;
        [cell setPendingX:10.f];
        [cell setPendingY:5.f];
        //cell.frame = CGRectMake(0.f, 0.f, 290, 80.f);
        
    }
    NSDictionary *item = self.dataArray[indexPath.row];
#if 0
    /*
     orderId	订单号
     goodId	物资号
     goodName	品名
     acutionResult	订单结果		0：未确认
     1：已确认
     */
    
    cell.orderIdLabel.text  = [item objectForKey:@"orderId"];
    cell.goodsIdLabel.text = [item objectForKey:@"goodId"];
    cell.classNameLabel.text = [item objectForKey:@"goodName"];
#else
    /*
     goodName
     品名
     weight
     合同重量
     turnover
     成交金额
     seller
     卖方单位
     
     dealTime
     成交时间
     
     acutionResult
     订单结果
     acutionStatus
     订单状态
     fphm
     合同号
     */
    
    int row = 0;
    int index = 0;
    NSString *value = @"";
    //id
    value = [item objectForKey:@"goodName"];
    //[cell setCellItemValue:value withIndex:index++];
    [cell setCellItemValue:value withRow:row withCol:index++];
    
    value = [item objectForKey:@"weight"];
    value = [NSString stringWithFormat:@"%@ 吨",value];
    [cell setCellItemValue:value withRow:index++];
    
    value = [item objectForKey:@"seller"];
    //[cell setCellItemValue:value withIndex:index++];
    [cell setCellItemValue:value withRow:row withCol:index++];
    
    value = [item objectForKey:@"dealTime"];
    //[cell setCellItemValue:value withIndex:index++];
    value = [NSDate  dateFormart:value fromFormart:@"yyyyMMdd" toFormart:@"yyyy-MM-dd"];
    [cell setCellItemValue:value withRow:row withCol:index++];
    
    value = [item objectForKey:@"turnover"];
    value  = [NSString stringWithFormat:@"%0.2lf 元",[value floatValue]];
    //[cell setCellItemValue:value withIndex:index++];
    [cell setCellItemValue:value withRow:row withCol:index++];
    
    value = [item objectForKey:@"acutionStatus"];
    NSString *relResult = @"已完成";
    if([value intValue] == 0){
        relResult = @"卖家未到款确认";
    }
    else if([value intValue] == 2){
        
        relResult = @"卖家已到款确认";
    }
    //[cell setCellItemValue:value withIndex:index++];
    [cell setCellItemValue:relResult withRow:row withCol:index++];
#endif
    
    if([[item objectForKey:@"acutionResult"] intValue]){
        //cell.contentView.backgroundColor =
        //  235
        //cell.contentView.backgroundColor = HexRGB(234, 234, 235);
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    else{
        //HexRGB( 255,254,185);
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    [cell setBidButtonTag:indexPath.row];

    [cell setButtonHiddenStatus:YES];
 
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 145.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderDetailViewController *vc = [[OrderDetailViewController alloc]initWithNibName:nil bundle:nil];
    NSDictionary *item = self.dataArray[indexPath.row];
    vc.orderId = [item objectForKey:@"orderId"];
    vc.orderItem = item;
    
    if([[item objectForKey:@"acutionResult"] intValue]){
        //cell.contentView.backgroundColor =
        //  235
        vc.isConfirmTag = YES;
    }
    else{
        vc.isConfirmTag = NO;
    }
    
    [vc  setNavgationBarTitle:@"订单详情"];
    
    //[vc  setHiddenTableHeaderView:NO];
    //[vc  setH]
    /*
     vc.delegate = self;
     NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
     //NSDictionary *data = [item objectForKey:@"DayDetailInfo"];
     vc.mData = item;
     */
#if 1
    [self.parentNav pushViewController:vc animated:YES];
    [self.dataArray removeAllObjects];
#else
    
    [ZCSNotficationMgr postMSG:kPushNewViewController obj:vc];
#endif
    SafeRelease(vc);
    
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateUIData:(NSDictionary*)netData{
    
    kNetEnd(self.view);
    [tweetieTableView reloadData];
    //contentTextView.text = [netData objectForKey:@"agreement"];
}
- (void)reflushData{
    self.pageNum = 1;
    [self.dataArray removeAllObjects];
    [tweetieTableView reloadData];
    //[self shouldLoadOlderData:nil];
}

-(void)didNetDataOK:(NSNotification*)ntf
{
    [super didNetDataOK:ntf];
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];//[respRequest resourceKey];
    //NSString *resKey = [respRequest resourceKey];
    if([resKey isEqualToString:kCarUserOrderComfirmedList])
    {
        //        if ([self.externDelegate respondsToSelector:@selector(commentDidSendOK:)]) {
        //            [self.externDelegate commentDidSendOK:self];
        //        }
        //        kNetEndSuccStr(@"评论成功",self.view);
        //        [self dismissModalViewControllerAnimated:YES];
        
        [self reloadNetData:data];
        [self performSelectorOnMainThread:@selector(updateUIData:) withObject:data waitUntilDone:NO];
        
    }
}
@end
