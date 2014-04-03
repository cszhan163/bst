//
//  OrderListMainViewController.m
//  BSTell
//
//  Created by cszhan on 14-3-30.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "OrderListMainViewController.h"
#import "OrderListViewController.h"
#import "OrderListConfirmedViewController.h"
#define  kOilNavControllerItemWidth   160

@interface OrderListMainViewController (){

    NSInteger currIndex;
}
@end

@implementation OrderListMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    //[self didSelectorNavItem:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavgationBarTitle:@"到货确认"];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSArray*)viewControllersForNavItemController:(BidBaseViewController*)controller{
    NSMutableArray *vcArray = [NSMutableArray array];
    
    OrderListConfirmedViewController *vcGraphCtl = [[OrderListConfirmedViewController alloc]init];
    vcGraphCtl.confirmTag = 1;
    vcGraphCtl.view.backgroundColor = [UIColor clearColor];
    /*
     vcGraphCtl.isNeedInitDateMonth = NO;
     vcGraphCtl.mCurrDate = self.mCurrDate;
     */
    vcGraphCtl.parentNav = self.navigationController;
    [vcArray addObject:vcGraphCtl];
    SafeRelease(vcGraphCtl);
    
    
    OrderListViewController *vcCtl = [[OrderListViewController alloc]init];
    /*
     vcCtl.isNeedInitDateMonth = NO;
     vcCtl.mCurrDate = self.mCurrDate;
     */
    vcCtl.view.backgroundColor = [UIColor clearColor];
    vcCtl.parentNav = self.navigationController;
    //vcCtl.view.backgroundColor = [UIColor redColor];
    [vcArray addObject:vcCtl];
    SafeRelease(vcCtl);
   
    return  vcArray;
}
-(NETopNavBar*)topNavBarForNavItemController:(BidBaseViewController*)controller{
    
    NSMutableArray *btnArray = [NSMutableArray array];
    CGFloat currX = 40.f;
    UIButton *btn = [UIComUtil createButtonWithNormalBGImageName:nil withSelectedBGImageName:@"bid_caterlog_mask.png"  withTitle:@"已确认" withTag:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:HexRGB(153, 153, 153) forState:UIControlStateNormal];
    [btn setTitleColor:HexRGB(231, 234, 236) forState:UIControlStateSelected];
    
    btn.frame = CGRectMake(currX, 10.f,btn.frame.size.width, btn.frame.size.height);
    
    [btnArray addObject:btn];
    currX = currX+kOilNavControllerItemWidth;
    btn = [UIComUtil createButtonWithNormalBGImageName:nil  withSelectedBGImageName:@"bid_caterlog_mask.png" withTitle:@"未确认" withTag:1];
    
    btn.frame = CGRectMake(currX, 10.f,btn.frame.size.width, btn.frame.size.height);
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:HexRGB(153, 153, 153) forState:UIControlStateNormal];
    [btn setTitleColor:HexRGB(231, 234, 236) forState:UIControlStateSelected];
    
    [btnArray addObject:btn];
    
    NETopNavBar *topNavBar = [[NETopNavBar alloc]initWithFrame:CGRectMake(0.f, 0.f,320.f,40)withBgImage:nil withBtnArray:btnArray selIndex:0];
    topNavBar.backgroundColor = HexRGB(190, 221, 238);
    //topNavBar.delegate = self;
    return topNavBar;
}

- (void)selectTopNavItem:(id)navObj{
    //[navItemCtrl didSelectorTopNavItem:navObj];
    [super selectTopNavItem:navObj];
    currIndex = [navObj intValue];
}

#pragma mark -
#pragma mark network



- (void)loadAnalaysisData{
    
    
    
}
- (void)didSelectorNavItem:(id)sender{
    
    //if([sender tag] == 0)
    [navItemCtrl.currentViewController reflushData];
    
    
}

@end