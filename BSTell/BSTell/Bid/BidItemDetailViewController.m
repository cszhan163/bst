//
//  BidItemDetailViewController.m
//  BSTell
//
//  Created by cszhan on 14-2-9.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "BidItemDetailViewController.h"
#import "LeftTitleListCell.h"
@interface BidItemDetailViewController (){

    LeftTitleListCell *leftTitleCellView;

}
@end

@implementation BidItemDetailViewController

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
    
    CGFloat currY = kMBAppTopToolBarHeight;
    UILabel *headerView = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:18.f] withTextColor:[UIColor blackColor] withText:@"交易保证金相关说明" withFrame:CGRectMake(0.f,currY,kDeviceScreenWidth,44.f)];
    headerView.backgroundColor = HexRGB(190, 221, 238);
    [self.view addSubview:headerView];
    SafeRelease(headerView);
    
    
    
    currY = currY+60.f;
    
    UIImageWithFileName(UIImage *image , @"bid_confirm_bg.png");
    
    UIImageView *confirmTextBgView = [[UIImageView alloc]initWithFrame:CGRectMake(10.f, currY, image.size.width/kScale, image.size.height/kScale)];
    confirmTextBgView.image = image;
    confirmTextBgView.userInteractionEnabled = YES;
    
    /*
   
  
    */
    leftTitleCellView = [[LeftTitleListCell alloc] initWithFrame:CGRectMake(0.f, 0.f, 300.f, 300.f) withTitleArray:@[@"物资编号",
                                                                                                                      @"资源数",
                                                                                                                      @"起拍价",
                                                                                                                      @"当前价",
                                                                                                                      @"我的出价",
                                                                                                                      @"结束时间",
                                                                                                                      @"报盘方式",
                                                                                                                      @"拼盘梯度",
                                                                                                                      @"品名",
                                                                                                                     @"包装",
                                                                                                                     @"产地",
                                                                                                                     @"仓库",
                                                                                                                     @"重量",
                                                                                                                     @"计量单位",
                                                                                                                     @"质量标准",
                                                                                                                     @"备注",
                                                                                                                     @"附件",
                                                                                                                     @"竞价状态",
                                                                                                                     @"计价单位",
                                                                                                                     @"场次名称",
                                                                                                                     ]];
    
    [confirmTextBgView addSubview:leftTitleCellView];
    leftTitleCellView.backgroundColor = [UIColor clearColor];
    SafeRelease(leftTitleCellView);

    [self.view addSubview:confirmTextBgView];
    SafeRelease(confirmTextBgView);
    
    
    
                                            
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-
#pragma mark -net data
- (void) shouldLoadData{
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           //catStr,@"cat",
                           @"001",@"hydm",
                           @"10",@"id",
                           nil];
    CarServiceNetDataMgr *carServiceNetDataMgr = [CarServiceNetDataMgr getSingleTone];
    self.request = [carServiceNetDataMgr  queryAuctionPpInfo4Move:param];
}
-(void)didNetDataOK:(NSNotification*)ntf
{
    
    
    
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];//[respRequest resourceKey];
    //NSString *resKey = [respRequest resourceKey];
    if([resKey isEqualToString:kResBidItemData])
    {
        //        if ([self.externDelegate respondsToSelector:@selector(commentDidSendOK:)]) {
        //            [self.externDelegate commentDidSendOK:self];
        //        }
        //        kNetEndSuccStr(@"评论成功",self.view);
        //        [self dismissModalViewControllerAnimated:YES];
        
        
        
        [self performSelectorOnMainThread:@selector(updateUIData:) withObject:data waitUntilDone:NO];
        
    }
    
    //self.view.userInteractionEnabled = YES;
}
- (void)updateUIData:(NSDictionary*)netData{
    kNetEnd(self.view);
    
    int index = 0;
    int row = 0;
    NSString *value = @"";
    /*
     
    
     QS	质量标准
     note	备注
    
     
     priceUnit	计价单位
     wtmc	场次名称
     */
   
    NSDictionary *item = netData;
    //id
    value = [item objectForKey:@"wtmc"];
    //[cell setCellItemValue:value withIndex:index++];
    [leftTitleCellView setCellItemValue:value withRow:row++];
    //
    value = [item objectForKey:@"goodid"];
    [leftTitleCellView setCellItemValue:value withRow:row++];
    
    //sell company
    value = [item objectForKey:@"zys"];
    
    [leftTitleCellView setCellItemValue:value withRow:row++];
    
    //sell company
    value = [item objectForKey:@"goodName"];
    
    [leftTitleCellView setCellItemValue:value withRow:row++];
    
    //sell company
    value = [item objectForKey:@"package"];
    
    [leftTitleCellView setCellItemValue:value withRow:row++];
    
    //sell company
    value = [item objectForKey:@"place"];
    
    [leftTitleCellView setCellItemValue:value withRow:row++];
    
    //sell company
    value = [item objectForKey:@"QS"];
    
    [leftTitleCellView setCellItemValue:value withRow:row++];
    
    //sell company
    /*
     weight	重量
     unit	计量单位
     */
    value = [item objectForKey:@"weight"];
    
    [leftTitleCellView setCellItemValue:value withRow:row++];
    
    //sell company  	附件
    value = [item objectForKey:@"unit"];
    
    [leftTitleCellView setCellItemValue:value withRow:row++];
    
    //sell company
    value = [item objectForKey:@"warehouse"];
    
    [leftTitleCellView setCellItemValue:value withRow:row++];
    
    //sell company
    value = [item objectForKey:@"attachment"];
    
    [leftTitleCellView setCellItemValue:value withRow:row++];
    
    //sell company 	竞价状态
    value = [item objectForKey:@"auctionStatus"];
    
    [leftTitleCellView setCellItemValue:value withRow:row++];
    
    /*
    jssj	结束时间
    bpfs	报盘方式
    bjtd	拼盘梯度
    */
    //sell company 	竞价状态
    value = [item objectForKey:@"jssj"];
    
    [leftTitleCellView setCellItemValue:value withRow:row++];
    
    
    //sell company 	竞价状态
    value = [item objectForKey:@"bpfs"];
    
    [leftTitleCellView setCellItemValue:value withRow:row++];
    
    
    //sell company 	竞价状态
    value = [item objectForKey:@"bjtd"];
    
    [leftTitleCellView setCellItemValue:value withRow:row++];
    
    //sell company 	竞价状态
    /*
     	起拍价
          */
    value = [item objectForKey:@"qpj"];
    
    [leftTitleCellView setCellItemValue:value withRow:row++];
    
    //sell company 	竞价状态 	当前价
    value = [item objectForKey:@"dqj"];
    
    [leftTitleCellView setCellItemValue:value withRow:row++];
    
    /*
     我的出价
     */
    value = [item objectForKey:@"myPrice"];
    
     [leftTitleCellView setCellItemValue:value withRow:row++];
    
    /*
     	竞价状态
     	计价单位
     */
    value = [item objectForKey:@"auctionStatus"];
    
    [leftTitleCellView setCellItemValue:value withRow:row++];
    
    value = [item objectForKey:@"priceUnit"];
    
    [leftTitleCellView setCellItemValue:value withRow:row++];
    
    
    value = [item objectForKey:@"note"];
    
    [leftTitleCellView setCellItemValue:value withRow:row++];
    
    
}
-(void)didNetDataFailed:(NSNotification*)ntf
{
    //kNetEndWithErrorAutoDismiss
}

@end
