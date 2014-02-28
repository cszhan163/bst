//
//  CarDataAnalysisBaseViewController.m
//  BodCarManger
//
//  Created by cszhan on 13-10-2.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "BidBaseViewController.h"



#define kLeftPendingX  0
#define kTopPendingY  0.f
#define kHeaderItemPendingY 8

@interface BidBaseViewController ()

//@property(nonatomic,weak)id<CarDataAnalysisBaseViewControllerDelegate> dataSouce;
@end

@implementation BidBaseViewController
- (void)dealloc{
    [super dealloc];
    [navItemCtrl release];
}
@synthesize dataSouce;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         self.dataSouce = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
    [self setHiddenLeftBtn:YES];
     */
    [self setHiddenRightBtn:YES];
    
  
    //self.view.backgroundColor = [UIColor clearColor];
    UIImage *bgImage = nil;
    UIImageWithFileName(bgImage, @"car_bg.png");
    mainView.bgImage = bgImage;
    
    UIImageWithFileName(bgImage, @"car_plant_bg.png");
    UIImageView *tableViewBg = [[UIImageView alloc]initWithImage:bgImage];
    [self.view  addSubview:tableViewBg];
      
    tableViewBg.frame = CGRectMake(kLeftPendingX,kMBAppTopToolBarHeight+kTopPendingY,kDeviceScreenWidth-2*kLeftPendingX,kDeviceScreenHeight-kMBAppStatusBar-kMBAppTopToolBarHeight-2*kLeftPendingX);
    tableViewBg.clipsToBounds = YES;
    
    tableViewBg.clipsToBounds = YES;
    tableViewBg.userInteractionEnabled = YES;
     
    navItemCtrl = [[NENavItemController alloc]init];
    //self.dataSouce = self;
    //navItemCtrl.toolbarItems =
    NSArray *vcArray = [self.dataSouce viewControllersForNavItemController:self];
    navItemCtrl.navControllersArr = vcArray;
    
    NETopNavBar *topNavBar = [self.dataSouce topNavBarForNavItemController:self];
    
   //
    //topNavBar.delegate = navItemCtrl;
    
    [tableViewBg addSubview:navItemCtrl.view];
    navItemCtrl.view.frame = CGRectMake(0.f,3.f,kDeviceScreenWidth,kDeviceScreenHeight-kMBAppStatusBar-kMBAppTopToolBarHeight);
    
//    if(kIsIOS7Check){
//        navItemCtrl.view.frame = CGRectMake(0.f,-20.f,kDeviceScreenWidth,kDeviceScreenHeight-kMBAppStatusBar-kMBAppBottomToolBarHeght-kMBAppTopToolBarHeight+100);
//    }

    
#if 1
    [tableViewBg addSubview:topNavBar];
    SafeRelease(topNavBar);
    //topNavBar.hidden = YES;
    [navItemCtrl setTopNavBar:topNavBar];
    //topNavBar.frame = CGRectOffset(topNavBar.frame, 0.f,kMBAppTopToolBarHeight);
    [topNavBar didNavItemSelect:[topNavBar.navBtnArray objectAtIndex:0]];
#endif
    [self.view bringSubviewToFront:mainView.topBarView ];
    [self setNeedDisplaySubView];
    //[self  performSelectorInBackground:@selector(loadAnalaysisData) withObject:nil];
    [self loadAnalaysisData];
	// Do any additional setup after loading the view.
}
#pragma mark -
#pragma mark overide method
- (void)loadAnalaysisData{


}
- (void)selectTopNavItem:(id)navObj{
    [navItemCtrl didSelectorTopNavItem:navObj];
}
- (void)setNeedDisplaySubView{

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
