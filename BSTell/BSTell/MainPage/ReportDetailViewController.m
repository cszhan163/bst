//
//  ReportDetailViewController.m
//  BSTell
//
//  Created by cszhan on 14-4-7.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "ReportDetailViewController.h"

@interface ReportDetailViewController ()

@end

@implementation ReportDetailViewController

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
    [self setNavgationBarTitle:@"报告详细内容"];
    [self loadImageData:self.data];
    
}
- (void)loadImageData:(NSDictionary*)netData{
    
    NSString *headerText = @"";
    NSString *contentText = @"";
    NSString *moneyValue = @"";
    //if(self.type == Note_Info)
    {
        headerText = [netData objectForKey:@"zxreporttitle"];
        contentText = [netData objectForKey:@"zxreporturl"];
        moneyValue = [netData objectForKey:@"zxreportpubdate"];
    }
    contentText = @"http://img1.cache.netease.com/cnews/2014/4/9/20140409153921a3da7_550.jpg";
#if 0
    contentTextView.text = contentText;
#else
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:contentText]];
    [contentTextView loadRequest:request];
    //contentTextView.scalesPageToFit = YES;
#endif
    headerView.text = headerText;
    
    //moneyValue = [netData objectForKey:@"fbsj"];
    timeLabel.text = moneyValue;
    /*
     bidMoneyLabel.text = [NSString stringWithFormat:@"您的竞价所需锁定的保证金: %@ 元",moneyValue];
     //您的帐户上的自由资金余额:             元
     moneyValue = [netData objectForKey:@"kyye"];
     accoutMoneyLabel.text = [NSString stringWithFormat:@"您的帐户上的自由资金余额: %@ 元",moneyValue];
     */


    //[contentTextView loadHTMLString:<#(NSString *)#> baseURL:<#(NSURL *)#>
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end