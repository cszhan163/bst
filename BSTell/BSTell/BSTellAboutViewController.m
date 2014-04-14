//
//  BSTellAboutViewController.m
//  BSTell
//
//  Created by cszhan on 14-4-12.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "BSTellAboutViewController.h"

#define kLeftPendingX 20.f

@interface BSTellAboutViewController ()

@end

@implementation BSTellAboutViewController

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
    
     [self setHiddenRightBtn:YES];
    CGFloat currY = 60.f;
    UITextView *contentTextView = [[UITextView alloc]initWithFrame:CGRectMake(kLeftPendingX,currY,kDeviceScreenWidth-2*kLeftPendingX,kDeviceScreenHeight-kMBAppStatusBar-kMBAppBottomToolBarHeght-currY)];
    contentTextView.font = [UIFont systemFontOfSize:15];
    contentTextView.editable = NO;
    contentTextView.backgroundColor = [UIColor clearColor];
    //contentTextView.scrollEnabled = YES;
    [self.view addSubview:contentTextView];
    contentTextView.text = @"    “化工宝”手机应用开启了全新的竞价之旅，给您带来不一样的体验。无论何时何地，您只需轻轻一点，就能轻松竞价。在这里，海量资讯与网站同步，您不仅能够得到最新资讯，还可以快速查阅历史数据、分析以及价格预测，让您全面了解行业资讯，更好洞察市场走向，在瞬息万变的市场中决胜千里。";
    SafeRelease(contentTextView);
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
