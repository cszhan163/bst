//
//  BidMainViewController.m
//  BSTell
//
//  Created by cszhan on 14-2-1.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "BidMainViewController.h"

#import "BidStartedViewController.h"
#import "BidPrepareViewController.h"

#define  kOilNavControllerItemWidth   160

@interface BidMainViewController (){

    NSInteger currIndex;
}
@property(nonatomic,strong) NSArray *startedDataArray;
@property(nonatomic,strong) NSArray *prepareDataArray;
@end

@implementation BidMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.startedDataArray = [NSMutableArray array];
        self.prepareDataArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setNavgationBarTitle:@"竞买出价"];
}
- (void)viewWillAppear:(BOOL)animated{


}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray*)viewControllersForNavItemController:(BidBaseViewController*)controller{
    NSMutableArray *vcArray = [NSMutableArray array];
    BidStartedViewController *vcCtl = [[BidStartedViewController alloc]init];
    /*
    vcCtl.isNeedInitDateMonth = NO;
    vcCtl.mCurrDate = self.mCurrDate;
    */
    vcCtl.view.backgroundColor = [UIColor clearColor];
    vcCtl.parentNav = self.navigationController;
    //vcCtl.view.backgroundColor = [UIColor redColor];
    [vcArray addObject:vcCtl];
    SafeRelease(vcCtl);
    BidPrepareViewController *vcGraphCtl = [[BidPrepareViewController alloc]init];
    vcGraphCtl.view.backgroundColor = [UIColor clearColor];
    /*
    vcGraphCtl.isNeedInitDateMonth = NO;
    vcGraphCtl.mCurrDate = self.mCurrDate;
     */
    [vcArray addObject:vcGraphCtl];
    SafeRelease(vcGraphCtl);
    return  vcArray;
}
-(NETopNavBar*)topNavBarForNavItemController:(BidBaseViewController*)controller{
    
    NSMutableArray *btnArray = [NSMutableArray array];
    CGFloat currX = 40.f;
    UIButton *btn = [UIComUtil createButtonWithNormalBGImageName:nil withSelectedBGImageName:@"bid_caterlog_mask.png"  withTitle:@"已开始竞价" withTag:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:HexRGB(153, 153, 153) forState:UIControlStateNormal];
    [btn setTitleColor:HexRGB(231, 234, 236) forState:UIControlStateSelected];

    btn.frame = CGRectMake(currX, 10.f,btn.frame.size.width, btn.frame.size.height);
    
    [btnArray addObject:btn];
    currX = currX+kOilNavControllerItemWidth;
    btn = [UIComUtil createButtonWithNormalBGImageName:nil  withSelectedBGImageName:@"bid_caterlog_mask.png" withTitle:@"未开始竞价" withTag:1];
    
    btn.frame = CGRectMake(currX, 10.f,btn.frame.size.width, btn.frame.size.height);
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:HexRGB(153, 153, 153) forState:UIControlStateNormal];
    [btn setTitleColor:HexRGB(231, 234, 236) forState:UIControlStateSelected];
    
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
    topNavBar.backgroundColor = [UIColor blueColor];
    //topNavBar.delegate = self;
    return topNavBar;
}

- (void)selectTopNavItem:(id)navObj{
    //[navItemCtrl didSelectorTopNavItem:navObj];
    [super selectTopNavItem:navObj];
    currIndex = [navObj intValue];
    if(currIndex == 0){
        
        if([self.startedDataArray count] == 0){
            /*
             BidStartedViewController *oilDataVc = [navItemCtrl.navControllersArr objectAtIndex:0];
            [oilDataVc shouldLoadOlderData:nil];
             */
        }
        else{
        
        
        }
    }
    
}

#pragma mark -
#pragma mark network



- (void)loadAnalaysisData{
    
    
    
}



@end
