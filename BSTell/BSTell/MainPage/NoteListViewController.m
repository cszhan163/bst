//
//  NoteListViewController.m
//  BSTell
//
//  Created by cszhan on 14-2-1.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "NoteListViewController.h"
#import "NoteItemCell.h"

#import "NoteDetailViewController.h"

@interface NoteListViewController (){

    
}
@property(nonatomic,strong)UILabel *secondClassLabel;
@end

@implementation NoteListViewController

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
    
    //UIImageView *sencodLevelBgView = [UIImageView alloc]initWithImage:<#(UIImage *)#>
    [self setHiddenLeftBtn:NO];
    self.secondClassLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:12.f] withTextColor:[UIColor blackColor] withText:@"" withFrame:CGRectMake(0.f, 0.f, kDeviceScreenWidth, 30.f)];
    self.secondClassLabel.backgroundColor = [UIColor blueColor];
    
    //[tweetieTableView setTableHeaderView:secondClassLabel];
    SafeRelease(self.secondClassLabel);
    
	// Do any additional setup after loading the view.
}
- (void)setHiddenTableHeaderView:(BOOL)status{

    if(status){
        [tweetieTableView setTableHeaderView:nil];
    }
    else{
        [tweetieTableView setTableHeaderView:self.secondClassLabel];
    }
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
	static NSString *CellIdentifier = @"NoteCell";
    
    
    NoteItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
#if 0
        NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:@"BidItemCell"
                                                        owner:self options:nil];
        for (id oneObject in nibArr)
            if ([oneObject isKindOfClass:[BidItemCell class]])
                cell = (BidItemCell*)oneObject;
#else
        cell = [[NoteItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
#endif
        cell.selectionStyle = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor clearColor];
        cell.clipsToBounds = YES;
        
    }
    /*
     "driveflg": "1",
     "starttime": "17:54",
     "distance": "12",
     "time": "43",
     "oil": "25",
     "startadr": "张江地铁",
     "endadr": "人民广场",
     "startadr2": "121.607931, 31.211412",
     "endadr2": "121.48117, 31.236416",
     "rotate": "86",
     "speed": "34",
     "water temp": "64",
     "oiltest": "8",
     "drivetest": "7"
     */
    UIImage *bgImage = nil;
        /*
         公告ID	ggid
         公告title	ggmc
         公告日期	fbsj
         */
    
        NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
    
        NSString *title = [item objectForKey:@"ggmc"];
    
    cell.noteTextLabel.text = title;
    
    title = [item objectForKey:@"fbsj"];
    
    cell.noteDetailTextLabel.text = title;
    
    //    NSDictionary *data = item;//[item objectForKey:@"DayDetailInfo"];
    //    //cell = (PlantTableViewCell*)cell;
    //    NSString *flag = [data objectForKey:@"driveflg"];
    //    //flag = @"1";
    //    int time = [[data objectForKey:@"drivingLong"]intValue];
    //    //baoNormalFormat
    //    float distance = [[data objectForKey:@"distance"]floatValue];
    //    float oilvolume = [[data objectForKey:@"oil"]floatValue];
    //
    //
    //    NSString *timeStr = [data objectForKey:@"startTime"];
    //
    //    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    //    //[dateFormat setDateStyle:NSDateFormatterMediumStyle];
    //    //[dateFormat setTimeStyle:NSDateFormatterFullStyle];
    //    [dateFormat setDateFormat:@"yyyyMMddHHmmss"];
    //    NSString *temp = [dateFormat stringFromDate:[NSDate date]];
    //    NSDate *startDate = [dateFormat dateFromString:timeStr];
    //    [dateFormat setDateFormat:@"HH:mm"];
    //    NSString *dateStr = [dateFormat stringFromDate:startDate];
    //    /*
    //     NSArray *timeArr  = [timeStr componentsSeparatedByString:@" "];
    //     timeArr[1];
    //     */
    //    SafeRelease(dateFormat);
    
    //time
    //    origin = cell.mTimeImageView.frame.origin;
    //    if([flag isEqualToString:@"0"]){
    //        UIImageWithFileName(bgImage, @"time.png");
    //        cell.mTimeImageView.image = bgImage;
    //
    //    }
    //    else{
    //        UIImageWithFileName(bgImage, @"time-red.png");
    //        cell.mTimeImageView.image = bgImage;
    //
    //    }
    //    cell.mTimeImageView.frame = CGRectMake(origin.x, origin.y,bgImage.size.width/kScale, bgImage.size.height/kScale);
    
    //    NSString *latLogStr = [data objectForKey:@"startadr2"];
    //    NSArray *latLogArr  = [latLogStr componentsSeparatedByString:@","];
    /*
     mStartPoint.latitude =
     mStartPoint.longitude = [latLogArr[0]floatValue]/kGPSMaxScale;
     */
    //NSString *startLocationKey = @"";
    
    //distance
    
    
	//cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 90.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
     NoteDetailViewController *vc = [[NoteDetailViewController alloc]initWithNibName:nil bundle:nil];
    
    NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
    NSString *idStr = [item objectForKey:@"ggid"];
    vc.type = self.type;
    if(self.type == Note_Bid)
        vc.userId = @"";
    vc.noteId = idStr;

    [vc  setNavgationBarTitle:@""];
  
     #if 1
     [self.navigationController pushViewController:vc animated:YES];
     #else
     
     [ZCSNotficationMgr postMSG:kPushNewViewController obj:vc];
     #endif
     //[self.navigationController pushViewController:vc animated:YES];
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
     SafeRelease(vc);
}

