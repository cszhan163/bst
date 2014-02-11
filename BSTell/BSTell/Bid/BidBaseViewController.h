//
//  CarDataAnalysisBaseViewController.h
//  BodCarManger
//
//  Created by cszhan on 13-10-2.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "UIBaseViewController.h"
#import "NENavItemController.h"
//#import "BaoCarNetBaseViewController.h"
#import "BSTellBaseViewController.h"
@protocol BidBaseViewControllerDataSouceDelegate;
@interface BidBaseViewController : BSTellBaseViewController{
    @public
    NENavItemController *navItemCtrl;
    //DateStruct   *mCurrDate;
}
//@property(nonatomic,assign)DateStruct   mCurrDate;
@property(weak)id<BidBaseViewControllerDataSouceDelegate> dataSouce;
- (void)loadAnalaysisData;
- (void)setNeedDisplaySubView;
- (void)selectTopNavItem:(id)navObj;
@end
@protocol BidBaseViewControllerDataSouceDelegate<NSObject>
@required
//-(NSInteger)tabBarItemCount:(NTESMBMainMenuController*)controller ;
-(NSArray*)viewControllersForNavItemController:(BidBaseViewController*)controller;
-(NETopNavBar*)topNavBarForNavItemController:(BidBaseViewController*)controller;
@end