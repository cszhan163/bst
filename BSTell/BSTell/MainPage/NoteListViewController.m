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

@interface NoteListViewController ()

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
	// Do any additional setup after loading the view.
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
	return  5;
    //return [self.dataArray count];
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
    
    return 90.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
     NoteDetailViewController *vc = [[NoteDetailViewController alloc]initWithNibName:nil bundle:nil];
    /*
    NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
    //NSDictionary *data = [item objectForKey:@"DayDetailInfo"];
    //vc.mData = item;
     */
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

@end