#pragma mark -
#pragma mark -network
- (void) shouldLoadOlderData:(NTESMBTweetieTableView *) tweetieTableView{
    
    //NSString *catStr = [NSString stringWithFormat:@"%d",self.goodGroupNum];
    NSString *pageNumStr = [NSString stringWithFormat:@"%d",currentPageNum];
    /*
     @"001",@"hydm",
     @"10",@"limit",
     @"1",@"offset",
     zc	专场代码
     wtzt
     rqStart	竞价日期1
     rqEnd	竞价日期2
     */
    NSDictionary *param  = nil;
    CarServiceNetDataMgr *carServiceNetDataMgr = [CarServiceNetDataMgr getSingleTone];
    if(self.type == Note_New){
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                               //catStr,@"cat",
                               pageNumStr, @"offset",
                               //@"1",@"zc",
                               //@"",@"wtzt",
                               //@"001",@"hydm",
                               @"10",@"limit",
                               //@"",@"rqStart",
                               //@"",@"rqEnd",
                               nil];
        self.request = [carServiceNetDataMgr  querySitePubmsg4Move:param];
    }
    else{
        /*
         gglx	公告类型		0  交易预告
         1  竞价公告
         2  市场公告
         zc	专场类型（循环物资，钢材正品）		1 钢材正品
         2 循环物资
         */
    
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"1",@"gglx",
                 pageNumStr, @"offset",
                 @"1",@"zc",
                 //@"",@"wtzt",
                 //@"001",@"hydm",
                 @"10",@"limit",
                 //@"",@"rqStart",
                 //@"",@"rqEnd",
                 nil];
        self.request = [carServiceNetDataMgr  queryBidPubmsg4Move:param];
        
    }
  
    
}
-(void)didNetDataOK:(NSNotification*)ntf
{
    
    
    
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];//[respRequest resourceKey];
    //NSString *resKey = [respRequest resourceKey];
    if(([resKey isEqualToString:kResNoteNewsData] && self.type == Note_New)||
       ([resKey isEqualToString:kResNoteBidData]&&self.type == Note_Bid))
    {
        //        if ([self.externDelegate respondsToSelector:@selector(commentDidSendOK:)]) {
        //            [self.externDelegate commentDidSendOK:self];
        //        }
        //        kNetEndSuccStr(@"评论成功",self.view);
        //        [self dismissModalViewControllerAnimated:YES];
        
        self.dataArray = [data objectForKey:@"data"];
        for(id item in self.dataArray){
            
        }
        [tweetieTableView reloadData];
        
        [self performSelectorOnMainThread:@selector(updateUIData:) withObject:data waitUntilDone:NO];
        
    }
    if(self.request ==respRequest && [resKey isEqualToString:@"addreply"])
    {
        //        if ([self.externDelegate respondsToSelector:@selector(commentDidSendOK:)]) {
        //            [self.externDelegate commentDidSendOK:self];
        //        }
        //        kNetEndSuccStr(@"回复成功",self.view);
        //        [self dismissModalViewControllerAnimated:YES];
    }
    
    //self.view.userInteractionEnabled = YES;
}
- (void)updateUIData:(NSDictionary*)netData{
    kNetEnd(self.view);
    
    
}
-(void)didNetDataFailed:(NSNotification*)ntf
{
    //kNetEndWithErrorAutoDismiss
}


@end
