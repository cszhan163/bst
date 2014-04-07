//
//  GoodsItemDetailViewController.m
//  BSTell
//
//  Created by cszhan on 14-4-5.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "GoodsItemDetailViewController.h"
#import "LeftTitleListCell.h"

#define kPendingX  20.f

#define kPendingY  20.f
/*
 物资编号
 //         竞价模式
 //         报盘方式
 //         计价方式
 //         起拍价
 //         总量
 //         拼盘梯度
 //         成交价
 //         竞价状态
 //         品名
 //         包装
 //         产地
 //         仓库
 //         重量
 //         计量单位
 //         付款方式
 //         提货方式
 //         交货时间
 //         质量标准
 //         备注
 */

#define  kOrderTitleArray \
@[@"物资号",\
@"品名",\
@"重量",\
@"竞价梯度",\
@"起拍价",\
@"竞价日",\
@"包装",\
@"产地",\
@"付款方式",\
@"竞价状态",\
@"交货时间",\
@"质量标准",\
@"提货方式",\
@"仓库",\
@"备注"]


#define kCellValueColorArray @[[UIColor blackColor],[UIColor blueColor],[UIColor greenColor],[UIColor redColor]]

#define kCellValueFontArray  @[[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:16],[UIFont systemFontOfSize:16],[UIFont systemFontOfSize:14]]

@interface GoodsItemDetailViewController ()

@end

@implementation GoodsItemDetailViewController

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
    
    CGFloat currY = 0.f;
    
    UIScrollView *bgScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0.f,kPendingY+kMBAppTopToolBarHeight,kDeviceScreenWidth,kDeviceScreenHeight-kMBAppBottomToolBarHeght-kMBAppTopToolBarHeight-kMBAppStatusBar-80.f)];
    bgScrollerView.backgroundColor = [UIColor clearColor];
    bgScrollerView.scrollEnabled = YES;
    
    CGFloat width = bgScrollerView.frame.size.width;
    LeftTitleListCell *orderInfoView = [[LeftTitleListCell alloc]initWithFrame:CGRectMake(kPendingX,currY,width,409.f) withTitleArray:@[] withTitle:@"" withValueAtrArray:@[] withItemPending:15.f ];
    //s[orderInfoView setYItemPendingY:10.f];
    //[orderInfoView   ];
    [self.view addSubview:orderInfoView];
    
    NSDictionary *netData = self.data;
    NSInteger index = 0;
    NSString *value = nil;
    
    /*
    
     wtmc	场次名称
     joinWay	参与方式
     auctionDate	竞价日
     kssj	开始时间
     jssj	结束时间
     data[]	物资信息
     goodId	物资编号
     auctionMode	竞价模式
     offerWay	报盘方式
     pricingWay	计价方式
     startPrice	起拍价
     totalCount	总量
     bjtd	拼盘梯度
     soldPrice	成交价
     auctionStatus	竞价状态
     goodName	品名
     packages	包装
     place	产地
     warehouse	仓库	
     weight	重量	
     unit	计量单位	
     payment	付款方式	
     deliveryWay	提货方式	
     deliveryTime	交货时间	
     QS	质量标准	
     note	备注	

     joinStatus	参加状态	1 参加
     0 未参加
     isCanJoin	可参加状态	1 可参加
     0 不可参加
     */
    
    value = [netData objectForKey:@"goodId"];
    [orderInfoView setCellItemValue:value withRow:index++];
    value = [netData objectForKey:@"goodName"];
    [orderInfoView setCellItemValue:value withRow:index++];
    value = [netData objectForKey:@"weight"];
    value = [NSString stringWithFormat:@"%@ 吨",value];
    [orderInfoView setCellItemValue:value withRow:index++];
    //bjtd
    value = [netData objectForKey:@"bjtd"];
    value = [NSString stringWithFormat:@"%@ 元",value];
    [orderInfoView setCellItemValue:value withRow:index++];
    
    value = [netData objectForKey:@"qpj"];
    value = [NSString stringWithFormat:@"%@ 元",value];
    [orderInfoView setCellItemValue:value withRow:index++];
    
    value = [netData objectForKey:@"packages"];
    [orderInfoView setCellItemValue:value withRow:index++];
    
    value = [netData objectForKey:@"place"];
    [orderInfoView setCellItemValue:value withRow:index++];
    //place
    value = [netData objectForKey:@"payment"];
    [orderInfoView setCellItemValue:value withRow:index++];
    
    value = [netData objectForKey:@"auctionStatus"];
    [orderInfoView setCellItemValue:value withRow:index++];

    
    
    value = [netData objectForKey:@"deliveryTime"];
    
    [orderInfoView setCellItemValue:value withRow:index++];
    
 
    
    value = [netData objectForKey:@"QS"];
    [orderInfoView setCellItemValue:value withRow:index++];
   
    
    
    value = [netData objectForKey:@"deliveryWay"];
    [orderInfoView setCellItemValue:value withRow:index++];
    
    value = [netData objectForKey:@"warehouse"];
    [orderInfoView setCellItemValue:value withRow:index++];
    
    
   
    value = [netData objectForKey:@"note"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
