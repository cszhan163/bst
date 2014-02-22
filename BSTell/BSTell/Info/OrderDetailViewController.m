//
//  OrderDetailViewController.m
//  BSTell
//
//  Created by cszhan on 14-2-19.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "LeftTitleListCell.h"


#define kPendingX  20.f

#define kPendingY  20.f

/*
 
 */



#define  kOrderTitleArray \
@[@"物资号",\
@"品名",\
@"重量",\
@"金额",\
@"竞价日",\
@"结果",]


@interface OrderDetailViewController (){

    LeftTitleListCell  *agreementInfoView;
    LeftTitleListCell *sellUserInfoView;
    LeftTitleListCell *orderInfoView;
}
@end

@implementation OrderDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#define kCellValueColorArray @[[UIColor blackColor],[UIColor blueColor],[UIColor greenColor],[UIColor redColor]]

#define kCellValueFontArray  @[[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:16],[UIFont systemFontOfSize:16],[UIFont systemFontOfSize:14]]

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    CGFloat currY = 0.f;
    
    UIScrollView *bgScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(kPendingX, kPendingY+kMBAppTopToolBarHeight,kDeviceScreenWidth-2*kPendingX,kDeviceScreenHeight-kMBAppBottomToolBarHeght-kMBAppTopToolBarHeight-kMBAppStatusBar-80.f)];
    bgScrollerView.backgroundColor = [UIColor clearColor];
    bgScrollerView.scrollEnabled = YES;
   
    CGFloat width = bgScrollerView.frame.size.width;
    
    
    NSMutableArray *valueArray = [NSMutableArray array];
    for (int i = 0; i<4; i++) {
        NSMutableDictionary *itemDict = [NSMutableDictionary dictionary];
        [itemDict setObject:kCellValueColorArray[i] forKey:@"color"];
        [itemDict setObject:kCellValueFontArray[i] forKey:@"font"];
        [valueArray addObject:itemDict];
    }
    
    
    orderInfoView = [[LeftTitleListCell alloc]initWithFrame:CGRectMake(0.f,currY,width,130.f) withTitleArray:kOrderTitleArray withTitle:@"订单信息" withValueAtrArray:valueArray withItemPending:15.f];
    //s[orderInfoView setYItemPendingY:10.f];
    //[orderInfoView   ];
    [bgScrollerView addSubview:orderInfoView];
    orderInfoView.userInteractionEnabled = NO;
    orderInfoView.backgroundColor = [UIColor clearColor];
    SafeRelease(orderInfoView);
    
    currY = currY+orderInfoView.frame.size.height;
    
    agreementInfoView = [[LeftTitleListCell alloc]initWithFrame:CGRectMake(0.f,currY,width,130.f) withTitleArray:kOrderTitleArray withTitle:@"合同信息" withValueAtrArray:valueArray withItemPending:15.f];
    //s[orderInfoView setYItemPendingY:10.f];
    //[orderInfoView   ];
    [bgScrollerView addSubview:agreementInfoView];
    agreementInfoView.backgroundColor = [UIColor clearColor];
    agreementInfoView.userInteractionEnabled = NO;
    SafeRelease(agreementInfoView);
    
    
    currY = currY+agreementInfoView.frame.size.height;
    
    sellUserInfoView = [[LeftTitleListCell alloc]initWithFrame:CGRectMake(0.f,currY,width,130.f) withTitleArray:kOrderTitleArray withTitle:@"卖家信息" withValueAtrArray:valueArray withItemPending:15.f];
    //s[orderInfoView setYItemPendingY:10.f];
    //[orderInfoView   ];
    [bgScrollerView addSubview:sellUserInfoView];
     sellUserInfoView.userInteractionEnabled = NO;
    sellUserInfoView.backgroundColor = [UIColor clearColor];
    SafeRelease(sellUserInfoView);
    
    currY = currY+sellUserInfoView.frame.size.height;
    
     bgScrollerView.contentSize = CGSizeMake(bgScrollerView.frame.size.width, currY);
    [self.view addSubview:bgScrollerView];
    SafeRelease(bgScrollerView);
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark -net
- (void)shouldLoadData{
    
    NSDictionary *param  = nil;
    CarServiceNetDataMgr *carServiceNetDataMgr = [CarServiceNetDataMgr getSingleTone];
    {
        /*
         公告ID	ggid
         会员代码	hydm
         */
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 self.orderId,@"orderId",
                 //@"1",@"zc",
                 //@"",@"wtzt",
                 //@"001",@"hydm",
                 //@"10",@"limit",
                 //@"",@"rqStart",
                 //@"",@"rqEnd",
                 nil];
        self.request = [carServiceNetDataMgr  getOrderDetail:param];
    }
}
@end
