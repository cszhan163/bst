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
    [self setHiddenRightBtn:YES];
    [self setNavgationBarTitle:@"物资信息"];
    CGFloat currY = kMBAppTopToolBarHeight;
    CGFloat height = 480.f;
    
    UIImageWithFileName(UIImage *image , @"bid_goods_detail_bg.png");
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10.f,kPendingY+kMBAppTopToolBarHeight,kDeviceScreenWidth-20.f,kDeviceScreenHeight-kMBAppBottomToolBarHeght-kMBAppTopToolBarHeight-kMBAppStatusBar-40.f)];
    imageView.image= image;
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    SafeRelease(imageView);
    
    UIScrollView *bgScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0.f,10.f,imageView.frame.size.width,imageView.frame.size.height-20.f)];
    bgScrollerView.backgroundColor = [UIColor clearColor];
    bgScrollerView.scrollEnabled = YES;
    bgScrollerView.bounces = NO;
    [imageView addSubview:bgScrollerView];
    SafeRelease(bgScrollerView);
    
    
    CGFloat width = bgScrollerView.frame.size.width-2*kPendingX;
    //CGFloat height = bgScrollerView.frame.size.height-20.f;
    bgScrollerView.contentSize = CGSizeMake(bgScrollerView.frame.size.width,height);
    LeftTitleListCell *orderInfoView = [[LeftTitleListCell alloc]initWithGoodsDetailFrame:CGRectMake(kPendingX,20.f,width,height) withTitleArray:kOrderTitleArray withTitle:@"" withValueAtrArray:@[] withItemPending:25.f];
    [orderInfoView setXStartLeftPendingX:20.f];
    //[orderInfoView   ];
    orderInfoView.backgroundColor = [UIColor clearColor];
    [bgScrollerView addSubview:orderInfoView];
    SafeRelease(orderInfoView);
    
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
    value = [NSString stringWithFormat:@"%0.2lf 吨",[value floatValue]];
    [orderInfoView setCellItemValue:value withRow:index++];
    //bjtd
    value = [netData objectForKey:@"auctionMode"];
    if([value intValue] == 1){
        [orderInfoView setTitleHidden:NO withIndex:index];
        value = [netData objectForKey:@"bjtd"];
        value  = [NSString stringWithFormat:@"%0.2lf 元",[value floatValue]];
        //[cell setCellItemValue:value withIndex:index++];
        [orderInfoView setCellItemValue:value withRow:index++];
        
    }
    else{
        
        [orderInfoView setTitleHidden:YES withIndex:index++];
    }
    value = [netData objectForKey:@"startPrice"];
    value = [NSString stringWithFormat:@"%0.2lf 元",[value floatValue]];
    [orderInfoView setCellItemValue:value withRow:index++];
    
    value = [netData objectForKey:@"packages"];
    [orderInfoView setCellItemValue:value withRow:index++];
    
    value = [netData objectForKey:@"place"];
    [orderInfoView setCellItemValue:value withRow:index++];
    //place
    value = [netData objectForKey:@"payment"];
    [orderInfoView setCellItemValue:value withRow:index++];
    
    value = [netData objectForKey:@"auctionStatus"];
    NSString *statusStr = @"";
    if([value intValue] == 1){
        statusStr = @"未开始";
    }
    else if([value intValue] == 3){
        statusStr = @"已结束";   
    }
    else {
        statusStr = @"已开始";
    }
    [orderInfoView setCellItemValue:statusStr withRow:index++];

    
    
    value = [netData objectForKey:@"deliveryTime"];
    
    [orderInfoView setCellItemValue:value withRow:index++];
    
 
    
    value = [netData objectForKey:@"QS"];
    [orderInfoView setCellItemValue:value withRow:index++];
   
    
    
    value = [netData objectForKey:@"deliveryWay"];
    [orderInfoView setCellItemValue:value withRow:index++];
    
    value = [netData objectForKey:@"warehouse"];
    [orderInfoView setCellItemValue:value withRow:index++];
    
    
   
    value = [netData objectForKey:@"note"];
    [orderInfoView setCellItemValue:value withRow:index++];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
