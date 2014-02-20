//
//  BidEndViewController.m
//  BSTell
//
//  Created by cszhan on 14-2-5.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "BidPrepareViewController.h"
#import "BidPrepareTableViewCell.h"
#import "BidItemDetailViewController.h"
#define kHeaderColounmItemWidthArray  @[@100.f,@100.f,@100.f]
@implementation BidPrepareViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTopNavBarHidden:YES];
    CGRect rect =  tweetieTableView.frame;
    tweetieTableView.frame = CGRectMake(rect.origin.x, rect.origin.y, kDeviceScreenWidth, rect.size.height-43.f);
	// Do any additional setup after loading the view.
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
    
    
    BidPrepareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
#if 0
        NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:@"BidItemCell"
                                                        owner:self options:nil];
        for (id oneObject in nibArr)
            if ([oneObject isKindOfClass:[BidItemCell class]])
                cell = (BidItemCell*)oneObject;
#else
        
        cell = [[BidPrepareTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
        //[cell setActionTarget:self withSelecotr:@selector(bidConfirmAlert:)];
        
#endif
#if 1
        [cell addColumWithKeyTitleArray:@[@"场次",@"物资号",@"开始时间"] withColumWidthArray:kHeaderColounmItemWidthArray];
        
       // [cell addColumWithKeyTitleArray:@[@"结束时间",@"竞价梯度",@"我的出价"] withColumWidthArray:kHeaderColounmItemWidthArray];
#else
        
        
#endif
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.clipsToBounds = YES;
#if 0
        UIImageWithFileName(UIImage* image, @"bid_started_cell_bg.png");
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        cell.backgroundView = imageView;
        [cell setPendingX:15.f];
        cell.frame = CGRectMake(0.f, 0.f, 290, 80.f);
#endif
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
    value = [item objectForKey:@"kssj"];
    
    [cell setCellItemValue:value withRow:row withCol:index++];
//    row = 1;
//    index =0;
//    //sell company
//    value = [item objectForKey:@"jssj"];
//    
//    [cell setCellItemValue:value withRow:row withCol:index++];
//    
//    //起拍价
//    value = [item objectForKey:@"bjtd"];
//    
//    [cell setCellItemValue:value withRow:row withCol:index++];
//    
//    //是否参加
//    value = [item objectForKey:@"myPrice"];
    
    [cell setCellItemValue:value withRow:row withCol:index++];
#else
    
    
    
    value = [item objectForKey:@"id"];
    [cell setCellItemValue:value withRow:row withCol:index++];
    
    //sell company
//    value = [item objectForKey:@"dqj"];
//    
//    [cell setCellItemValue:value withRow:row withCol:index++];
    //sell company
    value = [item objectForKey:@"jssj"];
    
    [cell setCellItemValue:value withRow:row withCol:index++];
    
#endif
    //time
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 106.f;//125.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    BidItemDetailViewController *vc = [[BidItemDetailViewController alloc]initWithNibName:nil bundle:nil];
    [vc  setNavgationBarTitle:@"详情"];
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
    
    CarServiceNetDataMgr *cardShopMgr = [CarServiceNetDataMgr getSingleTone];
    
    //kNetStartShow(@"数据加载...", self.view);
    /*
     NSString *month = [NSString stringWithFormat:@"%02d",self.mCurrDate.month];
     NSString *year = [NSString stringWithFormat:@"%d",self.mCurrDate.year];
     NSString *carId = [AppSetting getUserCarId:[AppSetting getLoginUserId]];
     */
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"001",@"hydm",
                           @"10",@"limit",
                           @"1",@"offset",
                           @"0",@"startflg",
                           nil];
    
    self.request = [cardShopMgr  queryAuctionPps4Move:param];
    return;
}
-(void)didNetDataOK:(NSNotification*)ntf
{
    
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];
    //NSString *resKey = [respRequest resourceKey];
    if([resKey isEqualToString:kResBidAllListData])
    {
        //kNetEnd(self.view);
        self.dataArray = [data objectForKey:@"data"];
        //self.dataArray = [data objectForKey:@"economicData"];
        [self  performSelectorOnMainThread:@selector(updateUIData:) withObject:data waitUntilDone:NO ];
        //[mDataDict setObject:netData forKey:mMothDateKey];
        //}
        //
        
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

@end
