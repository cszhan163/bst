//
//  NoteDetailViewController.m
//  BSTell
//
//  Created by cszhan on 14-2-1.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "NoteDetailViewController.h"
#define  kLeftPendingX 10.f



@interface NoteDetailViewController (){\
    UILabel    *timeLabel;
    UITextView *contentTextView;
    UILabel *headerView;

}
@end

@implementation NoteDetailViewController

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
    //tweetieTableView.hidden = YES;
    [self setHiddenRightBtn:YES];
    CGFloat currY = kMBAppTopToolBarHeight;
    headerView = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:18.f] withTextColor:[UIColor blackColor] withText:@"" withFrame:CGRectMake(0.f,currY,kDeviceScreenWidth,44.f)];
    headerView.backgroundColor = HexRGB(190, 221, 238);
    [self.view addSubview:headerView];
    SafeRelease(headerView);
    
    currY =  currY+headerView.frame.size.height+10.f;
    timeLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:12.f] withTextColor:[UIColor blackColor] withText:@"" withFrame:CGRectMake(0.f,currY,kDeviceScreenWidth,15.f)];
    timeLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:timeLabel];
    SafeRelease(timeLabel);
    
    currY = currY+timeLabel.frame.size.height+10.f;
    contentTextView = [[UITextView alloc]initWithFrame:CGRectMake(kLeftPendingX,currY,kDeviceScreenWidth-2*kLeftPendingX,kDeviceScreenHeight-kMBAppStatusBar-kMBAppBottomToolBarHeght-currY)];
    contentTextView.font = [UIFont systemFontOfSize:15];
    contentTextView.editable = NO;
    contentTextView.backgroundColor = [UIColor clearColor];
    //contentTextView.scrollEnabled = YES;
    [self.view addSubview:contentTextView];
    SafeRelease(contentTextView);

	// Do any additional setup after loading the view.
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
    if(self.type == Note_New){
        /*
         公告ID	ggid
         会员代码	hydm
         */
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 self.noteId,@"ggid",
                 //@"1",@"zc",
                 //@"",@"wtzt",
                 //@"001",@"hydm",
                 //@"10",@"limit",
                 //@"",@"rqStart",
                 //@"",@"rqEnd",
                 nil];
        self.request = [carServiceNetDataMgr  getSitePubmsgById4Move:param];
    }
    else if(self.type == Note_Bid){
        /*
         gglx	公告类型		0  交易预告
         1  竞价公告
         2  市场公告
         zc	专场类型（循环物资，钢材正品）		1 钢材正品
         2 循环物资
         */
        
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 self.noteId,@"ggid",
                 //@"1",@"zc",
                 //@"",@"wtzt",
                 //@"001",@"hydm",
                 self.userId,@"hydm",
                 //@"",@"rqStart",
                 //@"",@"rqEnd",
                 nil];
        self.request = [carServiceNetDataMgr  getBidPubmsgById4Move:param];
        
    }
    else{
     
       /*
        @"001",@"systemId",
        @"10",@"zxid",
        */
        
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 self.noteId,@"zxid",
                 //@"1",@"zc",
                 //@"",@"wtzt",
                 //@"001",@"hydm",
                 @"keu89klW29f9S9323jj3",@"systemId",
                 //@"",@"rqStart",
                 //@"",@"rqEnd",
                 nil];
        self.request = [carServiceNetDataMgr  getHgbZXInfoDetail:param];
    }
}
-(void)didNetDataOK:(NSNotification*)ntf
{
    
    
    
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];//[respRequest resourceKey];
    //NSString *resKey = [respRequest resourceKey];
    if(([resKey isEqualToString:kResNoteNewsDetail]&& self.type == Note_New)||
       ([resKey isEqualToString:kResNoteBidDetail]&&self.type == Note_Bid)
       ||([resKey isEqualToString:kResNoteInfoDetail]&&self.type == Note_Info)
       //||([resKey isEqualToString:kResNoteBidDetail]&&self.type == Note_Bid)
       )
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
    /*
     new
     ggmc	公告title
     txt	公告内容
     */
    NSString *contentText = nil;
    NSString *headerText = nil;
    NSString *moneyValue = nil;
    /*
    if(self.type == Note_New){
        headerText = [netData objectForKey:@"ggmc"];
        contentText = [netData objectForKey:@"txt"];
    }
    else{
        headerText = [netData objectForKey:@"ggmc"];
        contentText = [netData objectForKey:@""];
    }
    */
    if(self.type == Note_Info){
        headerText = [netData objectForKey:@"zxtitle"];
        contentText = [netData objectForKey:@"zxdescription"];
        moneyValue = [netData objectForKey:@"zxpubdate"];
    }
    else{
        headerText = [netData objectForKey:@"ggmc"];
        contentText = [netData objectForKey:@"txt"];
        moneyValue = [netData objectForKey:@"fbsj"];
        moneyValue = [NSDate dateFormart:moneyValue fromFormart:@"YYYYMMddHHmmss" toFormart:@"YYYY-MM-dd HH:mm" ];
        
    }
    contentTextView.text = contentText;
    headerView.text = headerText;
    
    //moneyValue = [netData objectForKey:@"fbsj"];
    timeLabel.text = moneyValue;
    /*
    bidMoneyLabel.text = [NSString stringWithFormat:@"您的竞价所需锁定的保证金: %@ 元",moneyValue];
    //您的帐户上的自由资金余额:             元
    moneyValue = [netData objectForKey:@"kyye"];
    accoutMoneyLabel.text = [NSString stringWithFormat:@"您的帐户上的自由资金余额: %@ 元",moneyValue];
    */
}

@end
