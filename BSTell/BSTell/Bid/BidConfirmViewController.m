//
//  BidConfirmViewController.m
//  BSTell
//
//  Created by cszhan on 14-2-1.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "BidConfirmViewController.h"
#import "BidMainViewController.h"

@interface BidConfirmViewController ()

@end

@implementation BidConfirmViewController

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
    tweetieTableView.hidden = YES;
    
    CGFloat currY = kMBAppTopToolBarHeight;
    UILabel *headerView = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:18.f] withTextColor:[UIColor blackColor] withText:@"交易保证金相关说明" withFrame:CGRectMake(0.f,currY,kDeviceScreenWidth,44.f)];
    headerView.backgroundColor = HexRGB(190, 221, 238);
    [self.view addSubview:headerView];
    SafeRelease(headerView);
    
    
    
    currY = currY+60.f;
    
    UIImageWithFileName(UIImage *image , @"bid_confirm_bg.png");
    
    UIImageView *confirmTextBgView = [[UIImageView alloc]initWithFrame:CGRectMake(10.f, currY, image.size.width/kScale, image.size.height/kScale)];
    confirmTextBgView.image = image;
    [self.view addSubview:confirmTextBgView];
    SafeRelease(confirmTextBgView);
    
    currY = currY + image.size.height/kScale+ 10.f;
    
    UIButton *okBtn = [UIComUtil createButtonWithNormalBGImageName:@"bid_confirm_btn.png" withHightBGImageName:@"bid_confirm_btn.png" withTitle:@"同意" withTag:0];
    
    UIButton *failedBtn  = [UIComUtil createButtonWithNormalBGImageName:@"bid_confirm_btn.png" withHightBGImageName:@"bid_confirm_btn.png" withTitle:@"不同意" withTag:1];
    
    okBtn.frame = CGRectMake(40.f, currY, okBtn.frame.size.width, okBtn.frame.size.height);
    [self.view addSubview:okBtn];
    
    [okBtn addTarget:self action:@selector(pressConfirmButton:) forControlEvents:UIControlEventTouchUpInside];
    failedBtn.frame = CGRectMake(160.f, currY, okBtn.frame.size.width, okBtn.frame.size.height);
    [self.view addSubview:failedBtn];
    [failedBtn addTarget:self action:@selector(pressConfirmButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}
- (void)pressConfirmButton:(id)sender{

    if([sender tag] == 0){
        BidMainViewController *bidMainVc = [[BidMainViewController alloc]init];
        [self.navigationController pushViewController:bidMainVc animated:YES];
        SafeRelease(bidMainVc);
    
    }
    else{
    
        [self.navigationController popViewControllerAnimated:YES];
    }

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
