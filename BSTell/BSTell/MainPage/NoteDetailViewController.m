//
//  NoteDetailViewController.m
//  BSTell
//
//  Created by cszhan on 14-2-1.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "NoteDetailViewController.h"
#define  kLeftPendingX 20.f
@interface NoteDetailViewController (){
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
    
    CGFloat currY = kMBAppTopToolBarHeight;
    headerView = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:18.f] withTextColor:[UIColor blackColor] withText:@"1月21日15:30上海公司32交易保证金相关说明" withFrame:CGRectMake(0.f,currY,kDeviceScreenWidth,44.f)];
    headerView.backgroundColor = HexRGB(190, 221, 238);
    [self.view addSubview:headerView];
    SafeRelease(headerView);
    
    
    contentTextView = [[UITextView alloc]initWithFrame:CGRectMake(kLeftPendingX,currY+headerView.frame.size.height,kDeviceScreenWidth-2*kLeftPendingX, 250.f)];
    contentTextView.font = [UIFont systemFontOfSize:10];
    contentTextView.editable = NO;
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
    else{
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
}
-(void)didNetDataOK:(NSNotification*)ntf
{
    
    
    
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];//[respRequest resourceKey];
    //NSString *resKey = [respRequest resourceKey];
    if(([resKey isEqualToString:kResNoteNewsDetail]&& self.type == Note_New)||
       ([resKey isEqualToString:kResNoteBidDetail]&&self.type == Note_Bid))
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
    headerText = [netData objectForKey:@"ggmc"];
    contentText = [netData objectForKey:@"txt"];
    contentTextView.text = contentText;
    headerView.text = headerText;
    
    NSString *moneyValue = [netData objectForKey:@"dfyj"];
    /*
    bidMoneyLabel.text = [NSString stringWithFormat:@"您的竞价所需锁定的保证金: %@ 元",moneyValue];
    //您的帐户上的自由资金余额:             元
    moneyValue = [netData objectForKey:@"kyye"];
    accoutMoneyLabel.text = [NSString stringWithFormat:@"您的帐户上的自由资金余额: %@ 元",moneyValue];
    */
}

@end
