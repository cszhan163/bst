//
//  SearchViewController.m
//  BSTell
//
//  Created by cszhan on 14-2-26.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

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
    
    UIView *heardView = [[UIView alloc]initWithFrame:CGRectMake(0.f, kMBAppBottomToolBarHeght,kDeviceScreenWidth, 44.f)];
    
    //[self.view addSubview:heardView];
    
    UITextField *searchField = [[UITextField alloc]initWithFrame:CGRectMake(0.f,0.f, kDeviceScreenWidth-50.f, 44.f)];
    
    searchField.borderStyle = UITextBorderStyleRoundedRect;
    searchField.delegate = self;
    searchField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    searchField.font = kAppTextSystemFont(16);//[UIFont systemFontOfSize:40];
    searchField.textColor = [UIColor blackColor];
    searchField.adjustsFontSizeToFitWidth = NO;
    searchField.text = @"";
    searchField.delegate = self;
    [heardView addSubview:searchField];
#if 0
    UIButton *searchBtn = [UIComUtil createButtonWithNormalBGImageName:@"" withHightBGImageName:@"" withTitle:@"" withTag:0];
    searchBtn.frame = CGRectMake(kDeviceScreenWidth-40.f,0.f,searchBtn.frame.size.width, searchBtn.frame.size.height);
    [searchBtn addTarget:self action:@selector(searchStart:) forControlEvents:UIControlEventTouchUpInside];
    [heardView addSubview:searchBtn];
#endif
    [tweetieTableView setTableHeaderView:heardView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    

}
- (void)searchStart:(id)sender{
    
    
}
@end
