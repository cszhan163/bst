//
//  BSTellNetListBaseViewController.m
//  BSTell
//
//  Created by cszhan on 14-2-7.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "BSTellNetListBaseViewController.h"

@interface BSTellNetListBaseViewController ()

@end

@implementation BSTellNetListBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dataArray = [NSMutableArray array];
        self.userId = @"";
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    if([self.dataArray count] == 0 &&!isFromViewUnload)
    {
        currentPageNum = 1;
        [self shouldLoadOlderData:tweetieTableView];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    mainView.topBarView.backgroundColor = HexRGB(1, 159, 233);
    mainView.backgroundColor = HexRGB(239, 239, 241);
    self.delegate = self;
    
    tweetieTableView.bounces = YES;
    [tweetieTableView setDragEffect:YES];
    tweetieTableView.hasDownDragEffect = YES;
}
- (void)setTopNavBarHidden:(BOOL)status{
    if(status){
        mainView.topBarView.backgroundColor = [UIColor clearColor];
        [self setHiddenLeftBtn:YES];
        [self setHiddenRightBtn:YES];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) shouldLoadOlderData:(NTESMBTweetieTableView *) tweetieTableView
{
    [super shouldLoadOlderData:tweetieTableView];
    //[self startShowLoadingView];
}
-(void)didNetDataOK:(NSNotification*)ntf
{
    
    //[super didNetDataOK:ntf];
    isRefreshing = NO;
    currentPageNum = currentPageNum+1;
    if (self.reflushType == Reflush_OLDE)
    {
        [tweetieTableView closeBottomView];
    }
    else
    {
        [tweetieTableView closeInfoView];
    }
    
}
#pragma mark -
#pragma mark - override fun

- (void)reloadNetData:(id)data{
    
    if([data objectForKey:@"data"]){
        NSArray *retData = [data objectForKey:@"data"];
        if([retData isKindOfClass:[NSArray class]])
        {
            [self.dataArray addObjectsFromArray:retData];
        }
        for(id item in self.dataArray){
            
        }
    }
    else{
    
        id retData =  data;
        if([retData isKindOfClass:[NSArray class]])
        {
            [self.dataArray addObjectsFromArray:retData];
        }
        for(id item in self.dataArray){
            
        }

    }
    [tweetieTableView reloadData];
}
@end
