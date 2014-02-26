//
//  SettingViewController.m
//  BSTell
//
//  Created by cszhan on 14-1-30.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "SettingViewController.h"

#define kSetingTitleArray @[\
    @"功能介绍",\
    @"版本更新",\
    @"关于",\
    @"客服电话",\
]

@interface SettingViewController ()

@end

@implementation SettingViewController

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
    [self setHiddenLeftBtn:YES];
    [self setNavgationBarTitle:@"关于我们"];
    
    [self setHiddenLeftBtn:YES];
    //for logo
    UIImageWithFileName(UIImage* image, @"logo.png");
    
    UIImageView *logoImageView = [[UIImageView alloc]initWithImage:image];
    [self.view addSubview:logoImageView];
    SafeRelease(logoImageView);
    
    CGFloat currY = 40.f+kMBAppBottomToolBarHeght;
    logoImageView.frame = CGRectMake(0.f, 0.f, image.size.width/kScale, image.size.height/kScale);
    logoImageView.center = CGPointMake(kDeviceScreenWidth/kScale, currY);
    currY = currY+40.f;
    tweetieTableView.frame = CGRectMake(0.f, currY, kDeviceScreenWidth,200.f);
    
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
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
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
    
    return 50.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row<3){
        kUIAlertView(@"信息", @"正在建设,敬请期待!");
    }
    else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4008206662"]];
    }
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
