//
//  OrderListConfirmedViewController.m
//  BSTell
//
//  Created by cszhan on 14-3-30.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "OrderListConfirmedViewController.h"

@interface OrderListConfirmedViewController ()

@end

@implementation OrderListConfirmedViewController

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
}

- (void) shouldLoadOlderData:(NTESMBTweetieTableView *) tweetieTableView
{
    NSDictionary *param  = nil;
    CarServiceNetDataMgr *carServiceNetDataMgr = [CarServiceNetDataMgr getSingleTone];
    {
        /*
         公告ID	ggid
         会员代码	hydm
         */
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 [NSString stringWithFormat:@"%d",self.pageNum],@"offset",
                 //@"1",@"zc",
                 //@"",@"wtzt",
                 self.userId,@"hydm",
                 @"10",@"limit",
                 [NSString stringWithFormat:@"%d",1],@"confirmflag",
                 //@"",@"rqStart",
                 //@"",@"rqEnd",
                 nil];
        self.request = [carServiceNetDataMgr  getOrderListConfirmed:param];
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)didNetDataOK:(NSNotification*)ntf
{
    //[super didNetDataOK:ntf];
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];//[respRequest resourceKey];
    //NSString *resKey = [respRequest resourceKey];
    if([resKey isEqualToString:kCarUserOrderComfirmedList])
    {
        //        if ([self.externDelegate respondsToSelector:@selector(commentDidSendOK:)]) {
        //            [self.externDelegate commentDidSendOK:self];
        //        }
        //        kNetEndSuccStr(@"评论成功",self.view);
        //        [self dismissModalViewControllerAnimated:YES];
        
        [self reloadNetData:data];
        self.pageNum = self.pageNum +1;
        [self performSelectorOnMainThread:@selector(updateUIData:) withObject:data waitUntilDone:NO];
        
    }
}
@end
