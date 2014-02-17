//
//  MsgMainViewController.m
//  BSTell
//
//  Created by cszhan on 14-2-16.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "MsgMainViewController.h"
#import "BSTellNetListBaseViewController.h"

#define kNavViewControllerArray  @[@"HotMsgViewController",@"MarketMsgViewController",@"MediaMsgViewController"]



#define  kMarketClassTitleArray \
@[@"煤焦油产业链专区",\
@"工业萘产业链专区",\
@"芳烃产业链专区",\
@"纯苯下游专区"]

#define kHotClassTitleArray  \
@[@"交易快报",\
@"行业焦点",\
@"分析指南",\
@"报告"]

#define kMeidaClassTitleArray \
@[@"行业资讯",\
@"财经资讯",\
@"新浪财经",\
@"华尔街见闻"]



#define kTopLevelTitleArray @[kHotClassTitleArray,kMarketClassTitleArray,kMeidaClassTitleArray]

@interface MsgMainViewController ()

@end

@implementation MsgMainViewController

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
-(NSArray*)viewControllersForNavItemController:(BidBaseViewController*)controller{
    
    
    NSMutableArray *vcArray = [NSMutableArray array];
    
    for(int i = 0;i<[kNavViewControllerArray count];i++){
        NSLog(@"%@",NSStringFromClass(NSClassFromString(kNavViewControllerArray[i])));
        BSTellNetListBaseViewController *vcCtl = [[NSClassFromString(kNavViewControllerArray[i]) alloc]init];
        vcCtl.parentNav = self.navigationController;
        vcCtl.dataArray = kTopLevelTitleArray[i];
        [vcArray addObject:vcCtl];
        SafeRelease(vcCtl);
    }
    
//    BidStartedViewController *vcCtl = [[BidStartedViewController alloc]init];
//    /*
//     vcCtl.isNeedInitDateMonth = NO;
//     vcCtl.mCurrDate = self.mCurrDate;
//     */
//    vcCtl.view.backgroundColor = [UIColor clearColor];
//      vcCtl.parentNav = self.navigationController;
//    //vcCtl.view.backgroundColor = [UIColor redColor];
//    [vcArray addObject:vcCtl];
//    SafeRelease(vcCtl);
//    BidPrepareViewController *vcGraphCtl = [[BidPrepareViewController alloc]init];
//    vcGraphCtl.view.backgroundColor = [UIColor clearColor];
//    /*
//     vcGraphCtl.isNeedInitDateMonth = NO;
//     vcGraphCtl.mCurrDate = self.mCurrDate;
//     */
//    [vcArray addObject:vcGraphCtl];
//    SafeRelease(vcGraphCtl);
    
    
    
    return  vcArray;
}
-(NETopNavBar*)topNavBarForNavItemController:(BidBaseViewController*)controller{
    
    NSMutableArray *btnArray = [NSMutableArray array];
    CGFloat currX = 10.f;
    UIButton *btn = [UIComUtil createButtonWithNormalBGImageName:nil withSelectedBGImageName:@"bid_caterlog_mask.png"  withTitle:@"热点关注" withTag:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:HexRGB(153, 153, 153) forState:UIControlStateNormal];
    [btn setTitleColor:HexRGB(231, 234, 236) forState:UIControlStateSelected];
    
    btn.frame = CGRectMake(currX, 10.f,btn.frame.size.width, btn.frame.size.height);
    
    [btnArray addObject:btn];
    
    
    currX = 40+currX+70.f;
    btn = [UIComUtil createButtonWithNormalBGImageName:nil  withSelectedBGImageName:@"bid_caterlog_mask.png" withTitle:@"媒体聚焦" withTag:1];
    
    btn.frame = CGRectMake(currX, 10.f,btn.frame.size.width, btn.frame.size.height);
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    /*
    [btn setTitleColor:HexRGB(153, 153, 153) forState:UIControlStateNormal];
    [btn setTitleColor:HexRGB(231, 234, 236) forState:UIControlStateSelected];
     */
    [btnArray addObject:btn];
    
    currX = 40+currX+70.f;
    btn = [UIComUtil createButtonWithNormalBGImageName:nil  withSelectedBGImageName:@"bid_caterlog_mask.png" withTitle:@"媒体视角" withTag:2];
    
    btn.frame = CGRectMake(currX, 10.f,btn.frame.size.width, btn.frame.size.height);
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    /*
    [btn setTitleColor:HexRGB(153, 153, 153) forState:UIControlStateNormal];
    [btn setTitleColor:HexRGB(231, 234, 236) forState:UIControlStateSelected];
    */
    [btnArray addObject:btn];

    
    
    
    
    /*
     CGFloat currX = 0.f;
     UIButton *btn = [UIComUtil createButtonWithNormalBGImageName:nil withHightBGImageName:nil  withTitle:@"" withTag:0];
     btn.frame = CGRectMake(currX, 10.f,150, 30.f);
     [btnArray addObject:btn];
     btn = [UIComUtil createButtonWithNormalBGImageName:nil withHightBGImageName:nil withTitle:@"驾驶分析" withTag:0];
     btn.frame = CGRectMake(160.f, 10.f,150, 30.f);
     [btnArray addObject:btn];
     */
    NETopNavBar *topNavBar = [[NETopNavBar alloc]initWithFrame:CGRectMake(0.f, 0.f,320.f,40)withBgImage:nil withBtnArray:btnArray selIndex:0];
    topNavBar.backgroundColor = HexRGB(190, 221, 238);
    //topNavBar.delegate = self;
    return topNavBar;
}

@end
