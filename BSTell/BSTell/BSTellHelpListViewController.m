//
//  BSTellHelpListViewController.m
//  BSTell
//
//  Created by cszhan on 14-4-12.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "BSTellHelpListViewController.h"

#define kSetingTitleArray @[\
@"我如何参加竞买？",\
@"我如何做到货确认？",\
@"我如何查看交易公告？",\
]

@interface BSTellHelpListViewController ()

@end

@implementation BSTellHelpListViewController

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
    
    //[self setNavgationBarTitle:@"关于我们"];
    
    [self setHiddenRightBtn:YES];
   
    CGFloat currY = kMBAppTopToolBarHeight+30.f;
    tweetieTableView.frame = CGRectMake(0.f, currY, kDeviceScreenWidth,200.f);
    
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
	//return  3;
    return [kSetingTitleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
#if 0
        NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:@"BidItemCell"
                                                        owner:self options:nil];
        for (id oneObject in nibArr)
            if ([oneObject isKindOfClass:[BidItemCell class]])
                cell = (BidItemCell*)oneObject;
#else
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
#endif
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.clipsToBounds = YES;
        
    }
    /*
     返回JSON数据参数	参数名称	参数类型
     wtid	场次Id
     ggmc	公告title
     ggid	公告id
     joinStatus	参加状态	1 参加
     0 未参加
     hzjc	卖家简称
     dfyj	买家保证金
     kssj	竞价开始时间
     jssj	竞价结束时间
     isCanJoin	可参加状态	1 可参加
     0 不可参加
     ssdl	所属大类
     
     */
    cell.textLabel.text = kSetingTitleArray[indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    //
    //    BidDetailViewController *vc = [[BidDetailViewController alloc]initWithNibName:nil bundle:nil];
    //    [vc  setNavgationBarTitle:@"详情"];
    //    /*
    //     vc.delegate = self;
    //     NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
    //     //NSDictionary *data = [item objectForKey:@"DayDetailInfo"];
    //     vc.mData = item;
    //     */
    //#if 1
    //    [self.navigationController pushViewController:vc animated:YES];
    //#else
    //
    //    [ZCSNotficationMgr postMSG:kPushNewViewController obj:vc];
    //     SafeRelease(vc);
    //#endif
    //[self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}
@end
