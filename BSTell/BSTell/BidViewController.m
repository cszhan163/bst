//
//  BidViewController.m
//  BSTell
//
//  Created by cszhan on 14-1-30.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#define kLeftPendingX  10
#define kTopPendingY  8
#define kHeaderItemPendingY 8

#import "BidItemCell.h"
#import "BidViewController.h"

#import "BidDetailViewController.h"

#import "BidMainViewController.h"

@interface BidViewController(){
    UIView *tbHeaderView;
}
@property(nonatomic,strong)NSDictionary *locationDict;
@end

@implementation BidViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated{
    
    if([self.dataArray count]==0){
        
        //[self performSelectorInBackground:@selector(shouldLoadNewerData:) withObject:tweetieTableView];
        //self.locationDict = [DBManage getLocationPointsData];
        [self shouldLoadNewerData:tweetieTableView];
    }
    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //[super viewDidDisappear:animated];
    //[[DBManage getSingletone]setDelegate:nil];
    

    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //[[DBManage getSingletone]setDelegate:self];
    //    CGPoint insertPoint = CGPointMake(167,50);
    //    int width = 300;
    //    int height = 250;
    //
    //
    //    OCCalendarView  *calView = [[OCCalendarView alloc] initAtPoint:insertPoint withFrame:CGRectMake(insertPoint.x-157, insertPoint.y, width, height) arrowPosition:OCArrowPositionNone];
    //    [calView setSelectionMode:OCSelectionDateRange];
    //    //[calView setArrowPosition:];
    //    [self.view addSubview:[calView autorelease]];
    //    return;
    
#if 1
    UIImage *bgImage = nil;
    UIImageWithFileName(bgImage, @"car_bg.png");
    mainView.bgImage = bgImage;
#else
    mainView.mainFramView.backgroundColor = kAppUserBGWhiteColor;
#endif
    //mainView.alpha = 0.;
    if(navBarTitle == nil)
        [self setNavgationBarTitle:NSLocalizedString(@"参加竞买", @""
                                                     )];
    [self setHiddenRightBtn:NO];
    [self setHiddenLeftBtn:YES];
    UIImageWithFileName(bgImage, @"bid_btn.png");
    CGRect newRect = CGRectMake(kDeviceScreenWidth-30.f-bgImage.size.width/2.f, 10.f, bgImage.size.width/kScale, bgImage.size.height/kScale);
    self.rightBtn.frame = newRect;
    [self.rightBtn setBackgroundImage:bgImage forState:UIControlStateNormal];
    [self.rightBtn setBackgroundImage:bgImage forState:UIControlStateHighlighted];
    [self.rightBtn setTitle:@"进入竞价" forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"进入竞价" forState:UIControlStateHighlighted];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    //[self setRightTextContent:NSLocalizedString(@"Done", @"")];
	// Do any additional setup after loading the view.
    tweetieTableView.frame = CGRectMake(kLeftPendingX,kMBAppTopToolBarHeight+kTopPendingY,kDeviceScreenWidth-2*kLeftPendingX,kMBAppRealViewHeight-kTopPendingY);
    //mainView.topBarView.backgroundColor = HexRGB(1, 159, 233);
    /*
    UIImageWithFileName(bgImage, @"car_plant_bg.png");
    UIImageView *tableViewBg = [[UIImageView alloc]initWithImage:bgImage];
    [self.view  addSubview:tableViewBg];
    SafeRelease(tableViewBg);
    tableViewBg.frame = tweetieTableView.frame;
    [tweetieTableView removeFromSuperview];
    [tableViewBg addSubview:tweetieTableView];
    tweetieTableView.frame = CGRectMake(0.f,0.f,tableViewBg.frame.size.width,tableViewBg.frame.size.height);
    
    tableViewBg.clipsToBounds = YES;
    tableViewBg.userInteractionEnabled = YES;
     */
    tweetieTableView.delegate = self;
    tweetieTableView.backgroundColor = [UIColor clearColor];
    tweetieTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tweetieTableView.clipsToBounds = YES;
    
    /*
    tbHeaderView = [self addHeaderView:tableViewBg   withArrayData:nil];
    tweetieTableView.normalEdgeInset = UIEdgeInsetsMake(tbHeaderView.frame.size.height,0.f,0.f,0.f);
    */
#if 0
    NSError *error = nil;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"plantData" ofType:@"geojson"];
    NSString *dataStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    //[NSJSONSerialization]
    
    NSDictionary *restData = [NSJSONSerialization   JSONObjectWithData:[dataStr dataUsingEncoding:NSUTF8StringEncoding ]options:NSJSONReadingMutableContainers  error:&error];
    
    self.dataArray = [[restData objectForKey:@"info"] objectForKey:@"data"];
    
    [tweetieTableView reloadData];
    
    
