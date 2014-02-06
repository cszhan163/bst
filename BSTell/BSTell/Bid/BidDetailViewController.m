//
//  BidDetailViewController.m
//  BSTell
//
//  Created by cszhan on 14-2-1.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "BidDetailViewController.h"
#import "BidDetailTableViewCell.h"
#import "BidConfirmViewController.h"
#define kLeftPendingX 10.f



#define kMaxItemClounm 3
#define kHeaderColounmItemWidthArray @[@100.f,@100.f,@100.f]

#define kTableColounmItemWidthArray @[@110.f,@65.f,@65.f,@65.f]
#define kCellHeight  18.f;

@interface BidDetailViewController (){

    BidDetailTableViewCell *headerView;
    BidDetailTableViewCell *tableView;
}
@end

@implementation BidDetailViewController

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
    
    
    tweetieTableView.dataSource = nil;
    tweetieTableView.delegate = nil;
    tweetieTableView.hidden = YES;
    
    //add headerview;
    
    CGFloat currY = kMBAppTopToolBarHeight+5.f;
    UIImageWithFileName(UIImage *image , @"bid_detail_header.png");
    
    
    headerView = [[BidDetailTableViewCell alloc]initWithFrame:CGRectMake(kLeftPendingX, currY,image.size.width/kScale, image.size.height/kScale) withRowCount:2 withColumCount:3 withCellHeight:20 withHeaderTitle:@"场次信息"];
    
    [headerView setHeaderLabelText:@"场次信息"];
    [headerView addColumWithKeyTitleArray:@[@"场次编号",@"场次名称",@"参与方式"] withColumWidthArray:kHeaderColounmItemWidthArray];
    
    [headerView addColumWithKeyTitleArray:@[@"竞价日",@"开始时间",@"结束时间"] withColumWidthArray:kHeaderColounmItemWidthArray];
    
    headerView.layer.contents = (id)image.CGImage;
    [self.view addSubview:headerView];
    SafeRelease(headerView);
    
    currY = 185.f;
    UIImageWithFileName(image , @"bid_detail_table.png");
    
    tableView = [[BidDetailTableViewCell alloc]initWithFrame:CGRectMake(kLeftPendingX, currY,image.size.width/kScale, image.size.height/kScale) withRowCount:5 withColumCount:4 withCellHeight:20 withHeaderTitle:@"物资信息"];
    tableView.layer.contents = (id)image.CGImage;
    
    [tableView addColumWithKeyTitleArray:@[@"物资编号",@"竞价模式",@"报盘方式",@"计价方式"] withColumWidthArray:kTableColounmItemWidthArray];
    
    [tableView addColumWithKeyTitleArray:@[@"起拍价",@"总量",@"竞价梯度",@"成交价"] withColumWidthArray:kTableColounmItemWidthArray];
    
    
    [self.view addSubview:tableView];
    SafeRelease(tableView);
    
    [self addFonterView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addFonterView{
    
    //    logInfo.frame = CGRectMake(0,kMBAppTopToolBarHeight-self.mainContentViewPendingY,kDeviceScreenWidth,kDeviceScreenHeight-kMBAppTopToolBarHeight-kMBAppStatusBar-kMBAppBottomToolBarHeght- 60 );
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0.f,0.f,300.f,80)];
    bgView.backgroundColor = HexRGB(202, 202, 204);
    
    CGFloat currY = kDeviceScreenHeight-kMBAppTopToolBarHeight-kMBAppStatusBar-kMBAppBottomToolBarHeght- 60+10.f;
    UIButton *oilAnalaysisBtn = [UIComUtil createButtonWithNormalBGImageName:@"bid_start_btn.png" withHightBGImageName:@"bid_start_btn.png" withTitle:@"参加竞价" withTag:0];
    
    CGSize btnsize= oilAnalaysisBtn.frame.size;
    //currY = 10.f;
    currY = currY+50.f;
     oilAnalaysisBtn.frame = CGRectMake(10.f,currY,btnsize.width,btnsize.height);
    [oilAnalaysisBtn addTarget:self action:@selector(logOutConfirm:) forControlEvents:UIControlEventTouchUpInside];
    //[logInfo addSubview:oilAnalaysisBtn];
    //
#if 1
    [self.view addSubview:oilAnalaysisBtn];
    
#else
   
    [bgView addSubview:oilAnalaysisBtn];
    [tweetieTableView setTableFooterView:bgView];
#endif
   
}
#pragma mark -
#pragma mark tableView dataSource
//- (NSInteger)tableView:(UITableView *)tableView section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
    return 2;
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if(indexPath.row == 1){
    
        return 127.f;
    }
    return  263.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  0.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *LabelTextFieldCell = @"LabelTextFieldCell";
	
	UITableViewCell *cell = nil;
    
    //[KokTool endTimeCheckPoint:@"tableViewCell"];
    
	cell = [tableView dequeueReusableCellWithIdentifier:LabelTextFieldCell];
	
    return cell;
    
}
- (void)logOutConfirm:(id)sender{

    BidConfirmViewController *bidConfirmVc = [[BidConfirmViewController alloc]init];
    
    [self.navigationController pushViewController:bidConfirmVc animated:YES];

    SafeRelease(bidConfirmVc);
}
@end
