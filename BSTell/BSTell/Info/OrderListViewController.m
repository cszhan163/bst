//
//  OrderListViewController.m
//  BSTell
//
//  Created by cszhan on 14-2-19.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "OrderListViewController.h"
#import "OrderTableViewCell.h"

#import "OrderDetailViewController.h"
@interface OrderListViewController ()

@end

@implementation OrderListViewController

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
    
    [self setNavgationBarTitle:@"我的订单"];
    CGRect rect =  tweetieTableView.frame;
    tweetieTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tweetieTableView.frame = CGRectMake(rect.origin.x, rect.origin.y, kDeviceScreenWidth, rect.size.height-43.f);
    NSString *usrId = [AppSetting getLoginUserId];
    if(usrId){
        NSDictionary *usrData = [AppSetting getLoginUserData:usrId];
        self.userId = [usrData objectForKey:@"hydm"];
    }
    
}
- (void)viewWillAppear:(BOOL)animated{
    //[super viewWillAppear:animated];
   
    
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
    
    
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
#if 1
        NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:@"OrderTableViewCell"
                                                        owner:self options:nil];
        for (id oneObject in nibArr)
            if ([oneObject isKindOfClass:[OrderTableViewCell class]])
                cell = (OrderTableViewCell*)oneObject;
#else
        cell = [[InfoClassTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
#endif
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
       
        cell.clipsToBounds = YES;
        //cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
        cell.contentView.frame = CGRectMake(10.f, 0.f, 300, cell.frame.size.height);
        
    }
    NSDictionary *item = self.dataArray[indexPath.row];
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
    if([[item objectForKey:@"acutionResult"] intValue]){
        //cell.contentView.backgroundColor =
        //  235
        cell.contentView.backgroundColor = HexRGB(234, 234, 235);
    }
    else{
        cell.contentView.backgroundColor = HexRGB( 255,254,185);
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 63.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    OrderDetailViewController *vc = [[OrderDetailViewController alloc]initWithNibName:nil bundle:nil];
    NSDictionary *item = self.dataArray[indexPath.row];
    vc.orderId = [item objectForKey:@"orderId"];
    vc.orderItem = item;
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
#else
    
    [ZCSNotficationMgr postMSG:kPushNewViewController obj:vc];
#endif
    //[self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SafeRelease(vc);
    
}

- (void) shouldLoadOlderData:(NTESMBTweetieTableView *) tweetieTableView
{
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
                 [NSString stringWithFormat:@"%d",self.confirmTag],@"confirmflag",
                 //@"",@"rqStart",
                 //@"",@"rqEnd",
                 nil];
        self.request = [carServiceNetDataMgr  getOrderList:param];
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
    if([resKey isEqualToString:kCarUserOrderList])
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
- (void)updateUIData:(NSDictionary*)netData{
    
    kNetEnd(self.view);
    [tweetieTableView reloadData];
    //contentTextView.text = [netData objectForKey:@"agreement"];
}- (void)reflushData{
    [self shouldLoadOlderData:nil];
}
@end
