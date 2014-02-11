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

#define kHeaderColounmItemWidthArray @[@80.f,@80.f,@80.f]

@implementation BidStartedViewController

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
	//return  5;
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    
    
    BidStartedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
#if 0
        NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:@"BidItemCell"
                                                        owner:self options:nil];
        for (id oneObject in nibArr)
            if ([oneObject isKindOfClass:[BidItemCell class]])
                cell = (BidItemCell*)oneObject;
#else
        cell = [[BidStartedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
#endif
        
         [cell addColumWithKeyTitleArray:@[@"场次",@"物资号",@"当前价"] withColumWidthArray:kHeaderColounmItemWidthArray];
         
         [cell addColumWithKeyTitleArray:@[@"结束时间",@"竞价梯度",@"我的出价"] withColumWidthArray:kHeaderColounmItemWidthArray];
        
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
    value = [item objectForKey:@"id"];
   [cell setCellItemValue:value withRow:row withCol:index++];
    
    //sell company
    value = [item objectForKey:@"dqj"];
    
    [cell setCellItemValue:value withRow:row withCol:index++];
    row = 1;
    index =0;
    //sell company
    value = [item objectForKey:@"jssj"];
    
    [cell setCellItemValue:value withRow:row withCol:index++];
    
    //起拍价
    value = [item objectForKey:@"bjtd"];
    
    [cell setCellItemValue:value withRow:row withCol:index++];
    
    //是否参加
    value = [item objectForKey:@"myPrice"];
   
    [cell setCellItemValue:value withRow:row withCol:index++];
    
    //time
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 125.f;
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

    return;
}
- (void)updateUIData:(NSDictionary*)data{

    [tweetieTableView  reloadData];
    
}
@end