#else
    //[self  ]
    
#endif
    
}
- (UIView*)addHeaderView:(UIView*)parentView withArrayData:(NSArray*)dataArr{
    UIImage *bgImage = nil;
    UIImageWithFileName(bgImage, @"car_plant_header.png");
    UIView *headerView = [[UIImageView alloc]initWithImage:bgImage];
    headerView.frame = CGRectMake(0.,-1., bgImage.size.width/kScale, bgImage.size.height/kScale);
    [parentView addSubview:headerView];
    CGFloat startX = 5.f;
    CGFloat itemWidth = 60.f;
    for(int i =0;i<4;i++){
        NSString *fileName = [NSString stringWithFormat:@"plant_header_tag%d.png",i];
        UIImageWithFileName(bgImage,fileName);
        assert(bgImage);
        UIImageView *item = [[UIImageView alloc]initWithImage:bgImage];
        CGFloat offsetY = 0.f;
        if(i == 2){
            offsetY = -2.f;
        }
        item.frame = CGRectMake(startX,kHeaderItemPendingY+offsetY,bgImage.size.width/kScale, bgImage.size.height/kScale);
        startX += item.frame.size.width +5.f;
        UILabel *valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(startX,kHeaderItemPendingY,itemWidth,14.f)];
        valueLabel.font = [UIFont systemFontOfSize:12];
        valueLabel.text = @"";
        valueLabel.tag = i;
        valueLabel.adjustsFontSizeToFitWidth = YES;
        valueLabel.textColor = [UIColor whiteColor];
        valueLabel.backgroundColor = [UIColor clearColor];
        [headerView addSubview:valueLabel];
        SafeRelease(valueLabel);
        [headerView addSubview:item];
        SafeRelease(item);
        startX += 40+20.f;
    }
    return SafeAutoRelease(headerView);
}
#pragma mark -
#pragma mark tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return  5;
    //return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
   
    
    BidItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
#if 0
        NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:@"BidItemCell"
                                                        owner:self options:nil];
        for (id oneObject in nibArr)
            if ([oneObject isKindOfClass:[BidItemCell class]])
                cell = (BidItemCell*)oneObject;
#else
        cell = [[BidItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
#endif
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    
    
//    NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
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
    
    return 140.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    BidDetailViewController *vc = [[BidDetailViewController alloc]initWithNibName:nil bundle:nil];
    [vc  setNavgationBarTitle:@"详情"];
    /*
    vc.delegate = self;
    NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
    //NSDictionary *data = [item objectForKey:@"DayDetailInfo"];
    vc.mData = item;
     */
#if 1
    [self.navigationController pushViewController:vc animated:YES];
#else
    
    [ZCSNotficationMgr postMSG:kPushNewViewController obj:vc];
#endif
    //[self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SafeRelease(vc);
    
}
-(void)didSelectorTopNavigationBarItem:(id)sender{


    if([sender tag] == 1){
    
        BidMainViewController *bidMainVc = [[BidMainViewController alloc]init];
        [self.navigationController pushViewController:bidMainVc animated:YES];
        SafeRelease(bidMainVc);
    }
}

@end
